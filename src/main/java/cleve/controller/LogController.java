package cleve.controller;

import cleve.entity.Book;
import cleve.entity.Log;
import cleve.entity.User;
import cleve.service.BookService;
import cleve.service.LogService;
import cleve.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping(value = "/log")
public class LogController {
    private final LogService logService;
    private final BookService bookService;
    private final UserService userService;

    @Autowired
    public LogController(LogService logService, BookService bookService, UserService userService) {
        this.logService = logService;
        this.bookService = bookService;
        this.userService = userService;
    }

    /**
     * 借书
     *
     * @param borrowLog
     * @return
     */
    @RequestMapping(value = "/borrowBook",method = RequestMethod.POST)
    public String borrowBook(Log borrowLog, HttpServletRequest request) {

        String bookID = borrowLog.getBookID();
        Book book = bookService.findBookByBookID(bookID);
        int userID = borrowLog.getUserID();
        User user = userService.findUserByUserID(userID);

        int flag=0;
        List<Log> logList = logService.findLogByUserID(userID);
        if(logList.isEmpty())
        {
            flag=1;
           // System.out.println(flag+"未借书");
        }else
        {
            for (Log HaveLog:logList)
            {
                //System.out.println(HaveLog.toString());
                if(!HaveLog.getBookID().equals(bookID))
                {
                    flag=1;
                   //System.out.println(flag+"未借此书");
                }
                else {
                    flag=0;
                    if(HaveLog.getState()==0||HaveLog.getState()==1)
                    {
                        flag=0;
                        //System.out.println(flag+"未还书");
                        //System.out.println(HaveLog.toString());
                        break;
                    }else {
                        flag=1;
                        //System.out.println(flag+"已还书");
                    }
                }
            }
        }

        //System.out.println(flag+"最终");
        if(flag==1)
        {
            Log log=borrowLog;
            if(log != null)
            {
                if(book.getBookNum()<=0){
                    request.setAttribute("Msg", "该书籍已被借阅一空！");
                    return "error";
                }else if(user.getUserBorrowNum()<=0)
                {
                    request.setAttribute("Msg", "您的借阅数量已达最大，请还书后再进行借阅！");
                    return "error";
                }else{
                    Timestamp curTime = new Timestamp(System.currentTimeMillis());
                    log.setBorrowTime(curTime);
                    log.setState(0);
                    log.setCredit(0);
                    logService.addLog(log);

                    //更新书籍信息
                    book.setBookNum(book.getBookNum()-1);
                    book.setBookBorrowTimes(book.getBookBorrowTimes()+1);
                    bookService.updateBook(book);
                    book = bookService.findBookByBookID(bookID);

                    //更新读者信息
                    user.setUserBorrowNum(user.getUserBorrowNum()-1);
                    userService.updateUser(user);

                    request.setAttribute("book", book);
                    return "/Book/BookInfo";
                }
            }
        }

        request.setAttribute("Msg", "您已经借阅了本书！");
        return "error";
    }

    /**
     * 查看借阅记录
     *
     * @param userID
     * @return
     */
    @RequestMapping(value = "/borrowLog")
    public String borrowLog(int userID, HttpServletRequest request) {

        List<Log> logList = logService.findLogByUserID(userID);
        List<Book> bookList =bookService.getAllBooks();

        Iterator<Log> iterator = logList.iterator();
        while (iterator.hasNext())
        {
            Log log = iterator.next();
            Book book = bookService.findBookByBookID(log.getBookID());
            if(book==null)
            {
                logService.deleteLog(log);
                iterator.remove();
            }
        }

        request.setAttribute("logList", logList);
        request.setAttribute("bookList", bookList);
        request.setAttribute("unReturn", 0);
        return "/Log/LogInfo";
    }

    /**
     * 查看未还记录
     *
     * @param userID
     * @return
     */
    @RequestMapping(value = "/unReturnLog")
    public String unReturnLog(int userID, HttpServletRequest request) {

        List<Log> logList = logService.findLogByUserID(userID);
        List<Book> bookList = bookService.getAllBooks();

        Iterator<Log> iterator = logList.iterator();
        while (iterator.hasNext())
        {
            Log log = iterator.next();
            Book book = bookService.findBookByBookID(log.getBookID());
            if(book==null)
            {
                logService.deleteLog(log);
                iterator.remove();
            }
            if(log.getState()==2||log.getState()==3)
            {
                iterator.remove();
            }
        }

        request.setAttribute("logList", logList);
        request.setAttribute("bookList", bookList);
        return "/Log/LogInfo";
    }

    /**
     * 查看已还记录
     *
     * @param userID
     * @return
     */
    @RequestMapping(value = "/ReturnLog")
    public String ReturnLog(int userID, HttpServletRequest request) {

        List<Log> logList = logService.findLogByUserID(userID);
        List<Book> bookList = bookService.getAllBooks();

        Iterator<Log> iterator = logList.iterator();
        while (iterator.hasNext())
        {
            Log log = iterator.next();
            Book book = bookService.findBookByBookID(log.getBookID());
            if(book==null)
            {
                logService.deleteLog(log);
                iterator.remove();
            }
            if(log.getState()==0||log.getState()==1)
            {
                iterator.remove();
            }
        }

        request.setAttribute("logList", logList);
        request.setAttribute("bookList", bookList);
        request.setAttribute("unReturn", 0);
        return "/Log/LogInfo";
    }

    /**
     * 查看逾期记录
     *
     * @param userID
     * @return
     */
    @RequestMapping(value = "/overLog")
    public String overLog(int userID, HttpServletRequest request) {

        List<Log> logList = logService.findLogByUserID(userID);

        Iterator<Log> iterator = logList.iterator();
        while (iterator.hasNext()) {
            Log log = iterator.next();
            Timestamp currTime = new Timestamp(System.currentTimeMillis());
            long time = (log.getBorrowLong()*1000*60*60*24);
            int overTime = (int)(currTime.getTime()-log.getBorrowTime().getTime()-time);
            if (overTime<0 || log.getState()==2 ||log.getState()==3) {
                iterator.remove();
            }
        }

        List<Book> bookList = new ArrayList<>();

        for(Log log:logList)
        {
            Book book = bookService.findBookByBookID(log.getBookID());

            int flag=0;
            for(Book temp:bookList)
            {
                if(temp.getBookID().equals(book.getBookID()))
                {
                    flag=1;
                    //System.out.println("1");
                }
            }
            if(flag==0)
            {
                bookList.add(book);
                //System.out.println("0");
            }
        }

        request.setAttribute("logList", logList);
        request.setAttribute("bookList", bookList);
        return "/Log/LogInfo";
    }

    /**
     * 还书
     *
     * @param logID
     * @return
     */
    @RequestMapping(value = "/returnBook")
    public String returnBook(int logID, RedirectAttributes redirectAttributes) {

        Log log = logService.findLogByLogID(logID);

        if(log != null && (log.getState()==0||log.getState()==1))
        {
            //更新书籍信息
            Book book = bookService.findBookByBookID(log.getBookID());
            book.setBookNum(book.getBookNum()+1);
            bookService.updateBook(book);
            //还书
            Timestamp currTime = new Timestamp(System.currentTimeMillis());
            log.setReturnTime(currTime);
            log.setState(log.getState()+2);
            logService.updateLog(log);

            if(log.getCredit()>0)
            {
                redirectAttributes.addAttribute("Msg", "已还书，请缴纳罚款(未缴纳则占用借书数量!)");
                return "redirect:/error";
            }else{
                //更新用户信息
                User user = userService.findUserByUserID(log.getUserID());
                user.setUserBorrowNum(user.getUserBorrowNum()+1);
                userService.updateUser(user);
            }

            return "redirect:/log/borrowLog?userID="+log.getUserID();
        }

        redirectAttributes.addAttribute("Msg", "还书失败！");
        return "redirect:/error";
    }

    /**
     * 缴纳罚金
     *
     * @param logID
     * @return
     */
    @RequestMapping(value = "/pay")
    public String pay(int logID, RedirectAttributes redirectAttributes) {

        Log log = logService.findLogByLogID(logID);

        if(log != null && (log.getState()==0||log.getState()==2) && log.getCredit()>0)
        {
            User user = userService.findUserByUserID(log.getUserID());
            int credit=log.getCredit();
            if(user.getUserCredit()>=credit)
            {
                user.setUserCredit(user.getUserCredit()-credit);
            }else {
                redirectAttributes.addAttribute("Msg", "您的余额不足，请先充值！");
                return "redirect:/error";
            }
            if(log.getState()==2)
            {
                user.setUserBorrowNum(user.getUserBorrowNum()+1);
            }
            userService.updateUser(user);

            log.setCredit(0);
            log.setState(log.getState()+1);
            logService.updateLog(log);

            return "redirect:/log/borrowLog?userID="+log.getUserID();
        }

        redirectAttributes.addAttribute("Msg", "缴纳失败！");
        return "redirect:/error";
    }

}
