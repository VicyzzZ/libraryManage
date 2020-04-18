package cleve.entity;

import java.sql.Timestamp;

public class Book {
    private String bookID;
    private String bookName;
    private String bookInfo;
    private int bookCategoryID;
    private String bookAuthor;
    private String bookPublish;
    private double bookPrice;
    private int bookNum;
    private int bookBorrowTimes;
    private Timestamp createTime;

    public String getBookID() {
        return bookID;
    }

    public void setBookID(String bookID) {
        this.bookID = bookID;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public int getBookCategoryID() {
        return bookCategoryID;
    }

    public void setBookCategoryID(int bookCategoryID) {
        this.bookCategoryID = bookCategoryID;
    }

    public String getBookAuthor() {
        return bookAuthor;
    }

    public void setBookAuthor(String bookAuthor) {
        this.bookAuthor = bookAuthor;
    }

    public String getBookPublish() {
        return bookPublish;
    }

    public void setBookPublish(String bookPublish) {
        this.bookPublish = bookPublish;
    }

    public double getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(double bookPrice) {
        this.bookPrice = bookPrice;
    }

    public int getBookNum() {
        return bookNum;
    }

    public void setBookNum(int bookNum) {
        this.bookNum = bookNum;
    }

    public int getBookBorrowTimes() {
        return bookBorrowTimes;
    }

    public void setBookBorrowTimes(int bookBorrowTimes) {
        this.bookBorrowTimes = bookBorrowTimes;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public String getBookInfo() {
        return bookInfo;
    }

    public void setBookInfo(String bookInfo) {
        this.bookInfo = bookInfo;
    }

    @Override
    public String toString() {
        return "Book{" +
                "bookID='" + bookID + '\'' +
                ", bookName='" + bookName + '\'' +
                ", bookInfo='" + bookInfo + '\'' +
                ", bookCategoryID=" + bookCategoryID +
                ", bookAuthor='" + bookAuthor + '\'' +
                ", bookPublish='" + bookPublish + '\'' +
                ", bookPrice=" + bookPrice +
                ", bookNum=" + bookNum +
                ", bookBorrowTimes=" + bookBorrowTimes +
                ", createTime=" + createTime +
                '}';
    }
}
