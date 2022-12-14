<%@page import="com.community.vo.Notice"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.dao.NoticeDao"%>
<%@page import="com.community.vo.Employee"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	Employee loginedEmp = (Employee) session.getAttribute("loginedEmp");
	if(loginedEmp == null) {
		response.sendRedirect("../../loginform.jsp?error=deny");
		return;
	}
	
	int noticeNo = StringUtils.stringToInt(request.getParameter("no"));
	
	NoticeDao noticeDao = NoticeDao.getInstance();
	Notice notice = noticeDao.getNoticeByPostNo(noticeNo);
	System.out.println("[" + loginedEmp.getEmpNo() + "]");
	System.out.println("[" + notice.getEmployees().getEmpNo() + "]");
	Employee emp = new Employee(loginedEmp.getEmpNo());
	// 로그인한 사용자의 아이디와 게시글 작성자의 아이디가 서로다르면 게시글을 삭제할 수 없다.
	// detail.jsp를 재요청하는 URL을 응답으로 보낸다.
	
	/* if(emp.getEmpNo().equals(notice.getEmployees().getEmpNo())) {
		response.sendRedirect("detail.jsp?no=" + noticeNo + "&error=deny");
		return;
	} */
	notice.setDeleted("Y");
	noticeDao.updateNotice(notice);
	
	response.sendRedirect("list.jsp");
%>