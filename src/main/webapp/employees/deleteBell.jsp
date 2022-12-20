<%@page import="com.community.vo.Bell"%>
<%@page import="com.community.dao.BellDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	int bellNo = StringUtils.stringToInt(request.getParameter("bellNo"));

	BellDao bellDao = BellDao.getInstance();
	Bell bell = bellDao.getBellByBellNo(bellNo);
	
	bell.setDeleted("Y");
	
	bellDao.deleteBell(bell);
	
	response.sendRedirect("mybells.jsp");
%>