package com.community.dao;

import java.util.List;
import java.util.Map;

import com.community.util.SqlMapper;
import com.community.vo.FileShare;

public class FileShareDao {
	
	private static FileShareDao instance = new FileShareDao();
	private FileShareDao() {}
	public static FileShareDao getInstance() {
		return instance;
	}
	
	public void insertFileShare(FileShare fileShare) {
		SqlMapper.insert("fileshares.insertFileShare", fileShare);
	}
	
	public void updateFileShare(FileShare fileShare) {
		SqlMapper.update("fileshares.updateFileShare", fileShare);
	}
	
	public int getTotalRows(Map<String, Object> param) { 
		return (Integer) SqlMapper.selectOne("fileshares.getTotalRows");
	}
	
	@SuppressWarnings("unchecked")
	public List<FileShare> getFileShares(Map<String, Object> param) {
		return (List<FileShare>) SqlMapper.selectList("fileshares.getFileShares", param);
	}
	
	public FileShare getFileSharesByNo(int postNo) {
		return (FileShare) SqlMapper.selectOne("fileshares.getFileSharesByNo", postNo);
	}
}
