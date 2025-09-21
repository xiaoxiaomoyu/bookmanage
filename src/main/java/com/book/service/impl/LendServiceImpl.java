package com.book.service.impl;

import com.book.dao.LendDao;
import com.book.domain.Lend;
import com.book.service.LendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class LendServiceImpl implements LendService {
    private LendDao lendDao;

    @Autowired
    public void setLendDao(LendDao lendDao) {
        this.lendDao = lendDao;
    }

    @Override
    public boolean bookReturn(long bookId) {
        return lendDao.bookReturnOne(bookId) > 0 && lendDao.bookReturnTwo(bookId) > 0;
    }

    @Override
    public boolean bookLend(long bookId, int readerId) {
        return lendDao.bookLendOne(bookId, readerId) > 0 && lendDao.bookLendTwo(bookId) > 0;
    }

    @Override
    public ArrayList<Lend> lendList() {
        return lendDao.lendList();
    }

    @Override
    public ArrayList<Lend> myLendList(String readerId) {
        return lendDao.myLendList(readerId);
    }
}