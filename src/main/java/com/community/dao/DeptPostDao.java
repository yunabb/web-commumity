package com.community.dao;

import java.util.List;
import java.util.Map;

import com.community.util.SqlMapper;
import com.community.vo.DeptPost;

public class DeptPostDao {
	
	private static DeptPostDao instance = new DeptPostDao();
	private DeptPostDao() {}
	public static DeptPostDao getInstance() {
		return instance;
	}
	
	// 부서게시판 새 게시글 등록
	public void insertDeptPost(DeptPost deptPost) {
		SqlMapper.insert("deptposts.insertDeptPost", deptPost);
	}
	
	// 부서게시판 게시글 수정
	public void updateDeptPost(DeptPost deptPost) {
		SqlMapper.update("deptposts.updateDeptPost", deptPost);
	}
	
	// 부서게시판 게시글 총 갯수 조회
	public int getTotalRows() {
		return (Integer) SqlMapper.selectOne("deptposts.getTotalRows");
	}
	
	// 부서게시판 모든 게시글 조회
	@SuppressWarnings("unchecked")
	public List<DeptPost> getDeptPosts(Map<String, Object> param) {
		return (List<DeptPost>) SqlMapper.selectList("deptposts.getDeptPosts", param);
	}
	
	// 부서게시판의 게시글 번호로 게시글 상세 조회
	public DeptPost getDeptPostByNo(int postNo) {
		return (DeptPost) SqlMapper.selectOne("deptposts.getDeptPostByNo", postNo);
	}
}
