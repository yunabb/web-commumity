package com.community.dao;

import java.util.List;
import java.util.Map;

import com.community.util.SqlMapper;
import com.community.vo.TalkPost;

public class TalkPostDao {
	
	private static TalkPostDao instance = new TalkPostDao();
	private TalkPostDao() {}
	public static TalkPostDao getInstance() {
		return instance;
	}
	
	// 사는이야기 게시판 새 게시글 등록
	public void insertTalkPost(TalkPost talkPost) {
		SqlMapper.insert("talkposts.insertTalkPost", talkPost);
	}
	
	// 사는이야기 게시판의 게시글 수정
	public void updateTalkPost(TalkPost talkPost) {
		SqlMapper.update("talkposts.updateTalkPost", talkPost);
	}
	
	// 사는이야기 게시판의 게시글 총 갯수 조회
	public int getTotalRows() {
		return (Integer) SqlMapper.selectOne("talkposts.getTotalRows");
	}
	
	// 사는이야기 게시판의 모든 게시글 조회
	@SuppressWarnings("unchecked")
	public List<TalkPost> getTalkPosts(Map<String, Object> param) {
		return (List<TalkPost>) SqlMapper.selectList("talkposts.getTalkPosts", param);
	}
	
	// 사는이야기 게시판의 게시글 번호로 게시글 상세 조회
	public TalkPost getTalkPostByNo(int postNo) {
		return (TalkPost) SqlMapper.selectOne("talkposts.getTalkPostByNo", postNo);
	}	

}
