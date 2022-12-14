<%@page import="com.community.dao.QuestionDao"%>
<%@page import="com.community.vo.Question"%>
<%@page import="com.community.dao.ReviewDao"%>
<%@page import="com.community.vo.Post"%>
<%@page import="com.community.vo.Review"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	Employee emp = (Employee) session.getAttribute("loginedEmp");

	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));
	String content = request.getParameter("content");
	
	
	Review review = new Review();
	review.setPost(new Post(postNo));
	review.setContent(content);
	review.setEmployee(new Employee(emp.getEmpNo()));
	
	ReviewDao reviewDao = ReviewDao.getInstance();
	reviewDao.insertReview(review);
	
	QuestionDao questionDao = QuestionDao.getInstance();
	Question question = questionDao.getQuestionByNo(postNo); 
	
	question.setCommentCount(question.getCommentCount() + 1);

	questionDao.updateQuestion(question);
	
	response.sendRedirect("detail.jsp?postNo=" + postNo);
%>