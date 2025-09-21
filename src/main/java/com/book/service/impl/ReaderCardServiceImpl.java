package com.book.service.impl;

import com.book.dao.ReaderCardDao;
import com.book.domain.ReaderInfo;
import com.book.service.ReaderCardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReaderCardServiceImpl implements ReaderCardService {
    private ReaderCardDao readerCardDao;

    @Autowired
    public void setReaderCardDao(ReaderCardDao readerCardDao) {
        this.readerCardDao = readerCardDao;
    }

    @Override
    public boolean addReaderCard(ReaderInfo readerInfo) {
        return readerCardDao.addReaderCard(readerInfo) > 0;
    }

    @Override
    public boolean updatePasswd(String readerId, String passwd) {
        return readerCardDao.rePassword(readerId, passwd) > 0;
    }

    @Override
        public boolean updateName(String readerId, String name) {
        return readerCardDao.updateName(readerId, name) > 0;
    }
}