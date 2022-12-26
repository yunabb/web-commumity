<%@page import="com.community.vo.Question"%>
<%@page import="com.community.dao.QuestionDao"%>
<%@page import="com.community.vo.Post"%>
<%@page import="com.community.dao.FileDao"%>
<%@page import="com.community.vo.File"%>
<%@page import="com.community.util.MultipartRequest"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
	Employee emp = (Employee) session.getAttribute("loginedEmp");

	int boardNo = StringUtils.stringToInt(request.getParameter("boardNo"));
	String title = request.getParameter("title");
	String writer = request.getParameter("writer");
	String important = request.getParameter("important");
	String content = request.getParameter("content");
	
	MultipartRequest mr = new MultipartRequest(request, "C:\\file");
	
	String[] filenames = mr.getFilenames("attachedFile");
	
	QuestionDao questionDao = QuestionDao.getInstance();
	
	int sequence = questionDao.getSequence(); 
	
	Question question = new Question();
	question.setPostNo(sequence);
	question.setBoard(new Board(boardNo));
	question.setTitle(title);
	question.setEmployee(emp);
	question.setContent(content);
	
	questionDao.insertQuestion(question);
	
	FileDao fileDao = FileDao.getInstance();
	
	for (String filename : filenames) {
		File file = new File();
		file.setName(filename);
		
		fileDao.insertFile(file);
	} 
	
	response.sendRedirect("list.jsp");
%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>