package com.community.dao;

import java.util.List;

import com.community.util.SqlMapper;
import com.community.vo.Answer;

public class AnswerDao {

	private static AnswerDao instance = new AnswerDao();
	private AnswerDao () {}
	public static AnswerDao getInstance() {
		return instance;
	}
	
	public void insertAnswer(Answer answer) {
		SqlMapper.insert("answers.insertAnswer", answer);
	}
	
	@SuppressWarnings("unchecked")
	public List<Answer> getAnswersByNo(int postNo) {
		return (List<Answer>) SqlMapper.selectList("answers.getAnswersByNo", postNo);
	}
	
	public int getAnswersRows(int postNo) {
		return (Integer) SqlMapper.selectOne("answers.getAnswersRows", postNo);
	}
}
