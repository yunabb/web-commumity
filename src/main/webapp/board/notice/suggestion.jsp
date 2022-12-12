<%@page import="com.community.vo.Notice"%>
<%@page import="com.community.dao.NoticeDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%

	Employee loginedEmp = (Employee) session.getAttribute("loginedEmp");
	if(loginedEmp == null) {
		response.sendRedirect("../../loginform.jsp?error=deny");
		return;
	}
	
	int no = StringUtils.stringToInt(request.getParameter("no"));
	
	NoticeDao noticeDao = NoticeDao.getInstance();
	Notice notice = noticeDao.getNoticeByPostNo(no);
	
	notice.setSuggestionCount(notice.getSuggestionCount() + 1);
	notice.setReadCount(notice.getReadCount() -1);
	noticeDao.updateNotice(notice);
	
	response.sendRedirect("detail.jsp?no=" + no);
%>