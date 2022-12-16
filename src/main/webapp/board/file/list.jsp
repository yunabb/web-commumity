<%@page import="com.community.dao.FileDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.dao.BoardDao"%>
<%@page import="com.community.vo.FileShare"%>
<%@page import="com.community.dao.FileShareDao"%>
<%@page import="java.util.List"%>
<%@page import="com.community.util.Pagination"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
<title>파일게시판</title>
</head>
<body>
<jsp:include page="../../common/header.jsp">
	<jsp:param name="menu" value="board"/>
</jsp:include>
<div class="container my-3">
<%

	int rows = StringUtils.stringToInt(request.getParameter("rows"), 10);
	String sort = StringUtils.nullToValue(request.getParameter("sort"), "date");
	int currentPage = StringUtils.stringToInt(request.getParameter("page"), 1);
	String opt = StringUtils.nullToValue(request.getParameter("opt"), "title");
	String keyword = StringUtils.nullToValue(request.getParameter("keyword"), "");
	
	FileShareDao fileShareDao = FileShareDao.getInstance();
	FileDao fileDao = FileDao.getInstance();
	
	Map<String, Object> param = new HashMap<>();
	if (!opt.isEmpty() && !keyword.isEmpty()) {
		param.put("opt", opt);		
		param.put("keyword", keyword);		
	}
	
	int totalRows = fileShareDao.getTotalRows(param);
	
	Pagination pagination = new Pagination(currentPage, totalRows, rows);
	
	param.put("sort", sort);
	param.put("begin", pagination.getBegin());
	param.put("end", pagination.getEnd());
	
	List<FileShare> fileShareList = fileShareDao.getFileShares(param);
	
	Employee emp = (Employee) session.getAttribute("loginedEmp");

%>
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">파일게시판</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-3">
			<div class="card">
				<div class="card-header">전체 게시판 목록</div>
				<div class="card-body">
					<div class="d-grid gap-2">
						<button class="btn btn-dark btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#modal-form-posts">파일 등록</button>
					</div>
					<jsp:include page="../../common/tree.jsp" />
				</div>
			</div>
		</div>
		<div class="col-9">
			<div class="card">
				<div class="card-header">파일게시판</div>
				<div class="card-body">
					<form class="mb-3" method="get" action="list.jsp">
					<input type="hidden" name="page" value="<%=currentPage %>" />
					<input type="hidden" name="sort" value="<%=sort %>" />
						<div class="mb-2 d-flex justify-content-between">
							<div>
								<select class="form-select form-select-xs" name="rows" onchange="changeRows()">
									<option value="10" > 10</option>
									<option value="15" > 15</option>
									<option value="20" > 20</option>
								</select>
							</div>
							<div>
								<small><input type="checkbox"> 안읽은 게시글</small>
							
								<select class="form-select form-select-xs">
									<option value="title"<%="title".equals(opt) ? "selected" : "" %>> 제목</option>
									<option value="writer"<%="writer".equals(opt) ? "selected" : "" %>> 작성자</option>
									<option value="content"<%="content".equals(opt) ? "selected" : "" %>> 내용</option>
								</select>
								<input type="text" class="form-control form-control-xs w-150" name="keyword" value="<%=keyword %>">
								<button type="button" class="btn btn-outline-secondary btn-xs" onclick="submitForm(1)">검색</button>
							</div>
						</div>
						<table class="table table-sm border-top">
							<colgroup>
								<col width="3%">
								<col width="9%">
								<col width="25">
								<col width="20%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
							</colgroup>
							<thead>
								<tr class="bg-light">
									<th><input type="checkbox"></th>
									<th>번호</th>
									<th><i class="bi bi-paperclip"></i></th>
									<th>제목</th>
									<th>작성자</th>
									<th>등록일</th>
									<th>조회</th>
									<th>추천</th>
								</tr>
							</thead>
							<tbody>
<%
	if (fileShareList.isEmpty()) {
%>
		<tr><td class="text-center" colspan="7"> 게시글 정보가 없습니다. </td></tr>
<%
	} else {
		for (FileShare fileShare : fileShareList) {
	
%>
			<tr>
				<td><input type="checkbox" name="" value=""/></td>
				<td><%=fileShare.getPostNo() %></td>
				<td><a href="download.jsp?postNo=<%=fileShare.getPostNo() %>"><i class="bi bi-paperclip"></i></a></td>
				<td><a href="detail.jsp?postNo=<%=fileShare.getPostNo() %>" class="text-decoration-none text-dark"><%=fileShare.getTitle() %></a></td>
				<td><%=fileShare.getEmployee().getName() %></td>
				<td><%=StringUtils.dateToText(fileShare.getCreatedDate()) %></td>
				<td><%=fileShare.getReadCount() %></td>
				<td><%=fileShare.getSuggestionCount() %></td>
			</tr>
<%
		}
	}
%>
							</tbody>
						</table>
					</form>
<%
	if (!fileShareList.isEmpty()) {
		int beginPage = pagination.getBeginPage();	// 시작 페이지번호
		int endPage = pagination.getEndPage();		// 끝 페이지번호
		boolean isFirst = pagination.isFirst();		// 첫 페이지인지 여부, 이전 버튼의 비활성화에서 사용
		boolean isLast = pagination.isLast();		// 마지막 페이지인지 여부, 다음 버튼의 비활성화에서 사용
		int prevPage = pagination.getPrevPage();	// 이전 페이지번호, 이전 버튼에서 사용
		int nextPage = pagination.getNextPage();	// 다음 페이지번호, 다음 버튼에서 사용
%>					
					<nav>
						<ul class="pagination pagination-sm justify-content-center">
							<li class="page-item">
								<a class="page-link <%=isFirst ? "disabled" : "" %>"  
									href="list.jsp?page=<%=prevPage %>"
									onclick="changePage(event, <%=prevPage %>)">이전</a>
							</li>
<%
		for (int number = beginPage; number <= endPage; number++) {
%>							
							<li class="page-item">
								<a class="page-link <%=currentPage == number ? "active" : "" %>" 
									href="list.jsp?page=<%=number%>" 
									onclick="changePage(event,<%=number %>)"><%=number %></a>
							</li>
<%
		}
%>
							<li class="page-item">
								<a class="page-link <%=isLast ? "disabled" : "" %>" 
									href="list.jsp?page=<%=nextPage %>" 
									onclick="changePage(event,<%=nextPage%>)">다음</a>
							</li>
						</ul>
					</nav>
<%
	}
%>
					<div class="text-end">
						<button class="btn btn-dark btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-posts">등록</button>
						<button class="btn btn-outline-dark btn-xs">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal" tabindex="-1" id="modal-form-posts">
	<div class="modal-dialog modal-lg">
	<form class="border p-3 bg-light" id="sendForm" method="post" action="../../board/file/register.jsp" >
		<!-- 게시글의 글 번호을 value에 설정하세요 -->
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
	<%
	
		BoardDao boardDao = BoardDao.getInstance();
		List<Board> boardList = boardDao.getBoards();
		for(Board board : boardList) {
	%>							
								<option value="<%=board.getBoardNo() %>" > <%=board.getName() %></option>
	<%
		}
	%>								
							</select>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" name="title">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">작성자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" readonly="readonly" value="<%=emp != null ? emp.getName() : "" %>" name="writer">
						</div>
					</div>
					<div class="row mb-2">
						<div class="col-sm-8 offset-sm-2">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="imp" value="N" />
								<label class="form-check-label">일반</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="imp" value="Y" />
								<label class="form-check-label">중요</label>
							</div>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">내용</label>
						<div class="col-sm-10">
							<textarea rows="5" class="form-control" name="content"></textarea>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">첨부파일</label>
						<div class="col-sm-9 mb-1">
							<input type="file" class="form-control form-control-sm" />
						</div>
						<div class="col-sm-1">
							<button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">첨부파일</label>
						<div class="col-sm-9 mb-1">
							<input type="file" class="form-control form-control-sm" />
						</div>
						<div class="col-sm-1">
							<button type="button" class="btn btn-sm"><i class="bi bi-plus-circle"></i></button>
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-xs">수정</button>
			</div>
		</div>
	</form>
	</div>
</div>
<jsp:include page="../../common/modal-form-posts.jsp">
	<jsp:param name="boardNo" value="104"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">

	function changeRows() {
		submitForm(1);	
	}
	
	
	function changeSort(event, sort) {
		event.preventDefault();
		var sortField = document.querySelector("[name=sort]");	
		sortField.value = sort;									
		
		submitForm(1);	
	}
	
	function changePage(event, page) {
		event.preventDefault();	
		
		submitForm(page); 
	}
	
	function submitForm(page) {
		var pageField = document.querySelector("[name=page]");	
		pageField.value = page;									
		
		var form = document.querySelector("form");				
		form.submit();	
	}
</script>
</body>
</html>