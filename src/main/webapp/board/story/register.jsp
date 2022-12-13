<%@page import="com.community.dao.StoryPostDao"%>
<%@page import="com.community.vo.StoryPost"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.vo.Post"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.util.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// 로그인 여부 체크
	/* 
		Employee employee = (Employee) session.getAttribute("loginedUser");
		if(employee == null) {
			response.sendRedirect("../employee/loginform.jsp?error=deny");
			return;
		}
	*/
	
	int empNo = 1000;
	
	// modal-form-posts에서 name을 받아옴
	int boardNo = StringUtils.stringToInt("boardNo");
	String title = request.getParameter("title");
	String wtiter = request.getParameter("writer");
	String important = request.getParameter("important");
	String content = request.getParameter("content");
	
	StoryPost storyPost = new StoryPost();
	storyPost.setBoard(new Board(boardNo));
	storyPost.setTitle(title);
	storyPost.setEmployee(new Employee(empNo));
	storyPost.setContent(content);
	storyPost.setImportant(important);
	
	StoryPostDao storyPostDao = StoryPostDao.getInstance();
	storyPostDao.insertStoryPost(storyPost);
	
	response.sendRedirect("list.jsp");
%>