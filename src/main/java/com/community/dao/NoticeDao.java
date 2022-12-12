package com.community.dao;

import java.util.List;
import java.util.Map;

import com.community.util.SqlMapper;
import com.community.vo.Notice;

public class NoticeDao {

	private static NoticeDao instance = new NoticeDao();
	private NoticeDao() {}
	public static NoticeDao getInstance() {
		return instance;
	}
	
	@SuppressWarnings("unchecked")
	public List<Notice> getNotices(Map<String, Object> param) {
		return (List<Notice>)SqlMapper.selectList("notices.getNotices", param);
	}
	
	public int getTotalRows(Map<String, Object> param) {
		return (Integer) SqlMapper.selectOne("notices.getTotalRows", param);
	}
	
	public void insertNotice(Notice notice) {
		SqlMapper.insert("notices.insertNotice", notice);
	}
	
	public void updateNotice(Notice notice) {
		SqlMapper.update("notices.updateNotice", notice);
	}
	
	public Notice getNoticeByNo(int postNo) {
		return (Notice)SqlMapper.selectOne("getNoticeByNo", postNo);

	public Notice getNoticeByPostNo(int postNo) {
		return (Notice)SqlMapper.selectOne("notices.getNoticeByPostNo", postNo);
	}
}
