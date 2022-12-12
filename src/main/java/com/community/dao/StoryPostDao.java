package com.community.dao;

import java.util.List;
import java.util.Map;

import com.community.util.SqlMapper;
import com.community.vo.StoryPost;

public class StoryPostDao {
	
	private static StoryPostDao instance = new StoryPostDao();
	private StoryPostDao() {}
	public static StoryPostDao getInstance() {
		return instance;
	}
	
	// 사는이야기 게시판 새 게시글 등록
	public void insertStoryPost(StoryPost storyPost) {
		SqlMapper.insert("storyposts.insertStoryPost", storyPost);
	}
	
	// 사는이야기 게시판의 게시글 수정
	public void updateStoryPost(StoryPost storyPost) {
		SqlMapper.update("storyposts.updateStoryPost", storyPost);
	}
	
	// 사는이야기 게시판의 게시글 총 갯수 조회
	public int getTotalRows() {
		return (Integer) SqlMapper.selectOne("storyposts.getTotalRows");
	}
	
	// 사는이야기 게시판의 모든 게시글 조회
	@SuppressWarnings("unchecked")
	public List<StoryPost> getStoryPosts(Map<String, Object> param) {
		return (List<StoryPost>) SqlMapper.selectList("storyposts.getStoryPosts", param);
	}
	
	// 사는이야기 게시판의 게시글 번호로 게시글 상세 조회
	public StoryPost getStoryPostByNo(int postNo) {
		return (StoryPost) SqlMapper.selectOne("storyposts.getStoryPostByNo", postNo);
	}	

}
