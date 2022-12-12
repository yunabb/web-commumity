<%@page import="com.community.vo.Position"%>
<%@page import="com.community.dao.EmployeeDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.dao.PositionDao"%>
<%@page import="com.community.dao.DepartmentDao"%>
<%@page import="com.community.vo.Department"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	// DepartmentDao, PositionDao 객체를 생성한다.
	DepartmentDao deptDao = new DepartmentDao();
	PositionDao posDao = new PositionDao();

	// 회원가입 폼에서 제출한 폼 입력값을 요청한다.
	String password = request.getParameter("password");
	String password1 = request.getParameter("password1");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	Department dept = deptDao.getDeptByNo(StringUtils.stringToInt(request.getParameter("dept")));
	Position pos = posDao.getPositionByNo(StringUtils.stringToInt(request.getParameter("pos")));

	// Employee 객체를 생성해서 조회된 값을 저장한다.
	Employee emp = new Employee();
	emp.setPassword(password);
	emp.setName(name);
	emp.setEmail(email);
	emp.setPhone(phone);
	emp.setDepartment(dept);
	emp.setPosition(pos);
	
	EmployeeDao empDao = new EmployeeDao();
	
	empDao.insertEmployee(emp);
	
	response.sendRedirect("complete.jsp");






%>