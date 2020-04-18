package cleve.service.impl;

import cleve.dao.BookDao;
import cleve.entity.Book;
import cleve.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * BookServiceImpl
 */
@Service
public class BookServiceImpl implements BookService {
    private final BookDao bookDao;

    @Autowired
    public BookServiceImpl(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    @Override
    public void addBook(Book book) {
        if(book != null)
        {
            bookDao.addBook(book);
        }
    }

    @Override
    public void deleteBookBybookName(String bookName) {
        bookDao.deleteBookBybookName(bookName);
    }

    @Override
    public void deleteBookBybookID(String bookID) {
        bookDao.deleteBookBybookID(bookID);
    }

    @Override
    public void deleteBookByCategoryID(int categoryID) {
        bookDao.deleteBookByCategoryID(categoryID);
    }

    @Override
    public void updateBook(Book book) {
        if(book != null)
        {
            bookDao.updateBook(book);
        }
    }

    @Override
    public Book findBookBybookName(String bookName) {
        return bookDao.findBookBybookName(bookName);
    }

    @Override
    public Book findBookByBookID(String bookID) {
        return bookDao.findBookByBookID(bookID);
    }

    @Override
    public List<Book> getBookOfCategoryID(int CategoryID) {
        return bookDao.getBookOfCategoryID(CategoryID);
    }

    @Override
    public List<Book> getAllBooks() {
        return bookDao.getAllBooks();
    }
}
