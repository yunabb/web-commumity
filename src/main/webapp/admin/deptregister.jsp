<%@page import="com.community.vo.Position"%>
<%@page import="com.community.dao.EmployeeDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.dao.PositionDao"%>
<%@page import="com.community.dao.DepartmentDao"%>
<%@page import="com.community.vo.Department"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	// DepartmentDao 객체를 생성한다.
	DepartmentDao deptDao = new DepartmentDao();

	// 부서이름을 불러온다.
	String name = request.getParameter("name");

	// Department 객체를 생성해서 조회된 값을 저장한다.
	Department dept = new Department();
	dept.setName(name);
	
	// DB에 저장한다.
	deptDao.insertDept(dept);
	
	// 부서&직위 관리 페이지로 리다이렉트한다.
	response.sendRedirect("depts.jsp");






%>