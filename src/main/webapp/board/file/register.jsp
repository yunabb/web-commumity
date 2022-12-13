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
	
	int boardNo = StringUtils.stringToInt("boardNo");
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String important = request.getParameter("important");
	String content = request.getParameter("content");
	
	FileShare fileShare = new FileShare();
	fileShare.setBoard(new Board(boardNo));
	fileShare.setTitle(title);
	fileShare.setEmployee(new Employee(writer));
	fileShare.setContent(content);
	fileShare.setImportant(important);
	
	FileShareDao fileShareDao = FileShareDao.getInstance();
	fileShareDao.insertFileShare(fileShare);
	
	response.sendRedirect("list.jsp");
%>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>