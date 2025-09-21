package com.book.service.impl;

import com.book.dao.BookDao;
import com.book.domain.Book;
import com.book.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class BookServiceImpl implements BookService {
    private BookDao bookDao;

    @Autowired
    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    @Override
    public ArrayList<Book> queryBook(String searchWord) {
        return bookDao.queryBook(searchWord);
    }

    @Override
    public ArrayList<Book> getAllBooks() {
        return bookDao.getAllBooks();
    }

    @Override
    public int deleteBook(long bookId) {
        return bookDao.deleteBook(bookId);
    }

    @Override
    public boolean matchBook(String searchWord) {
        return bookDao.matchBook(searchWord) > 0;
    }

    @Override
    public boolean addBook(Book book) {
        return bookDao.addBook(book) > 0;
    }

    @Override
    public Book getBook(Long bookId) {
        return bookDao.getBook(bookId);
    }

    @Override
    public boolean editBook(Book book) {
        return bookDao.editBook(book) > 0;
    }
}