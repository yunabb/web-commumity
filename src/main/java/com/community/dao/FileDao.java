package com.community.dao;

import com.community.util.SqlMapper;
import com.community.vo.File;

public class FileDao {

	private static FileDao instance = new FileDao();
	private FileDao() {}
	public static FileDao getInstance() {
		return instance;
	}
	
	public void insertFile(File file) {
		SqlMapper.insert("files.insertFile", file);
	}
	
	public void updateFile(File file) {
		SqlMapper.update("files.updateFile", file);
	}
	
	public File getFilesByNo(int postNo) {
		return (File) SqlMapper.selectOne("files.getFilesByNo", postNo);
	}
	
}
