<%@page import="com.community.vo.Notice"%>
<%@page import="com.community.dao.NoticeDao"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	Employee loginedEmp = (Employee) session.getAttribute("loginedEmp");
	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));
	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String imp = request.getParameter("important");
	String content = request.getParameter("content");
	
	NoticeDao noticeDao = NoticeDao.getInstance();
	Notice notice = noticeDao.getNoticeByPostNo(postNo);
	
	notice.setBoard(new Board(boardNo));
	notice.setTitle(title);
	notice.setEmployee(new Employee(writer));
	notice.setImportant(imp);
	notice.setContent(content);
	
	noticeDao.updateNotice(notice);
	
	response.sendRedirect("detail.jsp?no=" + postNo);
%>