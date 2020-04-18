package cleve.controller;

import cleve.entity.Book;
import cleve.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/book")
public class BookController {
    private final BookService bookService;

    @Autowired
    public BookController(BookService bookService) {
        this.bookService = bookService;
    }

    /**
     * 书籍详细信息
     *
     * @param request 请求
     * @return 返回页面
     */
    @RequestMapping("/bookInfo")
    public String bookInfo(String bookID, HttpServletRequest request) {
        Book book = bookService.findBookByBookID(bookID);
        request.setAttribute("book", book);
        return "Book/BookInfo";
    }


}
