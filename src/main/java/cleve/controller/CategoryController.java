package cleve.controller;

import cleve.entity.Book;
import cleve.entity.Category;
import cleve.service.BookService;
import cleve.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value = "/category")
public class CategoryController {
    private final CategoryService categoryService;
    private final BookService bookService;

    @Autowired
    public CategoryController(CategoryService categoryService, BookService bookService) {
        this.categoryService = categoryService;
        this.bookService = bookService;
    }

    /**
     * 显示分类中的书籍
     *
     * @param request 请求
     * @return 返回页面
     */
    @RequestMapping("/showBook")
    public String mainPage(int categoryID,HttpServletRequest request) {
        List<Book> bookList = bookService.getBookOfCategoryID(categoryID);
        List<Category> categoryList = categoryService.getAllCategory();
        Category CurrentCategory = categoryService.findCategoryBycategoryID(categoryID);
        request.setAttribute("categoryList", categoryList);
        request.setAttribute("bookList", bookList);
        request.setAttribute("CurrentCategory", CurrentCategory);
        return "mainPage";
    }
}
