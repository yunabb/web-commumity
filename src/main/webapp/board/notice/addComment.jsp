<%@page import="com.community.vo.Post"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.dao.NoticeDao"%>
<%@page import="com.community.vo.Notice"%>
<%@page import="com.community.dao.CommentDao"%>
<%@page import="com.community.vo.StoryPost"%>
<%@page import="com.community.vo.Comment"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%

	Employee loginedEmp = (Employee) session.getAttribute("loginedEmp");
	if(loginedEmp == null) {
		response.sendRedirect("/web-community/loginform.jsp?error=deny");
		return;
	}
	// 게시글번호, 작성자, 내용을 조회한다.
	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));
	String content = request.getParameter("content");
	
	Comment comment = new Comment();
	comment.setEmployee(loginedEmp);
	comment.setPost(new Post(postNo));
	comment.setContent(content);
	
	CommentDao commentDao = CommentDao.getInstance();
	
	commentDao.insertComment(comment);
	
	NoticeDao noticeDao = NoticeDao.getInstance();
	Notice notice = noticeDao.getNoticeByPostNo(postNo);
	notice.setCommentCount(notice.getCommentCount() + 1);
	notice.setReadCount(notice.getReadCount() - 1);
	noticeDao.updateNotice(notice);
	
	// 재요청 url
	response.sendRedirect("detail.jsp?no=" + postNo);
%>