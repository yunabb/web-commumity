<%@page import="com.community.vo.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.community.util.Pagination"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.community.dao.PostDao"%>
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
<jsp:include page="../common/header.jsp">
	<jsp:param name="menu" value="admin"/>
</jsp:include>
<div class="container my-3">
<%
	// 요청한 페이지번호를 조회하고, 값이 존재하지 않으면 기본값인 1페이지가 나오도록 설정한다.
	int rows = StringUtils.stringToInt(request.getParameter("rows"), 10);
	String opt = StringUtils.nullToValue(request.getParameter("opt"), "title");
	int currentPage = StringUtils.stringToInt(request.getParameter("page"), 1);
	String keyword = StringUtils.nullToValue(request.getParameter("keyword"), "");
	
	PostDao postDao = PostDao.getInstance();
	
	Map<String, Object> param = new HashMap<>();
	
	// 게시글 갯수 조회
	int totalRows = postDao.getTotalRows(param);
	// pagination 객체 생성
	Pagination pagination = new Pagination(currentPage, totalRows, rows);
	
	// 게시글 목록 조회
	param.put("begin", pagination.getBegin());
	param.put("end", pagination.getEnd());
	
	List<Post> postList = postDao.getPosts(param);
	
%>
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">게시물 관리</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="card">
				<div class="card-header">전체 게시판 목록</div>
				<div class="card-body">
					<div class="row p-3">
						<div class="col-3 border p-3">
							<p>전체 게시판목록을 확인하세요.</p>
							<jsp:include page="../common/tree.jsp"/>
						</div>
						<div class="col-9">
							<form class="border p-3" method="get" action="">
								<table class="table table-sm">
									<colgroup>
										<col width="5%">
										<col width="10%">
										<col width="*">
										<col width="10%">
										<col width="10%">
										<col width="20%">
									</colgroup>
									<thead>
										<tr>
											<th><input type="checkbox"></th>
											<th>번호</th>
											<th>제목</th>
											<th>상태</th>
											<th>작성자</th>
											<th>등록일</th>
										</tr>
									</thead>
									<tbody>
									<%
										if (postList.isEmpty()) {
									%>
										<tr>
											<td colspan="6" class="text-center">게시글 정보가 없습니다.</td>
										</tr>
									<%
										} else {
											for (Post post : postList) {
									%>
										<tr>
											<td><input type="checkbox" name="" value=""/></td>
											<td><%=post.getPostNo() %></td>
											<td><%=post.getTitle() %></td>
											<td><%=post.getDeleted().equals("Y") ? "삭제" : "미삭제" %></td>
											<td><%=post.getEmployee().getName() %></td>
											<td><%=StringUtils.dateToText(post.getCreatedDate()) %></td>
										</tr>
										<%
												}
											}
										%>
									</tbody>
								</table>
<%
	if (!postList.isEmpty()) {
		int beginPage = pagination.getBeginPage();	// 시작 페이지번호
		int endPage = pagination.getEndPage();		// 끝 페이지번호
		boolean isFirst = pagination.isFirst();		// 첫 페이지여부
		boolean isLast = pagination.isLast();		// 마지막 페이지여부
		int prevPage = pagination.getPrevPage();	// 이전 페이지번호
		int nextPage = pagination.getNextPage();	// 다음 페이지번호
%>
								<nav>
									<ul class="pagination pagination-sm justify-content-center">
										<li class="page-item disabled">
											<a class="page-link <%=isFirst ? "disabled" : "" %>" href="posts.jsp?page=<%=prevPage %>">이전</a>
										</li>
<%
		for (int num = beginPage; num <= endPage; num++) {
%>
										<li class="page-item">
											<a class="page-link <%=num == currentPage ? "active" : "" %>" href="posts.jsp?page<%=num %>"><%=num %></a>
										</li>
<%
		}
%>	
										<li class="page-item">
											<a class="page-link <%=isLast ? "disabled" : "" %>" href="posts.jsp?page=<%=nextPage %>">다음</a>
										</li>
									</ul>
								</nav>
<%
	}
%>
								<div class="text-end">
									<button type="button" class="btn btn-outline-dark btn-sm">복구</button>
									<button type="button" class="btn btn-outline-dark btn-sm">이동</button>
									<button type="button" class="btn btn-outline-dark btn-sm">삭제</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>