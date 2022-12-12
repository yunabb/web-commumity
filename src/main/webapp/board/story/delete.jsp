<%@page import="com.community.vo.StoryPost"%>
<%@page import="com.community.dao.StoryPostDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%
	// 게시글 번호를 조회한다.
	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));
	
	StoryPostDao storyPostDao = StoryPostDao.getInstance();
	StoryPost storyPost = storyPostDao.getStoryPostByNo(postNo);
	
	// 게시글 정보의 삭제여부를 Y로 변경하고, updateStoryPost 메소드를 실행해서 변경된 정보를 반영
	storyPost.setDeleted("Y");
	storyPostDao.updateStoryPost(storyPost);
	
	// 재요청 url 응답으로 보낸다
	response.sendRedirect("list.jsp");
%>