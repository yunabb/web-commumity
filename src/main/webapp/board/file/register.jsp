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
	// TODO 로그인한 직원번호를 empNo에 대입한다.
	int empNo  = 1000;
	
	// 요청객체에 저장된 요청파라미터값을 가져온다.
	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));
	String title = request.getParameter("title");
	String important = request.getParameter("important");
	String content = request.getParameter("content");
	
	// 조회된 요청파라미터값을 FileShare객체에 저장한다.
	FileShare fileShare = new FileShare();
	fileShare.setBoard(new Board(boardNo));
	fileShare.setTitle(title);
	fileShare.setEmployee(new Employee(empNo));
	fileShare.setImportant(important);
	fileShare.setContent(content);
	
	// FileShareDao객체를 생성하고 insertFileShare메소드를 실행해서 게시글 정보를 저장시킨다.
	FileShareDao fileShareDao = FileShareDao.getInstance();
	fileShareDao.insertFileShare(fileShare);
	
	response.sendRedirect("list.jsp");

%>
   
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>