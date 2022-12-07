package com.community.dao;

import com.community.util.SqlMapper;
import com.community.vo.Question;

public class QuestionDao {

	private static QuestionDao instance = new QuestionDao();
	private QuestionDao() {}
	public static QuestionDao getInstance() {
		return instance;
	}
	
	public void insertPost(Question question) {
		SqlMapper.insert("questions.insertQuestion", question);
	}
}
