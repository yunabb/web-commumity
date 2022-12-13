<%@page import="com.community.vo.StoryPost"%>
<%@page import="com.community.dao.StoryPostDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%@ include file="../../common/logincheck.jsp" %>
<%
	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));

	StoryPostDao storyPostDao = StoryPostDao.getInstance();
	StoryPost storyPost = storyPostDao.getStoryPostByNo(postNo);
	
	storyPost.setSuggestionCount(storyPost.getSuggestionCount() + 1);
	
	storyPostDao.updateStoryPost(storyPost);
	
	response.sendRedirect("detail.jsp?postNo=" + postNo);
%>