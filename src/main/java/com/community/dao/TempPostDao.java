package com.community.dao;

import java.util.List;
import java.util.Map;

import com.community.util.SqlMapper;
import com.community.vo.TempPost;

public class TempPostDao {
	
	private static TempPostDao instance = new TempPostDao();
	private TempPostDao() {}
	public static TempPostDao getInstance() {
		return instance;
	}
	
	/**
	 * 임시게시판 새 게시글 등록하기
	 * @param tempPost
	 */
	public void insertTempPost(TempPost tempPost) {
		SqlMapper.insert("tempposts.insertTempPost", tempPost);
	}
	
	/**
	 * 임시게시판 게시글 수정하기
	 * @param tempPost
	 */
	public void updateTempPost(TempPost tempPost) { 
		SqlMapper.update("tempposts.updateTempPost", tempPost);
	}
	
	/**
	 * 임시게시판 게시글 삭제하기
	 * @param tempNo
	 */
	public void deleteTempPost(int tempNo) { 
		SqlMapper.delete("tempposts.deleteTempPost", tempNo);
	}
	
	/**
	 * 임시게시판 게시글 전체 글 갯수 조회하기
	 * @param param
	 * @return
	 */
	public int getTotalRows(Map<String, Object> param) {
		return (Integer) SqlMapper.selectOne("tempposts.getTotalRows", param);
	}
	
	/**
	 * 임시게시판 게시글 전체목록 조회 (및 페이징처리하기)
	 * @param param
	 * @return
	 */
	public List<TempPost> getTempPost(Map<String, Object> param) {
		return (List<TempPost>) SqlMapper.selectList("tempposts.getTempPost", param);
	}
	
	/**
	 * 임시게시판 게시글 번호를 전달받아 게시글 상세정보 조회하기
	 * @param tempNo
	 * @return
	 */
	public TempPost getTempPostByNo(int tempNo) {
		return (TempPost) SqlMapper.selectOne("tempposts.getTempPostByNo", tempNo);
	}
	
}
