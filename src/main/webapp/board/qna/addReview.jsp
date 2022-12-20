<%@page import="com.community.dao.BellDao"%>
<%@page import="com.community.vo.Bell"%>
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
	String content = request.getParameter("reviewContent");
	
	ReviewDao reviewDao = ReviewDao.getInstance();
	int sequence = reviewDao.getSequence();	
	
	Review review = new Review();
	review.setReviewNo(sequence);
	review.setPost(new Post(postNo));
	review.setContent(content);
	review.setEmployee(new Employee(emp.getEmpNo()));
	reviewDao.insertReview(review);
	
	QuestionDao questionDao = QuestionDao.getInstance();
	Question question = questionDao.getQuestionByNo(postNo); 
	
	question.setCommentCount(question.getCommentCount() + 1);

	questionDao.updateQuestion(question);
	
	
	Bell bell = new Bell();
	bell.setReview(new Review(sequence));
	bell.setPost(new Post(postNo));
	bell.setSendEmp(emp);
	bell.setReceiveEmp(new Employee(question.getEmployee().getEmpNo()));
	
	BellDao bellDao = BellDao.getInstance();
	bellDao.insertBell(bell);
	
	response.sendRedirect("detail.jsp?postNo=" + postNo);
%>