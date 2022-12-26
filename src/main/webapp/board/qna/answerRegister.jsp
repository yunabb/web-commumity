<%@page import="com.community.dao.AnswerDao"%>
<%@page import="com.community.vo.Question"%>
<%@page import="com.community.vo.Answer"%>
<%@page import="com.community.dao.ReviewDao"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.vo.Post"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.util.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../../common/logincheck.jsp" %>
<%
	/* employee의 name 가져오기 */
	Employee writer = (Employee) session.getAttribute("loginedEmp");
	
	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));

	// modal-form-posts에서 name을 받아옴
	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	
	// answerDao 에서 insertAnswer를 호출 answer에 답변 등록
	
	Answer answer = new Answer();
	answer.setQuestion(new Question(postNo));
	answer.setEmployee(new Employee(writer.getEmpNo()));
	answer.setContent(content);
	
	AnswerDao answerDao = AnswerDao.getInstance();
	answerDao.insertAnswer(answer);
	
	response.sendRedirect("detail.jsp?postNo=" + postNo);
%>