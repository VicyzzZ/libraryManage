package cleve.controller;

import cleve.entity.Book;
import cleve.entity.Category;
import cleve.service.BookService;
import cleve.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.Iterator;
import java.util.List;

@Controller
public class MainController {
    private final CategoryService categoryService;
    private final BookService bookService;

    @Autowired
    public MainController(CategoryService categoryService, BookService bookService) {
        this.categoryService = categoryService;
        this.bookService = bookService;
    }

    /**
     * 主页
     *
     * @return 主页
     */
    @RequestMapping("/index")
    public String index() {
        return "index";
    }

    /**
     * 错误页
     *
     * @return 错误页
     */
    @RequestMapping("/error")
    public String error(String Msg,HttpServletRequest request)
    {
        request.setAttribute("Msg",Msg);
        return "error";
    }

    /**
     * 显示内容主页
     *
     * @param request 请求
     * @return 返回页面
     */
    @RequestMapping("/main")
    public String mainPage(HttpServletRequest request) {
        List<Book> bookList = bookService.getBookOfCategoryID(1);
        List<Category> categoryList = categoryService.getAllCategory();
        Category CurrentCategory = categoryService.findCategoryBycategoryID(1);
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("bookList", bookList);
        request.setAttribute("CurrentCategory", CurrentCategory);
        return "mainPage";
    }

    /**
     * 搜索
     *
     * @param request 请求
     * @return 返回页面
     */
    @RequestMapping("/search")
    public String search(HttpServletRequest request) {
        String bookName = request.getParameter("bookName");
        List<Book> bookList = bookService.getAllBooks();
        Iterator<Book> iterator = bookList.iterator();
        //移除不符合查找的书籍
        while (iterator.hasNext())
        {
            Book book = iterator.next();
            if(!(book.getBookName().contains(bookName)||bookName.contains(book.getBookName())))
            {
                iterator.remove();
            }
        }

        List<Category> categoryList = categoryService.getAllCategory();
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("bookList", bookList);
        request.setAttribute("bookName", bookName);
        return "mainPage";
    }

    /**
     * 显示用户登录页面
     *
     * @return 返回页面
     */
    @RequestMapping("/userLogin")
    public String userLogin() {
        return "User/Login";
    }

    /**
     * 显示注册页面
     *
     * @return 返回页面
     */
    @RequestMapping("/userRegister")
    public String userRegister() {
        return "User/Register";
    }



}
