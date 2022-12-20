package com.community.dao;

import java.util.List;
import java.util.Map;

import com.community.util.SqlMapper;
import com.community.vo.Question;

public class QuestionDao {

	private static QuestionDao instance = new QuestionDao();
	private QuestionDao() {}
	public static QuestionDao getInstance() {
		return instance;
	}
	
	public Question getQuestionByNo(int postNo) {
		return (Question) SqlMapper.selectOne("questions.getQuestionByNo", postNo);
	}
	
	public int getTotalRows(Map<String, Object> param) {
		return (Integer) SqlMapper.selectOne("questions.getTotalRows", param);
	}
	
	@SuppressWarnings("unchecked")
	public List<Question> getQuestions(Map<String, Object> param) {
		return (List<Question>) SqlMapper.selectList("questions.getQuestions", param);
	}
	
	public void updateQuestion(Question question) {
		SqlMapper.update("questions.updateQuestion", question);
	}
	
	public void insertQuestion(Question question) {
		SqlMapper.insert("questions.insertQuestion", question);
	}
}
