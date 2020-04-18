package cleve.entity;

import java.sql.Timestamp;

public class Log {
    private int logID;
    private int userID;
    private String bookID;
    private Timestamp borrowTime;
    private int borrowLong;
    private Timestamp returnTime;
    private int state;
    private int credit;

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getBookID() {
        return bookID;
    }

    public void setBookID(String bookID) {
        this.bookID = bookID;
    }

    public Timestamp getBorrowTime() {
        return borrowTime;
    }

    public void setBorrowTime(Timestamp borrowTime) {
        this.borrowTime = borrowTime;
    }

    public int getBorrowLong() {
        return borrowLong;
    }

    public void setBorrowLong(int borrowLong) {
        this.borrowLong = borrowLong;
    }

    public Timestamp getReturnTime() {
        return returnTime;
    }

    public void setReturnTime(Timestamp returnTime) {
        this.returnTime = returnTime;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getCredit() {
        return credit;
    }

    public void setCredit(int credit) {
        this.credit = credit;
    }

    public int getLogID() {
        return logID;
    }

    public void setLogID(int logID) {
        this.logID = logID;
    }

    @Override
    public String toString() {
        return "Log{" +
                "logID=" + logID +
                ", userID=" + userID +
                ", bookID='" + bookID + '\'' +
                ", borrowTime=" + borrowTime +
                ", borrowLong=" + borrowLong +
                ", returnTime=" + returnTime +
                ", state=" + state +
                ", credit=" + credit +
                '}';
    }
}
