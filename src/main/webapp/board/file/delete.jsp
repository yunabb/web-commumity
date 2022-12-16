<%@page import="com.community.vo.FileShare"%>
<%@page import="com.community.dao.FileShareDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	
	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));
	
	FileShareDao fileShareDao = FileShareDao.getInstance();
	FileShare fileShare = fileShareDao.getFileSharesByNo(postNo);
	
	// 게시글 정보의 삭제여부를 Y로 변경하고, updateStoryPost 메소드를 실행해서 변경된 정보를 반영
	fileShare.setDeleted("Y");
	fileShareDao.updateFileShare(fileShare);
	
	// 재요청 url 응답으로 보낸다
	response.sendRedirect("list.jsp");
%>
