<%@page import="com.community.vo.Post"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.dao.FileDao"%>
<%@page import="com.community.vo.File"%>
<%@page import="java.util.List"%>
<%@page import="com.community.dao.CommentDao"%>
<%@page import="com.community.vo.Comment"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.dao.EmployeeDao"%>
<%@page import="com.community.vo.FileShare"%>
<%@page import="com.community.dao.FileShareDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css">
<link href="/web-community/resources/css/style.css" rel="stylesheet">
<title>사내 커뮤니티</title>
</head>
<body>
<jsp:include page="../../common/header.jsp">
	<jsp:param name="menu" value="board"/>
</jsp:include>
<%
	Employee emp = (Employee) session.getAttribute("loginedEmp");
%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">게시글 상세정보</h1>
		</div>
	</div>
<%
	// list의 글 번호를 조회
	int postNo = StringUtils.stringToInt(request.getParameter("postNo"));

	FileShareDao fileShareDao = FileShareDao.getInstance();
	FileShare fileShare = fileShareDao.getFileSharesByNo(postNo);
	
	// 조회수를 1 증가시키고, 테이블에 반영
	fileShare.setReadCount(fileShare.getReadCount() + 1);
	fileShareDao.updateFileShare(fileShare);
	
	CommentDao commentDao = CommentDao.getInstance();
	List<Comment> comments = commentDao.getCommentsByPostNo(postNo);
	
	FileDao fileDao = FileDao.getInstance();
	List<File> files = fileDao.getFilesByPostNo(postNo);
	
	PostDao postDao = PostDao.getInstance();
	Post post = postDao.getPostByNo(postNo);
	
%>	
	<div class="row mb-3">
		<div class="col-12">
			<table class="table table-sm table-bordered">
				<colgroup>
					<col width="15%">
					<col width="35%">
					<col width="15%">
					<col width="35%">
				</colgroup>
				<tbody>
					<tr>
						<th class="text-center bg-light">번호</th>
						<td><%=fileShare.getPostNo() %></td>
						<th class="text-center bg-light">등록일</th>
						<td><%=StringUtils.dateToText(fileShare.getCreatedDate()) %></td>
					</tr>
					<tr>
						<th class="text-center bg-light">제목</th>
						<td><%=fileShare.getTitle() %></td>
						<th class="text-center bg-light">추천수</th>
						<td><%=fileShare.getSuggestionCount() %></td>
					</tr>
					<tr>
						<th class="text-center bg-light">작성자</th>
						<td><%=fileShare.getEmployee().getName() %> (<%=fileShare.getPosition().getName() %>)</td>
						<th class="text-center bg-light">소속부서</th>
						<td><%=fileShare.getDepartment().getName() %></td>
					</tr>
					<tr>
						<th class="text-center bg-light">조회수</th>
						<td><%=fileShare.getReadCount() %></td>
						<th class="text-center bg-light">댓글 수</th>
						<td><%=fileShare.getCommentCount() %></td>
					</tr>
					
					<tr>
					<th class="text-center bg-light">첨부파일</th>
					<td colspan="3">
					<%
						if (files.isEmpty()) {
					%>	
							첨부파일이 없습니다.
					<%
						} else {
							for (File file : files) {
					%>
						<a href="/web-community/download?filename=<%=file.getName()%>" class="btn btn-light btn-xs"><%=file.getName() %></a> 
					<%					
							}
						}
					%>
						
					</td>
				</tr>
					<tr>
						<th class="text-center bg-light">내용</th>
						<td colspan="3"><textarea rows="4" class="form-control border-0" readonly><%=fileShare.getContent() %></textarea> </td>
					</tr>
				</tbody>
			</table>
			<div class="d-flex justify-content-between">
				<span>
					<a href="list.jsp" class="btn btn-dark btn-xs" >목록</a>
<%
	if (emp != null && emp.getName().equals(fileShare.getEmployee().getName())) {
%>					
					<a href="delete.jsp?postNo=<%=fileShare.getPostNo() %>" class="btn btn-danger btn-xs">삭제</a>
					<a href="" class="btn btn-warning btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-posts">수정</a>					
<%
	}
%>
				</span>
				<span>	
<% 
	if (emp == null || emp.getName().equals(fileShare.getEmployee().getName()))	{
%>							
					<a href="suggestion.jsp?postNo=<%=fileShare.getPostNo() %>" 
					class="btn btn-outline-primary btn-xs disabled" onclick="suggestion()">추천</a>				
<%
	} else {
%>			
		<a href="suggestion.jsp?postNo=<%=fileShare.getPostNo() %>" 
		class="btn btn-outline-primary btn-xs" onclick="suggestion()">추천</a>			
<%
	}
%>		
				</span>
			</div>
		</div>
	</div>
	
	<div class="row mb-3">
		<div class="col-12 mb-1">
			<form method="post" action="addComment.jsp">
				<!-- 게시글의 글 번호을 value에 설정하세요 -->
				<input type="hidden" name="postNo" value="<%=fileShare.getPostNo() %>"/>
				<div class="row mb-3">
					<div class="col-sm-11">
						<input type="text" class="form-control form-control-sm" name="content" placeholder="댓글을 남겨주세요">
					</div>
					<div class="col-sm-1 text-end" style="margin-top: 2px;" >
						<a href="addComment.jsp?postNo=<%=fileShare.getPostNo()%>">
						<button class="btn btn-secondary btn-xs" >댓글</button></a>
					</div>
				</div>
			</form>
		</div>
		
		<div class="col-12">
			<div class="card">
				<!-- 댓글 반복 시작 -->		
				<%
					for (Comment comment : comments) {
				%>	
					<div class="card-body py-1 px-3 small border-bottom">
					<div class="mb-1 d-flex justify-content-between text-muted">
						<span><%=comment.getEmployee().getName() %></span>
						<span><span class="me-4"><%=StringUtils.dateToText(comment.getCreatedDate()) %>
						</span> <a href="deleteComment.jsp?postNo=<%=fileShare.getPostNo() %>
						&commentNo=<%=comment.getCommentNo() %>" 
							class="text-danger"><i class="bi bi-trash-fill"></i></a></span>
					</div>
					<p class="card-text"><%=comment.getContent() %></p>
				</div>
				<%
						}
				%>
				<!-- 댓글 반복 끝 -->
			</div>				
		</div>
	</div>
</div>
<div class="modal" tabindex="-1" id="modal-form-posts">
	<div class="modal-dialog modal-lg">
	<form class="border p-3 bg-light" method="post" action="modify.jsp">
		<!-- 게시글의 글 번호을 value에 설정하세요 -->
		<input type="hidden" name="postNo" value="<%=fileShare.getPostNo() %>"/>
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">게시글 수정</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">게시판 이름</label>
						<div class="col-sm-5">
							<select class="form-select form-select-sm" name="boardNo">
								<option value="100"> 공지사항</option>
								<option value="101"> 파일게시판</option>
								<option value="102"> 자유게시판</option>
								<option value="103"> 임시게시판</option>
								<option value="104"> 묻고 답하기</option>
								<option value="105"> 사는 얘기</option>
							</select>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" name="title" placeholder="<%=fileShare.getTitle() %>" value="<%=fileShare.getTitle() %>">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">작성자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" readonly="readonly" value="<%=fileShare.getEmployee().getName() %>">
						</div>
					</div>
					<div class="row mb-2">
						<div class="col-sm-8 offset-sm-2">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="important" value="N" checked>
								<label class="form-check-label">일반</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="important" value="Y" >
								<label class="form-check-label">중요</label>
							</div>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">내용</label>
						<div class="col-sm-10">
							<textarea rows="5" class="form-control" name="content"><%=fileShare.getContent()%></textarea>
						</div>
					</div>
						<%-- 수정폼에 첨부파일 추가
						<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">첨부파일</label>
						<div class="col-sm-9 mb-1">
							<input type="file" class="form-control form-control-sm" name="attachedFile"/>
						<div class="col-sm-1">
							<button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
						</div>
					</div>
				</div> --%>
					
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-xs">수정</button>
			</div>
		</div>
	</form>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
function suggestion() {
	alert("추천되었습니다.");
}
</script>
</body>
</html>