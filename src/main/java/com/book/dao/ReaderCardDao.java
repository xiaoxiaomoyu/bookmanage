package com.book.dao;

import com.book.domain.ReaderCard;
import com.book.domain.ReaderInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ReaderCardDao {
    int getMatchCount(@Param("username") String username, @Param("passwd") String passwd);
    ReaderCard findReaderByReaderId(@Param("userId") String userId);
    int rePassword(@Param("readerId") String readerId, @Param("newPasswd") String newPasswd);
    int addReaderCard(ReaderInfo readerInfo);
    int updateName(@Param("readerId") String readerId, @Param("name") String name);

    int recordLoginLog(@Param("readerId") String readerId, @Param("loginIp") String loginIp);
}
