package com.book.command;

import com.book.domain.Book;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class BookAddCommand {


    private String name;
    private String author;
    private String publish;
    private String isbn;
    private String introduction;
    private String language;
    private BigDecimal price;
    private Date pubdate;
    private int classId;
    private int pressmark;
    private int state;
    private String id;

    public void setName(String name) {
        this.name = name;
    }

    public void setPubdate(Date pubdate) {
        this.pubdate = pubdate;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public void setLanguage(String language) {
        this.language = language;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }



    public void setPubdate(String pubdate) {
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

        try{
            Date date=sdf.parse(pubdate);
            this.pubdate=date;
        }catch (ParseException e){
            e.printStackTrace();
        }

    }

    public void setPublish(String publish) {
        this.publish = publish;
    }

    public void setIntroduction(String introduction) {
        this.introduction = introduction;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public void setPressmark(int pressmark) {
        this.pressmark = pressmark;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getName() {
        return name;
    }

    public BigDecimal getPrice() {
        return price;
    }


    public int getClassId() {
        return classId;
    }

    public Date getPubdate() {
        return pubdate;
    }

    public String getAuthor() {
        return author;
    }

    public String getIntroduction() {
        return introduction;
    }

    public int getPressmark() {
        return pressmark;
    }

    public String getIsbn() {
        return isbn;
    }

    public String getLanguage() {
        return language;
    }

    public int getState() {
        return state;
    }

    public String getPublish() {
        return publish;
    }
    // 添加转换为Book对象的方法
    public Book toBook() {
        Book book = new Book();
        if (this.id != null && !this.id.isEmpty()) {
            book.setBookId(Long.parseLong(this.id));
        }
        book.setName(this.name);
        book.setAuthor(this.author);
        book.setPublish(this.publish);
        book.setIsbn(this.isbn);
        book.setIntroduction(this.introduction);
        book.setLanguage(this.language);
        book.setPrice(this.price);
        book.setPubdate(this.pubdate);
        book.setClassId(this.classId);
        book.setPressmark(this.pressmark);
        book.setState(this.state);
        return book;
    }

}

