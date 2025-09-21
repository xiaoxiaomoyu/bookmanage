package com.book.service;

import com.book.domain.ReaderCard;
import com.book.domain.ReaderInfo;

import java.util.Map;

public interface LoginService {
    boolean hasMatchReader(String username, String passwd);
    ReaderCard findReaderCardByUserId(String readerId);
    ReaderInfo findReaderInfoByReaderId(String readerId);
    boolean hasMatchAdmin(String username, String password);
    boolean adminRePasswd(String adminId, String newPasswd, String oldPasswd);


    String getAdminPasswd(int id);
    Map<String, Object> getAdminInfo(int adminId);
    void recordAdminLogin(String adminId, String loginIp);
    void recordReaderCardLogin(String readerId, String loginIp);
}