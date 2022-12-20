<%@page import="com.community.vo.Post"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="../../common/logincheck.jsp" %>
<%
	// 게시글 번호를 조회한다.
	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));
	System.out.print(postNo);
	
	PostDao postDao = PostDao.getInstance();
	Post post = postDao.getPostByNo(postNo);
	
	// 게시글 정보의 삭제여부를 Y로 변경
	post.setDeleted("Y");
	postDao.updatePost(post);
	
	// 리다이렉트
	response.sendRedirect("myposts.jsp");
%>