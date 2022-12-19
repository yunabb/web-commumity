<%@page import="com.community.dao.NoticeDao"%>
<%@page import="com.community.vo.Notice"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.vo.Post"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.util.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	
	/* employee의 name 가져오기 */
	Employee writer = (Employee) session.getAttribute("loginedEmp");
	// modal-form-posts에서 name을 받아옴
	
	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));
	String title = request.getParameter("title");
	String important = request.getParameter("important");
	String content = request.getParameter("content");
	
	Notice notice = new Notice();
	notice.setBoard(new Board(boardNo));
	notice.setTitle(title);
	notice.setEmployee(new Employee(writer.getEmpNo()));
	notice.setImportant(important);
	notice.setContent(content);
	
	NoticeDao noticeDao = NoticeDao.getInstance();
	noticeDao.insertNotice(notice);
	
	if(boardNo == 100) {
		
		
		response.sendRedirect("/web-community/board/notice/list.jsp");
	} else if(boardNo == 101) {
		response.sendRedirect("/web-community/board/file/list.jsp");
	} else if(boardNo == 103) {
		response.sendRedirect("/web-community/board/temp/list.jsp");
	} else if(boardNo == 104) {
		response.sendRedirect("/web-community/board/qna/list.jsp");
	}
%>