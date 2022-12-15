package com.community.dao;

import java.util.List;

import com.community.util.SqlMapper;
import com.community.vo.Comment;

public class CommentDao {
	
	private static CommentDao instance = new CommentDao();
	private CommentDao() {}
	public static CommentDao getInstance() {
		return instance;
	}
	
	// 새 댓글 등록
	public void insertComment(Comment comment) {
		SqlMapper.insert("comments.insertComment", comment);
	}
	
	// 댓글 수정
	public void updateComment(Comment comment) {
		SqlMapper.update("comments.updateComment", comment);
	}
	
	// 게시글 번호에 해당하는 댓글 조회
	@SuppressWarnings("unchecked")
	public List<Comment> getCommentsByPostNo(int postNo) {
		return (List<Comment>) SqlMapper.selectList("comments.getCommentsByPostNo", postNo);
	}


}
