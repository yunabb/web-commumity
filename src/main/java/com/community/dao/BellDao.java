package com.community.dao;

import java.util.List;

import com.community.util.SqlMapper;
import com.community.vo.Bell;

public class BellDao {

	private static BellDao instance = new BellDao();
	private BellDao() {}
	public static BellDao getInstance() {
		return instance;
	}
	
	public void insertBell(Bell bell) {
		SqlMapper.insert("bells.insertBell", bell);
	}
	
	@SuppressWarnings("unchecked")
	public List<Bell> getBellsByEmpNo(int receiveEmpNo) {
		return (List<Bell>) SqlMapper.selectList("bells.getBellsByEmpNo", receiveEmpNo);
	}
	
	public Bell getBellByBellNo(int bellNo) {
		return (Bell) SqlMapper.selectOne("bells.getBellByBellNo", bellNo);
	}
	
	public int getBellsRows(int receiveEmpNo) {
		return (Integer) SqlMapper.selectOne("bells.getBellsRows", receiveEmpNo);
	}
	
	public Bell getBellByReviewNo(int reviewNo) {
		return (Bell) SqlMapper.selectOne("bells.getBellByReviewNo", reviewNo);
	}
	
	public void updateBell(Bell bell) {
		SqlMapper.update("bells.updateBell", bell);
	}
	
	public void deleteBell(Bell bell) {
		SqlMapper.update("bells.deleteBell", bell);
	}
	
	public int getSequence() {
		return (Integer) SqlMapper.selectOne("bells.getSequence");
	}
}
