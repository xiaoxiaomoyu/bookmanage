package com.book.dao;

import com.book.domain.ReaderInfo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;

@Repository
public interface ReaderInfoDao {
    ArrayList<ReaderInfo> getAllReaderInfo();
    ReaderInfo findReaderInfoByReaderId(@Param("readerId") String readerId);
    int deleteReaderInfo(@Param("readerId") String readerId);
    int editReaderInfo(ReaderInfo readerInfo);
    int addReaderInfo(ReaderInfo readerInfo);
}
