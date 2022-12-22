package com.community.dao;

import com.community.util.SqlMapper;
import com.community.vo.Post;

public class PostDao {

	private static PostDao instance = new PostDao();
	private PostDao() {}
	public static PostDao getInstance() {
		return instance;
	}
	
	public void insertPost(Post post) {
		SqlMapper.insert("posts.insertPost", post);
	}
	
	public Post getPostByNo(int postNo) {
		return (Post) SqlMapper.selectOne("posts.getPostByNo", postNo);
	}
	
	public int getSequence() {
		return (Integer) SqlMapper.selectOne("posts.getSequence");
	}
}
