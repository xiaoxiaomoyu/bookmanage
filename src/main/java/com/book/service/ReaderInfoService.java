package com.book.service;

import com.book.domain.ReaderInfo;

import java.util.ArrayList;

public interface ReaderInfoService {
    ArrayList<ReaderInfo> readerInfos();
    boolean deleteReaderInfo(String readerId);
    ReaderInfo getReaderInfo(String readerId);
    boolean editReaderInfo(ReaderInfo readerInfo);
    boolean addReaderInfo(ReaderInfo readerInfo);
}