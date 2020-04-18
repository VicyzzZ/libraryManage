package cleve.dao;

import cleve.entity.Book;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * BookDao 提供关于书籍的操作接口
 */
@Repository
public interface BookDao {

    /**
     * 添加书籍
     *
     * @param book 新增的书籍
     */
    void addBook(Book book);

    /**
     * 通过书籍名删除书籍
     *
     * @param bookName 删除书籍的书籍名
     */
    void deleteBookBybookName(String bookName);

    /**
     * 通过书籍ID删除书籍
     *
     * @param bookID 删除书籍的书籍ID
     */
    void deleteBookBybookID(String bookID);

    /**
     * 通过分类ID删除书籍
     *
     * @param categoryID 删除书籍的分类ID
     */
    void deleteBookByCategoryID(int categoryID);

    /**
     * 更新书籍信息
     *
     * @param book 需要更新的书籍
     */
    void updateBook(Book book);

    /**
     * 通过书籍名查找书籍
     *
     * @param bookName 书籍名
     * @return 查找到的书籍
     */
    Book findBookBybookName(String bookName);

    /**
     * 通过书籍 id 查找书籍
     *
     * @param bookID 书籍 ID
     * @return 查找到的书籍
     */
    Book findBookByBookID(String bookID);

    /**
     * 根据分类 查找书籍
     *
     * @return 书籍列表
     */
    List<Book> getBookOfCategoryID(int CategoryID);

    /**
     * 获取所有书籍
     *
     * @return 书籍列表
     */
    List<Book> getAllBooks();
}
