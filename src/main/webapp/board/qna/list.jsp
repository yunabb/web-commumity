<%@page import="com.community.vo.Question"%>
<%@page import="java.util.List"%>
<%@page import="com.community.util.Pagination"%>
<%@page import="com.community.dao.QuestionDao"%>
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
<title>사내 커뮤니티</title>
</head>
<body>
<jsp:include page="../../common/header.jsp">
	<jsp:param name="menu" value="board"/>
</jsp:include>

<%
	int rows = StringUtils.stringToInt(request.getParameter("rows"), 10);

	int currentPage = StringUtils.stringToInt(request.getParameter("page"), 1);
	String keyword = StringUtils.nullToValue(request.getParameter("keyword"), "");
	String opt = StringUtils.nullToValue(request.getParameter("opt"), "title");
	
	Map<String, Object> param = new HashMap<>();
	if(!keyword.isEmpty() && !opt.isEmpty()) {
		param.put("keyword", keyword);
		param.put("opt", opt);
	}
	
	QuestionDao questionDao = QuestionDao.getInstance();
	int totalRows = questionDao.getTotalRows(param);
	
	Pagination pagination = new Pagination(currentPage, totalRows, rows);
	
	param.put("begin", pagination.getBegin());
	param.put("end", pagination.getEnd());
	
	List<Question> questionList = questionDao.getQuestions(param);
%>

<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">묻고 답하기</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-3">
			<div class="card">
				<div class="card-header">전체 게시판 목록</div>
				<div class="card-body">
					<div class="d-grid gap-2">
						<button class="btn btn-dark btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#modal-form-posts">질문 등록</button>
					</div>
					<jsp:include page="../../common/tree.jsp" />
				</div>
			</div>
		</div>
		<div class="col-9">
			<div class="card">
				<div class="card-header">묻고 답하기 게시판</div>
				<div class="card-body">
					<form class="mb-3" method="get" action="list.jsp">
						<input type="hidden" name="page" value="<%=currentPage %>" />
						<div class="mb-2 d-flex justify-content-between">
							<div>
								<select class="form-select form-select-xs" name="rows" onchange="changeRows()">
									<option value="10" <%=10 == rows ? "selected" : "" %>> 10</option>
									<option value="15" <%=15 == rows ? "selected" : "" %>> 15</option>
									<option value="20" <%=20 == rows ? "selected" : "" %>> 20</option>
								</select>
							</div>
							<div>
								<small><input type="checkbox"> 안읽은 게시글</small>
								<select class="form-select form-select-xs" name="opt">
									<option value="title" <%="title".equals(opt) ? "selected" : "" %>> 제목</option>
									<option value="writer" <%="writer".equals(opt) ? "selected" : "" %>> 작성자</option>
									<option value="content" <%="content".equals(opt) ? "selected" : "" %>> 내용 </option>
								</select>
								<input type="text" class="form-control form-control-xs w-150" name='keyword' value='<%=keyword %>'>
								<button type="button" class="btn btn-outline-secondary btn-xs" onclick='submitForm(1)'>검색</button>
							</div>
						</div>
						<table class="table table-sm border-top">
							<colgroup>
								<col width="3%">
								<col width="9%">
								<col width="*">
								<col width="10%">
								<col width="14%">
								<col width="7%">
								<col width="7%">
							</colgroup>
							<thead>
								<tr class="bg-light">
									<th><input type="checkbox"></th>
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>등록일</th>
									<th>조회</th>
									<th>추천</th>
								</tr>
							</thead>
							<tbody>
	<%
		if(questionList.isEmpty()) {
	%>							
			<tr><td class="text-center" colspan="6"> 게시글 정보가 없습니다. </td></tr>
	<%
		} else {
			for(Question question : questionList) {
	%>
				<tr>
					<td><input type="checkbox" name="" value=""/></td>
					<td><%=question.getPostNo() %></td>
					<td><a href="detail.jsp?postNo=<%=question.getPostNo() %>" class="text-decoration-none text-dark"><i class="bi bi-question-circle-fill"></i><%=question.getTitle() %></a></td>
					<td><%=question.getEmployee().getName() %></td>
					<td><%=StringUtils.dateToText(question.getCreatedDate())%></td>
					<td><%=question.getReadCount() %></td>
					<td><%=question.getSuggestionCount() %></td>
				</tr>
	<%		
			}
		}
	%>
							</tbody>
						</table>
					</form>
	<%
		if(!questionList.isEmpty()) {
			int beginPage = pagination.getBeginPage();
			int endPage = pagination.getEndPage();
			boolean isFirst = pagination.isFirst();
			boolean isLast = pagination.isLast();
			int prevPage = pagination.getPrevPage();
			int nextPage = pagination.getNextPage();
	%>					
					<nav>
						<ul class="pagination pagination-sm justify-content-center">
							<li class="page-item disabled">
								<a class="page-link <%=isFirst ? "disabled" : "" %>"
									href="list.jsp?page=<%=prevPage %>"
									onclick="changePage(event, <%=prevPage %>)">이전</a>
							</li>
	<%
		for(int number = beginPage; number <= endPage; number++) {
	%>							
							<li class="page-item">
								<a class="page-link <%=currentPage == number ? "active" : "" %>"
								 href="list.jsp?page=<%=number %>"
								 onclick="changePage(event, <%=number %>)"><%=number %></a>
							</li>
	<%
		}
	%>				
							<li class="page-item">
								<a class="page-link <%=isLast ? "disabled" : "" %>"
									href="list.jsp?page=<%=nextPage %>"
									onclick="changePage(event, <%=nextPage %>)">다음</a>
							</li>
						</ul>
					</nav>
	<%
		}
	%>					
					<div class="text-end">
						<button class="btn btn-dark btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-posts">질문 등록</button>
						<button class="btn btn-primary btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-posts">답변 등록</button>
						<button class="btn btn-outline-dark btn-xs">삭제</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../../common/modal-form-posts.jsp">
	<jsp:param name="boardNo" value="100"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>
	function changePage(event, page) {
		event.preventDefault();
		
		submitForm(page);
	}
	
	function changeRows() {
		submitForm(1);
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