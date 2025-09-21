package com.book.service.impl;

import com.book.dao.ReaderInfoDao;
import com.book.domain.ReaderInfo;
import com.book.service.ReaderInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class ReaderInfoServiceImpl implements ReaderInfoService {
    private ReaderInfoDao readerInfoDao;

    @Autowired
    public void setReaderInfoDao(ReaderInfoDao readerInfoDao) {
        this.readerInfoDao = readerInfoDao;
    }

    @Override
    public ArrayList<ReaderInfo> readerInfos() {
        return readerInfoDao.getAllReaderInfo();
    }

    @Override
    public boolean deleteReaderInfo(String readerId) {
        return readerInfoDao.deleteReaderInfo(readerId) > 0;
    }

    @Override
    public ReaderInfo getReaderInfo(String readerId) {
        return readerInfoDao.findReaderInfoByReaderId(readerId);
    }

    @Override
    public boolean editReaderInfo(ReaderInfo readerInfo) {
        return readerInfoDao.editReaderInfo(readerInfo) > 0;
    }

    @Override
    public boolean addReaderInfo(ReaderInfo readerInfo) {
        return readerInfoDao.addReaderInfo(readerInfo) > 0;
    }
}