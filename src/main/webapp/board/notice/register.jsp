<%@page import="com.community.dao.BoardDao"%>
<%@page import="com.community.dao.NoticeDao"%>
<%@page import="com.community.vo.Notice"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.util.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%

	/* Employee loginedEmp = (Employee) session.getAttribute("loginedEmp");
	if(loginedEmp == null) {
		response.sendRedirect("../../loginform.jsp?error=deny");
		return;
	}
	
	BoardDao boardDao = BoardDao.getInstance();
	int boardNo = StringUtils.stringToInt("boardNo");
	Board board = boardDao.getBoardByNo(boardNo);
	
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String important = request.getParameter("important");
	String content = request.getParameter("content");
	
	Notice notice = new Notice();
	
	notice.setBoard(new Board(boardNo)); 		// 이 부분이 null값으로 전달되어 오류가 발생합니다.
	notice.setTitle(title);
	notice.setEmployees(new Employee(writer));
	notice.setImportant(important);
	notice.setContent(content);
	
	NoticeDao noticeDao = NoticeDao.getInstance();
	noticeDao.insertNotice(notice);
	
	response.sendRedirect("list.jsp"); */
%>