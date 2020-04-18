package serviceTest;

import cleve.entity.Book;
import cleve.service.BookService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.sql.Timestamp;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springMVC.xml"})
public class BookTest {

    @Autowired
    private BookService bookService;

    @Test
    public void addBook()
    {
        Book book = new Book();
        book.setBookID("A101123");
        book.setBookName("传奇");
        book.setBookInfo("传奇人物介绍。");
        book.setBookCategoryID(1);
        book.setBookAuthor("方子传");
        book.setBookPublish("人民出版社");
        book.setBookNum(10);
        book.setBookPrice(20.00);
        book.setBookBorrowTimes(0);
        Timestamp createTime = new Timestamp(System.currentTimeMillis());
        book.setCreateTime(createTime);
        bookService.addBook(book);
        Book addBook = bookService.findBookBybookName("传奇");
        System.out.println(addBook.toString());
    }

    @Test
    public void updateBook()
    {
        String bookID = bookService.findBookBybookName("传奇").getBookID();
        Book book = bookService.findBookByBookID(bookID);
        book.setBookName("传奇人物");
        book.setBookAuthor("安松");
        book.setBookPublish("上海出版社");
        book.setBookPrice(book.getBookPrice()+1);
        book.setBookNum(book.getBookNum()+1);
        book.setBookCategoryID(2);
        book.setBookInfo(book.getBookInfo()+"update");
        bookService.updateBook(book);
        Book updateBook = bookService.findBookByBookID(bookID);
        System.out.println(updateBook.toString());
    }

    @Test
    public void getAllBooks()
    {
        List<Book> bookList =bookService.getAllBooks();
        System.out.println(bookList);
    }

    @Test
    public void deleteBookByBookID()
    {
        String bookID = bookService.findBookBybookName("传奇人物").getBookID();
        bookService.deleteBookBybookID(bookID);
        Book book = bookService.findBookByBookID(bookID);
        if(book==null)
        {
            System.out.println("查无此书。");
        }
    }
    @Test
    public void deleteBookByBookName()
    {
        bookService.deleteBookBybookName("传奇人物");
        Book book = bookService.findBookBybookName("传奇人物");
        if(book==null)
        {
            System.out.println("查无此书。");
        }
    }
}
