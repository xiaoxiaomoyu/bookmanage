package com.book.service.impl;

import com.book.dao.AdminDao;
import com.book.dao.ReaderCardDao;
import com.book.dao.ReaderInfoDao;
import com.book.domain.ReaderCard;
import com.book.domain.ReaderInfo;
import com.book.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class LoginServiceImpl implements LoginService {
    private ReaderCardDao readerCardDao;
    private ReaderInfoDao readerInfoDao;
    private AdminDao adminDao;

    @Autowired
    public void setReaderCardDao(ReaderCardDao readerCardDao) {
        this.readerCardDao = readerCardDao;
    }

    @Autowired
    public void setReaderInfoDao(ReaderInfoDao readerInfoDao) {
        this.readerInfoDao = readerInfoDao;
    }

    @Autowired
    public void setAdminDao(AdminDao adminDao) {
        this.adminDao = adminDao;
    }

    @Override
    public boolean hasMatchReader(String username, String passwd) {
        return readerCardDao.getMatchCount(String.valueOf(username), passwd) > 0;
    }

    @Override
    public ReaderCard findReaderCardByUserId(String readerId) {
        return readerCardDao.findReaderByReaderId(readerId);
    }

    @Override
    public ReaderInfo findReaderInfoByReaderId(String readerId) {
        return readerInfoDao.findReaderInfoByReaderId(readerId);
    }

    @Override
    public boolean hasMatchAdmin(String username, String password) {
        try {
            return adminDao.getMatchCount(String.valueOf(username), password) == 1;
        } catch (Exception e) {
            System.err.println("Admin login error: " + e.getMessage());
            return false;
        }
    }

    @Override
    public boolean adminRePasswd(String adminId, String newPasswd, String oldPasswd) {
        try {
            if (oldPasswd != null) {
                return adminDao.rePassword(adminId, newPasswd, oldPasswd) > 0;
            } else {
                return adminDao.rePassword(adminId, newPasswd, null) > 0;
            }
        } catch (Exception e) {
            System.err.println("Password update error: " + e.getMessage());
            return false;
        }
    }

    @Override
    public String getAdminPasswd(int id) {
        return adminDao.getPasswd(id);
    }

    @Override
    public Map<String, Object> getAdminInfo(int adminId) {
        return adminDao.getAdminInfo(adminId);
    }

    @Override
    public void recordAdminLogin(String adminId, String loginIp) {
        try {
            adminDao.recordLoginLog(adminId, loginIp);
        } catch (Exception e) {
            System.err.println("Login log recording failed: " + e.getMessage());
        }
    }
    @Override
    public void recordReaderCardLogin(String readerId, String loginIp) {
        try {
            readerCardDao.recordLoginLog(readerId, loginIp);
        } catch (Exception e) {
            System.err.println("Login log recording failed: " + e.getMessage());
        }
    }
}