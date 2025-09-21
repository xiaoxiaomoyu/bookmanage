package com.book.service;

import com.book.domain.Book;

import java.util.ArrayList;

public interface BookService {
    ArrayList<Book> queryBook(String searchWord);
    ArrayList<Book> getAllBooks();
    int deleteBook(long bookId);
    boolean matchBook(String searchWord);
    boolean addBook(Book book);
    Book getBook(Long bookId);
    boolean editBook(Book book);
}