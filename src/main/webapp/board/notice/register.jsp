<%@page import="com.community.dao.NoticeDao"%>
<%@page import="com.community.vo.Notice"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.util.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	// 로그인 여부 체크
	/* 
		Employee employee = (Employee) session.getAttribute("loginedUser");
		if(employee == null) {
			response.sendRedirect("..")	// employee 폴더의 employee
			return;
		}
	*/
	
	// modal-form-posts에서 name을 받아옴
	int boardNo = StringUtils.stringToInt("boardNo");
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String important = request.getParameter("important");
	String content = request.getParameter("content");
	
	Notice notice = new Notice();
	notice.setBoard(new Board(boardNo));
	notice.setTitle(title);
	notice.setEmployees(new Employee(writer));
	notice.setImportant(important);
	notice.setContent(content);
	
	NoticeDao noticeDao = NoticeDao.getInstance();
	noticeDao.insertNotice(notice);
	
	response.sendRedirect("list.jsp");
%>