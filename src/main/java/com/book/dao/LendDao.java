package com.book.dao;

import com.book.domain.Lend;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface LendDao {
    int bookReturnOne(@Param("bookId") long bookId);
    int bookReturnTwo(@Param("bookId") long bookId);
    int bookLendOne(@Param("bookId") long bookId, @Param("readerId") int readerId);
    int bookLendTwo(@Param("bookId") long bookId);
    ArrayList<Lend> lendList();
    ArrayList<Lend> myLendList(@Param("readerId") String readerId);
}
