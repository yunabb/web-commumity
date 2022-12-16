<%@page import="com.community.vo.Board"%>
<%@page import="com.community.vo.Question"%>
<%@page import="com.community.dao.QuestionDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	Employee emp = (Employee) session.getAttribute("loginedEmp");

	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));

	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String imp = request.getParameter("important");
	String content = request.getParameter("content");
	
	QuestionDao questionDao = QuestionDao.getInstance();
	Question question = questionDao.getQuestionByNo(postNo);
	
	question.setBoard(new Board(boardNo));
	question.setTitle(title);
	question.setEmployee(new Employee(writer));
	question.setImportant(imp);
	question.setContent(content);
	
	questionDao.updateQuestion(question);
	
	
	
	response.sendRedirect("detail.jsp?postNo=" + postNo);
%>