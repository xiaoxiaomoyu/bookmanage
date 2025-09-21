package com.book.dao;

import com.book.domain.Book;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface BookDao {
    int matchBook(@Param("searchWord") String searchWord);
    ArrayList<Book> queryBook(@Param("searchWord") String searchWord);
    ArrayList<Book> getAllBooks();
    int deleteBook(@Param("bookId") long bookId);
    int addBook(Book book);
    Book getBook(@Param("bookId") Long bookId);
    int editBook(Book book);
}
