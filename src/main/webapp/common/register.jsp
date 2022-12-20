<%@page import="com.community.dao.ReviewDao"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.vo.Post"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.util.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ include file="../../common/logincheck.jsp" %>
<%

	
	/* employee의 name 가져오기 */
	Employee writer = (Employee) session.getAttribute("loginedEmp");

	// modal-form-posts에서 name을 받아옴
	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));
	String title = request.getParameter("title");
	String important = request.getParameter("important");
	String content = request.getParameter("content");
	
	// ReviewDao에서 getReviewsRows를 호출해서 post의 commentCount에 저장
	
	
	Post post = new Post();
	post.setBoard(new Board(boardNo));
	post.setTitle(title);
	post.setEmployee(new Employee(writer.getEmpNo()));
	post.setImportant(important);
	post.setContent(content);
	
	PostDao postDao = PostDao.getInstance();
	postDao.insertPost(post);
	

	if(boardNo == 100) {
		response.sendRedirect("/web-community/board/notice/list.jsp");
	} else if(boardNo == 101) {
	if(boardNo == 101) {
		response.sendRedirect("/web-community/board/notice/list.jsp");
	} else if(boardNo == 102) {
		response.sendRedirect("/web-community/board/file/list.jsp");
	} else if(boardNo == 103) {
		response.sendRedirect("/web-community/board/temp/list.jsp");
	} else if(boardNo == 104) {
		response.sendRedirect("/web-community/board/qna/list.jsp");
	}
	}
%>