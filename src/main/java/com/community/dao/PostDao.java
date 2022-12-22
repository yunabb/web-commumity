package com.community.dao;

import java.util.List;
import java.util.Map;

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

	@SuppressWarnings("unchecked")
	public List<Post> getPostsByEmpNo(int empNo) {
		return (List<Post>) SqlMapper.selectList("posts.getPostsByEmpNo", empNo);
	}
	
	public int getTotalRowsByEmpno(int empNo) {
		return (Integer) SqlMapper.selectOne("posts.getTotalRowsByEmpno", empNo);
	}
	
	@SuppressWarnings("unchecked")
	public List<Post> getPosts(Map<String, Object> param) {
		return (List<Post>) SqlMapper.selectList("posts.getPosts", param);
	}
	
	public int getTotalRows(Map<String, Object> param) {
		return (Integer) SqlMapper.selectOne("posts.getTotalRows", param);
	}
	
	public void updatePost(Post post) {
		SqlMapper.update("posts.updatePost", post);

	}
}
