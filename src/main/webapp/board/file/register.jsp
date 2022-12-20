<%@page import="com.community.vo.Post"%>
<%@page import="com.community.dao.FileDao"%>
<%@page import="com.community.vo.File"%>
<%@page import="com.community.util.MultipartRequest"%>
<%@page import="com.community.dao.FileShareDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.vo.FileShare"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<title>웹 애플리케이션</title>
</head>
<body>
<div class="container">
<%
	Employee emp = (Employee) session.getAttribute("loginedEmp");

	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String important = request.getParameter("important");
	String content = request.getParameter("content");
	
	
/*  	MultipartRequest mr = new MultipartRequest(request, "C:\\app\\web-workspace\\temp"); */
	
	/* String name = mr.getParameter("name");
	String fileContent = mr.getParameter("fileContent");
	String[] filenames = mr.getFilenames("attachedFile"); */
	
	FileShareDao fileShareDao = FileShareDao.getInstance();
	
	int sequence = fileShareDao.getSequence(); 
	
	FileShare fileShare = new FileShare();
	fileShare.setPostNo(sequence);
	fileShare.setBoard(new Board(boardNo));
	fileShare.setTitle(title);
	fileShare.setEmployee(emp);
	fileShare.setContent(content);
	
	fileShareDao.insertFileShare(fileShare);
	
	/* FileDao fileDao = FileDao.getInstance();
	
	for (String filename : filenames) {
		File file = new File();
		file.setName(name);
		
		fileDao.insertFile(file);
	} */
	
	response.sendRedirect("list.jsp");
%>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>