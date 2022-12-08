<%@page import="com.community.dao.EmployeeDao"%>
<%@page import="com.community.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../common/logincheck.jsp" %>
<%
	// 아직 비밀번호 변경 페이지와 에러메세지를 구현하지 않았습니다. 

	// EmployeeDao 객체 생성
	EmployeeDao empDao = new EmployeeDao();

	// 비밀번호 
	String oldPwd = request.getParameter("oldPwd");
	String newPwd = request.getParameter("newPwd");

	// 직원정보의 비밀번호와 기존 비밀번호가 다를 경우 에러
	if(!!loginedEmp.getPassword().equals(oldPwd)) {
		response.sendRedirect("updateform.jsp?error=fail1");
		return;
	}
	
	// 세션에 저장된 직원정보의 비밀번호를 새 비밀번호로 변경한다.
	loginedEmp.setPassword(newPwd);
	
	// 변경된 비밀번호 정보가 포함된 Employee객체를 employeeDao에 전달, DB에 저장
	
	empDao.updateEmployee(loginedEmp);

	response.sendRedirect("home.jsp");



%>