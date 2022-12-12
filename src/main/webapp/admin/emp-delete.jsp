<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.dao.EmployeeDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

	// 게시글 번호를 조회한다.
	int empNo = StringUtils.stringToInt(request.getParameter("no"));

	// BoardDao객체를 생성하고, getBoardByNo(int boardNo)를 실행해서 게시글 정보를 조회한다.
	EmployeeDao empDao = new EmployeeDao();
	Employee emp = empDao.getEmployeeByNo(empNo);
	
	// 게시글정보의 삭제여부를 "Y"로 변경한다.
	// BoardDao객체의 updateBoard(Board board)를 실행해서 변경된 정보를 반영시킨다.
	emp.setDeleted("Y");
	empDao.updateEmployee(emp);

	// 추가/변경/삭제 작업 중에서 삭제(사실은 변경)작업을 수행하였음으로 재요청URL을 응답으로 보내다.
	response.sendRedirect("employees.jsp");	
%>