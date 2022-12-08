<%@page import="com.community.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 세션에 저장된 직원정보를 확인한다.(로그인되어있는지 확인한다.)
	// 직원정보가 null이면 로그인화면으로 리다이렉트한다.
	
	Employee loginedEmp = (Employee) session.getAttribute("loginedEmp");
	if(loginedEmp == null) {
		response.sendRedirect("web-community/loginform.jsp?error=deny");
		return;
	}


%>