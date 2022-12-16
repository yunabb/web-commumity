<%@page import="com.community.vo.Post"%>
<%@page import="com.community.vo.Suggestion"%>
<%@page import="com.community.dao.SuggestionDao"%>
<%@page import="com.community.vo.Question"%>
<%@page import="com.community.dao.QuestionDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../../common/logincheck.jsp" %>
<%
	Employee emp = (Employee) session.getAttribute("loginedEmp");

	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));
	
	QuestionDao questionDao = QuestionDao.getInstance();
	Question question = questionDao.getQuestionByNo(postNo);

	SuggestionDao suggestionDao = SuggestionDao.getInstance();
	Suggestion suggestion = new Suggestion();
	try {
		suggestion.setPost(new Post(postNo));
		suggestion.setEmployee(emp);
		suggestionDao.insertSuggestion(suggestion);
		
		question.setSuggestionCount(question.getSuggestionCount() + 1);
		
		questionDao.updateQuestion(question);
	} catch (Exception e) {
		e.printStackTrace();
	}

	response.sendRedirect("detail.jsp?postNo=" + postNo);
%>