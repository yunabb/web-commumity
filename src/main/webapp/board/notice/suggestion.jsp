<%@page import="com.community.dao.SuggestionDao"%>
<%@page import="com.community.vo.Post"%>
<%@page import="com.community.vo.Suggestion"%>
<%@page import="com.community.vo.Notice"%>
<%@page import="com.community.dao.NoticeDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	Employee loginedEmp = (Employee) session.getAttribute("loginedEmp");
	int postNo = StringUtils.stringToInt(request.getParameter("no"));
	
	NoticeDao noticeDao = NoticeDao.getInstance();
	Notice notice = noticeDao.getNoticeByPostNo(postNo);
	Suggestion suggestion = new Suggestion();
	SuggestionDao suggestionDao = SuggestionDao.getInstance();
	try {
		suggestion.setPost(new Post(postNo));
		suggestion.setEmployee(loginedEmp);
		suggestionDao.insertSuggestion(suggestion);
		notice.setSuggestionCount(notice.getSuggestionCount() + 1);
		notice.setReadCount(notice.getReadCount() -1);
		
		noticeDao.updateNotice(notice);
	} catch(Exception e) {
	}
	
	response.sendRedirect("detail.jsp?no=" + postNo);
%>