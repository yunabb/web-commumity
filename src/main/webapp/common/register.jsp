<%@page import="com.community.vo.Board"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.vo.Post"%>
<%@page import="com.community.dao.PostDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%
	// 사용자 정보를 가져와서 notice의 작성자번호에 저장해야 한다. 
	// User user (User) session.getAttribute("loginedUser");

	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String important = request.getParameter("important");
	
	Post post = new Post();
	post.setBoard(new Board(boardNo));
	post.setTitle(title);
	post.setContent(content);
	// loginUserId 정보를 받아온다
	// post.setEmployee(new Employee(loginUserId));
	post.setImportant(important);
	
	PostDao postDao = PostDao.getInstance();
	postDao.insertPost(post);
	
	response.sendRedirect("list.jsp");
%>