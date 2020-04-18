package serviceTest;

import cleve.entity.User;
import cleve.service.UserService;
import com.alibaba.fastjson.JSON;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springMVC.xml"})

public class UserTest {

    @Autowired
    private UserService userService;

    @Test
    public void addUser()
    {
        User user = new User();
        user.setUserName("张三");
        user.setPassword("123456");
        user.setUserRole(1);
        user.setUserCredit(0);
        user.setUserBorrowNum(5);
        user.setUserSex(1);
        user.setUserEmail("5656482@qq.com");
        user.setUserPhone("16856645441");
        Timestamp createTime = new Timestamp(System.currentTimeMillis());
        user.setCreateTime(createTime);
        userService.addUser(user);
        User addUser = userService.findUserByUserName("张三");
        System.out.println(addUser.toString());
    }

    @Test
    public void updateUser()
    {
        int userID = userService.findUserByUserName("张三").getUserID();
        User user = userService.findUserByUserID(userID);
        user.setUserSex(0);
        user.setUserEmail("5646546@qq.com");
        user.setUserPhone("3454626464");
        userService.updateUser(user);
        User updateUser = userService.findUserByUserName("张三");
        System.out.println(updateUser.toString());
    }

    @Test
    public void getAllUser()
    {
        List<User> userList =userService.getAllUser();
        System.out.println(userList);
    }

    @Test
    public void deleteUserByUserID()
    {
        int userID = userService.findUserByUserName("张三").getUserID();
        userService.deleteUserByUserID(userID);
    }

    @Test
    public void deleteUserByUserName()
    {
        userService.deleteUserByUserName("张三");
    }


}
