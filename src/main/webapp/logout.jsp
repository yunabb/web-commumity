<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//기존 세션객체(직원정보)를 무효화한다.
	session.invalidate();
	
	// 재요청 URL(home.jsp)를 응답으로 보낸다.
	response.sendRedirect("home.jsp");
	
%>