<%@page import="com.community.vo.Notice"%>
<%@page import="com.community.dao.NoticeDao"%>
<%@page import="com.community.vo.Comment"%>
<%@page import="com.community.dao.CommentDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>

<%
	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));
	int commentNo = StringUtils.stringToInt(request.getParameter("commentNo"));
	
	
	CommentDao commentDao = CommentDao.getInstance();
	Comment comment = commentDao.getComment(commentNo);
	comment.setDeleted("Y");
	
	commentDao.updateComment(comment);
	
	NoticeDao noticeDao = NoticeDao.getInstance();
	Notice notice = noticeDao.getNoticeByPostNo(postNo);
	
	notice.setCommentCount(notice.getCommentCount() - 1);
	notice.setReadCount(notice.getReadCount() - 1);
	noticeDao.updateNotice(notice);
	
	response.sendRedirect("detail.jsp?no=" + postNo);
%>