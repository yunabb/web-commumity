<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.dao.EmployeeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<% 
	// loginform에서 직원번호empNo, 패스워드password를 요청객체에서 조회한다.
	int empNo = StringUtils.stringToInt(request.getParameter("empNo"));
	String password = request.getParameter("password");
	
	// EmployeeDao 객체를 생성한다.
	EmployeeDao employeeDao = new EmployeeDao();
	
	// 저장된 직원정보가 없으면 error=fail 메세지를 띄우고 로그인페이지를 재요청한다.
	Employee savedEmp = employeeDao.getEmployeeByNo(empNo);
	if (savedEmp == null) {
		response.sendRedirect("loginform.jsp?error-fail");
		return;
	}
	
	// 비밀번호가 다르면 error=fail 메세지를 띄우고 로그인화면을 재요청한다.
	if (!savedEmp.getPassword().equals(password)) {
		response.sendRedirect("loginform.jsp?error=fail");
		return;
	}
	
	// 로그인을 완료했으면 세션객체에 직원정보를 저장한다.
	session.setAttribute("loginedEmp", savedEmp);
	
	// home.jsp로 응답을 보낸다.
	response.sendRedirect("home.jsp");


%>