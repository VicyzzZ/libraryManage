package cleve.controller;

import cleve.entity.Book;
import cleve.entity.Category;
import cleve.entity.Log;
import cleve.entity.User;
import cleve.service.BookService;
import cleve.service.CategoryService;
import cleve.service.LogService;
import cleve.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
    private final CategoryService categoryService;
    private final BookService bookService;
    private final LogService logService;
    private final UserService userService;

    @Autowired
    public AdminController(CategoryService categoryService, BookService bookService, LogService logService, UserService userService) {
        this.categoryService = categoryService;
        this.bookService = bookService;
        this.logService = logService;
        this.userService = userService;
    }

    /**
     * 管理后台
     *
     */
    @RequestMapping("/manageCenter")
    public String manageCenter() {
        return "/Admin/ManageCenter";
    }

    /**
     * 管理分类
     *
     */
    @RequestMapping("/manageCategory")
    public String manageCategory(HttpServletRequest request) {
        List<Category> categoryList= categoryService.getAllCategory();
        request.setAttribute("categoryList",categoryList);
        return "/Admin/ManageCategory";
    }

    /**
     * 更新分类信息
     *
     */
    @RequestMapping("/UpdateCategory")
    public String UpdateCategory(Category category,HttpServletRequest request) {
        categoryService.updateCategory(category);
        List<Category> categoryList= categoryService.getAllCategory();
        request.setAttribute("categoryList",categoryList);
        return "/Admin/ManageCategory";
    }

    /**
     * 添加分类信息
     *
     */
    @RequestMapping("/AddCategory")
    public String AddCategory(Category category,HttpServletRequest request) {
        Category category1 = categoryService.findCategoryBycategoryName(category.getCategoryName());
        if(category1==null)
        {
            categoryService.addCategory(category);
        }else {
            request.setAttribute("Msg","已存在该分类!");
            return "error";
        }

        List<Category> categoryList= categoryService.getAllCategory();
        request.setAttribute("categoryList",categoryList);
        return "/Admin/ManageCategory";
    }

    /**
     * 管理书籍
     *
     */
    @RequestMapping("/manageBook")
    public String manageBook(HttpServletRequest request) {
        List<Book> bookList = bookService.getAllBooks();
        List<Category> categoryList = categoryService.getAllCategory();

        request.setAttribute("bookList",bookList);
        request.setAttribute("categoryList",categoryList);
        return "/Admin/ManageBook";
    }

    /**
     * 添加书籍
     *
     */
    @RequestMapping("/addBook")
    public String addBook(Book book,HttpServletRequest request) {

        if(book!=null)
        {
            if(bookService.findBookByBookID(book.getBookID())!=null)
            {
                request.setAttribute("Msg","书号已存在！");
                return "error";
            }
            if(bookService.findBookBybookName(book.getBookName())!=null)
            {
                request.setAttribute("Msg","书名已存在！");
                return "error";
            }
            book.setBookBorrowTimes(0);
            Timestamp currTime = new Timestamp(System.currentTimeMillis());
            book.setCreateTime(currTime);
            bookService.addBook(book);
        }
        List<Book> bookList = bookService.getAllBooks();
        List<Category> categoryList = categoryService.getAllCategory();
        request.setAttribute("bookList",bookList);
        request.setAttribute("categoryList",categoryList);
        return "/Admin/ManageBook";
    }

    /**
     * 更新书籍
     *
     */
    @RequestMapping("/updateBook")
    public String updateBook(Book updateBook,HttpServletRequest request) {

        Book book = bookService.findBookByBookID(updateBook.getBookID());
        book.setBookName(updateBook.getBookName());
        book.setBookAuthor(updateBook.getBookAuthor());
        book.setBookPublish(updateBook.getBookPublish());
        book.setBookPrice(updateBook.getBookPrice());
        book.setBookNum(updateBook.getBookNum());
        book.setBookCategoryID(updateBook.getBookCategoryID());
        book.setBookInfo(updateBook.getBookInfo());
        bookService.updateBook(book);

        List<Book> bookList = bookService.getAllBooks();
        List<Category> categoryList = categoryService.getAllCategory();
        request.setAttribute("bookList",bookList);
        request.setAttribute("categoryList",categoryList);
        return "/Admin/ManageBook";
    }

    /**
     * 删除书籍
     *
     */
    @RequestMapping("/deleteBook")
    public String deleteBook(String bookID,HttpServletRequest request) {
        List<Log> logList = logService.findLogBybookID(bookID);

        if(logList.isEmpty())
        {
            bookService.deleteBookBybookID(bookID);
            List<Book> bookList = bookService.getAllBooks();
            List<Category> categoryList = categoryService.getAllCategory();
            request.setAttribute("bookList",bookList);
            request.setAttribute("categoryList",categoryList);
            return "/Admin/ManageBook";
        }
        for(Log log:logList)
        {
            if(log.getState()==0||log.getState()==1)
            {
                request.setAttribute("Msg","还有用户借阅该书，无法下架！");
                return "error";
            }
        }

        bookService.deleteBookBybookID(bookID);
        List<Book> bookList = bookService.getAllBooks();
        List<Category> categoryList = categoryService.getAllCategory();
        request.setAttribute("bookList",bookList);
        request.setAttribute("categoryList",categoryList);
        return "/Admin/ManageBook";
    }

    /**
     * 管理用户
     *
     */
    @RequestMapping("/manageUser")
    public String manageUser(HttpServletRequest request) {
        List<User> userList = userService.getAllUser();
        request.setAttribute("userList",userList);

        return "/Admin/ManageUser";
    }

    /**
     * 管理日志
     *
     */
    @RequestMapping("/manageLog")
    public String manageLog(HttpServletRequest request) {
        return "/Admin/ManageLog";
    }


    /**
     * 管理未还书日志
     *
     */
    @RequestMapping("/unReturnLog")
    public String unReturnLog(HttpServletRequest request) {
        List<Log> logList = logService.getAllLog();

        Iterator<Log> iterator = logList.iterator();
        while (iterator.hasNext()) {
            Log log = iterator.next();
            if(log.getState()==2||log.getState()==3)
            {
                iterator.remove();
            }
        }
        List<User> userList = userService.getAllUser();
        List<Book> bookList = bookService.getAllBooks();
        request.setAttribute("bookList",bookList);
        request.setAttribute("userList",userList);
        request.setAttribute("logList",logList);
        return "/Admin/LogInformation";
    }

    /**
     * 管理已还书日志
     *
     */
    @RequestMapping("/ReturnLog")
    public String ReturnLog(HttpServletRequest request) {
        List<Log> logList = logService.getAllLog();

        Iterator<Log> iterator = logList.iterator();
        while (iterator.hasNext()) {
            Log log = iterator.next();
            if(log.getState()==0||log.getState()==1)
            {
                iterator.remove();
            }
        }
        List<User> userList = userService.getAllUser();
        List<Book> bookList = bookService.getAllBooks();
        request.setAttribute("bookList",bookList);
        request.setAttribute("userList",userList);
        request.setAttribute("logList",logList);
        int Return=1;
        request.setAttribute("Return",Return);
        return "/Admin/LogInformation";
    }

    /**
     * 管理逾期日志
     *
     */
    @RequestMapping("/overLog")
    public String overLog(HttpServletRequest request) {
        List<Log> logList = logService.getAllLog();

        Iterator<Log> iterator = logList.iterator();
        while (iterator.hasNext()) {
            Log log = iterator.next();
            Timestamp currTime = new Timestamp(System.currentTimeMillis());
            long time = (log.getBorrowLong()*1000*60*60*24);
            int overTime = (int)(currTime.getTime()-log.getBorrowTime().getTime()-time);
            if (overTime<0 || log.getState()==1 || log.getState()==2 ||log.getState()==3 ) {
                iterator.remove();
            }
        }
        List<User> userList = userService.getAllUser();
        List<Book> bookList = bookService.getAllBooks();
        request.setAttribute("bookList",bookList);
        request.setAttribute("userList",userList);
        request.setAttribute("logList",logList);
        int over=1;
        request.setAttribute("over",over);
        return "/Admin/LogInformation";
    }

    /**
     * 罚款
     *
     */
    @RequestMapping("/charge")
    public String charge(HttpServletRequest request) {
        Integer logID = Integer.parseInt(request.getParameter("logID"));
        Log log = logService.findLogByLogID(logID);
        Integer credit = (int)Double.parseDouble(request.getParameter("credit"));

        log.setCredit(credit);
        log.setState(log.getState()+1);
        logService.updateLog(log);

        return "redirect:/admin/overLog";
    }
}
