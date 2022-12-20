<%@page import="com.community.vo.Bell"%>
<%@page import="com.community.dao.BellDao"%>
<%@page import="java.sql.Date"%>
<%@page import="com.community.vo.Question"%>
<%@page import="com.community.dao.QuestionDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.vo.Review"%>
<%@page import="com.community.dao.ReviewDao"%>
<%@page import="com.community.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	int reviewNo = StringUtils.stringToInt(request.getParameter("reviewNo"));
	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));
	
	ReviewDao reviewDao = ReviewDao.getInstance();
	Review review = reviewDao.getReview(reviewNo);
	
	review.setDeleted("Y");
	
	reviewDao.updateReview(review);
	
	QuestionDao questionDao = QuestionDao.getInstance();
	Question question = questionDao.getQuestionByNo(postNo);
	
	question.setCommentCount(question.getCommentCount() - 1);
	
	questionDao.updateQuestion(question);
	
	BellDao bellDao = BellDao.getInstance();
	Bell bell = bellDao.getBellByReviewNo(reviewNo + 1);
	
	bell.setDeleted("Y");
	
	bellDao.deleteBell(bell);
	
	response.sendRedirect("detail.jsp?postNo=" + postNo);
%>