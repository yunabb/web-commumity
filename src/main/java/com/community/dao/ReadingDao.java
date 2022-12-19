package com.community.dao;

import java.util.List;

import com.community.util.SqlMapper;
import com.community.vo.Reading;

public class ReadingDao {

	private static ReadingDao instance = new ReadingDao();
	
	private ReadingDao() {}
	public static ReadingDao getInstance() {
		return instance;
	}
	
	public void insertReading(Reading reading) {
		SqlMapper.insert("readings.insertReading", reading);
	}
	
	@SuppressWarnings("unchecked")
	public List<Reading> getReadings(int postNo) {
		return (List<Reading>) SqlMapper.selectList("readings.getReadings", postNo);
	}
}
