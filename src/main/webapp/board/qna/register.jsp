<%@page import="com.community.dao.QuestionDao"%>
<%@page import="com.community.vo.Question"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%
	// 사용자 정보를 가져와서 notice의 작성자번호에 저장해야 한다. 
	// User user (User) session.getAttribute("loginedUser");

	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String important = request.getParameter("important");
	
	Question question = new Question();
	question.setBoard(new Board(boardNo));
	question.setTitle(title);
	question.setContent(content);
	// loginUserId 정보를 받아온다
	// qustion.setEmployee(new Employee(loginUserId));
	question.setImportant(important);
	
	QuestionDao questionDao = QuestionDao.getInstance();
	questionDao.insertPost(question);
	
	response.sendRedirect("list.jsp");
%>