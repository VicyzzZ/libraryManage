package cleve.controller;

import cleve.entity.User;
import cleve.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;

@Controller
@RequestMapping(value = "/user")
public class UserController {
    private final UserService userService;

    @Autowired
    public UserController(UserService userService) {
        this.userService = userService;
    }

    /**
     * 用户登录
     *
     * @param loginUser 登录的用户
     * @param request   请求
     * @return 返回页面
     */
    @RequestMapping(value = "/Login", method = RequestMethod.POST)
    public String userLogin(User loginUser, HttpServletRequest request) {
        // 通过用户名查找User对象
        User user = userService.findUserByUserName(loginUser.getUserName());
        String password = "";
        if (user != null) {
            password = userService.getUserPasswordByUserName(user.getUserName());
        }

        // 判断登录信息是否正确
        if (user == null) {
            request.setAttribute("Msg", "未找到该用户！");
        } else if(!loginUser.getPassword().equals(password))
        {
            request.setAttribute("Msg", "密码错误！");
        }else {
            // 登陆成功，跳转到主页
            request.getSession().setAttribute("user", user);
            return "redirect:/main";
        }

        // 登录失败，跳转页面
        return "error";
    }

    /**
     * 用户注册
     *
     * @param userRegister 注册的用户
     * @param request      请求
     * @return 返回页面
     */
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String userRegister(User userRegister, HttpServletRequest request) {
        User user = userRegister;
        if (user != null) {
            try {
                String username = user.getUserName();
                // 如果数据库中没有该用户，可以注册，否则跳转页面
                if (userService.findUserByUserName(username) == null) {
                    // 添加用户
                    user.setUserRole(1);
                    user.setUserBorrowNum(5);
                    user.setUserCredit(0);
                    Timestamp createLoginTime = new Timestamp(System.currentTimeMillis());
                    user.setCreateTime(createLoginTime);
                    userService.addUser(user);
                    // 注册成功跳转
                    return "index";
                } else {
                    request.setAttribute("Msg", "注册失败，用户名已被占用！");
                    return "error";
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("Msg", "不能为空！");
                return "error";
            }
        }

        request.setAttribute("Msg", "发生未知错误！");
        return "error";
    }

    /**
     * 显示个人信息
     *
     * @param userID 用户ID
     * @param request  请求
     * @return 返回页面
     */
    @RequestMapping(value = "/userInfo")
    public String listUserInfo(int userID, HttpServletRequest request) {
        request.removeAttribute("user");
        User user = userService.findUserByUserID(userID);
        request.setAttribute("user", user);
        return "User/UserInfo";
    }


    /**
     * 提交用户修改信息
     *
     * @param request    请求
     * @return 页面
     */
    @RequestMapping(value = "/updateUserInfo", method = RequestMethod.POST)
    public String updateUserInfo(HttpServletRequest request) {

        int userID = Integer.parseInt(request.getParameter("userID"));
        int userSex = Integer.parseInt(request.getParameter("userSex"));
        String userEmail = request.getParameter("userEmail");
        String userPhone = request.getParameter("userPhone");

        User userNew = userService.findUserByUserID(userID);
        userNew.setUserSex(userSex);
        userNew.setUserEmail(userEmail);
        userNew.setUserPhone(userPhone);
        userService.updateUser(userNew);

        request.setAttribute("user", userNew);
        return  "/User/UserInfo";
    }

    /**
     * 充值
     *
     * @param request    请求
     * @return 页面
     */
    @RequestMapping(value = "/recharge", method = RequestMethod.POST)
    public String recharge(HttpServletRequest request) {

        int userID = Integer.parseInt(request.getParameter("userID"));
        int userCredit = Integer.parseInt(request.getParameter("userCredit"));

        User user = userService.findUserByUserID(userID);
        user.setUserCredit(userCredit+user.getUserCredit());
        userService.updateUser(user);

        request.setAttribute("user", user);
        return "/User/UserInfo";
    }



    /**
     * 用户注销功能
     *
     * @param request 请求
     * @return 返回页面
     */
    @RequestMapping(value = "/loginOut")
    public String loginOut(HttpServletRequest request) {
        request.getSession().removeAttribute("user");
        return "index";
    }
}
