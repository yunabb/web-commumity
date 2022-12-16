<%@page import="com.community.dao.StoryPostDao"%>
<%@page import="com.community.vo.StoryPost"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.vo.Post"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.util.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../../common/logincheck.jsp" %>
<%	
	Employee emp = (Employee) session.getAttribute("loginedEmp");
	
	// modal-form-posts에서 name을 받아옴
	int boardNo = StringUtils.stringToInt("boardNo");
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String important = request.getParameter("important");
	String content = request.getParameter("content");
	
	StoryPost storyPost = new StoryPost();
	storyPost.setBoard(new Board(boardNo));
	storyPost.setTitle(title);
	storyPost.setEmployee(new Employee(writer));
	storyPost.setContent(content);
	storyPost.setImportant(important);
	
	StoryPostDao storyPostDao = StoryPostDao.getInstance();
	storyPostDao.insertStoryPost(storyPost);
	
	response.sendRedirect("list.jsp");
%>