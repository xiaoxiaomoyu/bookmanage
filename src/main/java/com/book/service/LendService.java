package com.book.service;

import com.book.domain.Lend;

import java.util.ArrayList;

public interface LendService {
    boolean bookReturn(long bookId);
    boolean bookLend(long bookId, int readerId);
    ArrayList<Lend> lendList();
    ArrayList<Lend> myLendList(String readerId);
}