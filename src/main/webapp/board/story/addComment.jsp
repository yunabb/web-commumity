<%@page import="com.community.dao.StoryPostDao"%>
<%@page import="com.community.dao.CommentDao"%>
<%@page import="com.community.vo.StoryPost"%>
<%@page import="com.community.vo.Comment"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%

	// 게시글번호, 작성자, 내용을 조회한다.
	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));
	String content = request.getParameter("content");
	
	// Comment 객체를 생성해서 댓글정보 저장
	Comment comment = new Comment();
	StoryPost storyPost = new StoryPost();
	comment.setStoryPost(storyPost);
	comment.setContent(content);
	
	// CommentDao 객체를 생성하고, insertComment 메소드 실행
	CommentDao commentDao = CommentDao.getInstance();
	commentDao.insertComment(comment);
	
	// StoryPostDao 객체를 생성하고, 
	StoryPostDao storyPostDao = StoryPostDao.getInstance();
	storyPostDao.getStoryPostByNo(postNo);
	
	// 조회된 게시글정보의 리뷰갯수를 1증가시킨다.
	storyPost.setCommentCount(storyPost.getCommentCount() + 1);
	
	// 변경된 게시글정보를 updateStoryPost 실행해서 반영시킨다.
	storyPostDao.updateStoryPost(storyPost);
	
	// 재요청 url
	response.sendRedirect("detail.jsp?postNo=" + postNo);
	
	
	
%>