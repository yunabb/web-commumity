<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Position"%>
<%@page import="com.community.vo.Department"%>
<%@page import="com.community.dao.PositionDao"%>
<%@page import="com.community.dao.DepartmentDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.dao.EmployeeDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	int empNo = StringUtils.stringToInt(request.getParameter("no"));
	

	// Dao 객체 생성
	EmployeeDao empDao = new EmployeeDao();
	DepartmentDao deptDao = new DepartmentDao();
	PositionDao posDao = new PositionDao();

	// modifyform에서 변경할 직원정보emp와 dept, pos 객체를 받아온다.
	Employee emp = empDao.getEmployeeByNo(empNo);
	Department dept = deptDao.getDeptByNo(StringUtils.stringToInt(request.getParameter("dept")));
	Position pos = posDao.getPositionByNo(StringUtils.stringToInt(request.getParameter("pos")));

	// 세션에 저장된 직원정보의 부서, 직위를 변경한다.
	emp.setDepartment(dept);
	emp.setPosition(pos);
	
	// 변경된 비밀번호 정보가 포함된 Employee객체를 employeeDao에 전달, DB에 저장
	
	empDao.updateEmployee(emp);

	response.sendRedirect("employees.jsp");



%>