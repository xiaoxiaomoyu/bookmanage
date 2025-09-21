package com.book.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public interface AdminDao {
    int getMatchCount(@Param("username") String username, @Param("passwd") String password);
    int rePassword(@Param("adminId") String adminId,
                   @Param("newPasswd") String newPasswd,
                   @Param("oldPasswd") String oldPasswd); // 方法重载
    String getPasswd(@Param("id") int id);

    // 新增方法
    Map<String, Object> getAdminInfo(@Param("adminId") int adminId);
    int recordLoginLog(@Param("adminId") String adminId, @Param("loginIp") String loginIp);
}
