package com.book.service;

import com.book.domain.ReaderInfo;

public interface ReaderCardService {
    boolean addReaderCard(ReaderInfo readerInfo);
    boolean updatePasswd(String readerId, String passwd);
    boolean updateName(String readerId, String name);
}