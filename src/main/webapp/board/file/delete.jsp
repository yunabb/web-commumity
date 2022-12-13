<%@page import="com.community.vo.FileShare"%>
<%@page import="com.community.dao.FileShareDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" 
pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// TODO 로그인한 사용자가 본인의 글만 삭제할 수 있도록 추가해야함
	
	// 게시글번호를 조회한다.
	int no = StringUtils.stringToInt(request.getParameter("no"));
	
	// FileShareDao객체를 생성하고, getFileSharesByNo를 실행해서 게시글의 정보를 조회한다.
	FileShareDao fileShareDao = FileShareDao.getInstance();
	FileShare fileShare = fileShareDao.getFileSharesByNo(no);
	
	// 게시글정보의 삭제여부를 "Y"로 변경한다.
	// updateFileShare를 실행해서 변경된 정보를 db에 반영시킨다.
	fileShare.setDeleted("Y");
	fileShareDao.updateFileShare(fileShare);
	
	// 삭제작업에 대한 재요청URL을 응답으로 보낸다.
	response.sendRedirect("list.jsp");
%>
