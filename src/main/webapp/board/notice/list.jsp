<%@page import="com.community.dao.EmployeeDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Notice"%>
<%@page import="java.util.List"%>
<%@page import="com.community.util.Pagination"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.community.dao.NoticeDao"%>
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
<div class="container my-3">
<%
	Employee loginedEmp = (Employee) session.getAttribute("loginedEmp");
	// 행 갯수, 정렬방식, 요청한 페이지번호, 검색옵션, 검색키워드를 조회한다.
	// 값이 존재하지 않으면 기본값을 설정한다.
	int rows = StringUtils.stringToInt(request.getParameter("rows"), 10);
	String sort = StringUtils.nullToValue(request.getParameter("sort"), "date");
	int currentPage = StringUtils.stringToInt(request.getParameter("page"), 1);
	String opt = StringUtils.nullToValue(request.getParameter("opt"), "title");
	String keyword = StringUtils.nullToValue(request.getParameter("keyword"), "");
	
	String reading = StringUtils.nullToValue(request.getParameter("reading"), "");
	
	NoticeDao noticeDao = NoticeDao.getInstance();
	Map<String, Object> param = new HashMap<>();
	if (!opt.isEmpty() && !keyword.isEmpty()) {
		param.put("opt", opt);
		param.put("keyword", keyword);
	}
	
	if (reading != null & loginedEmp != null) {
		param.put("reading", reading);
		param.put("empNo", loginedEmp.getEmpNo());
	}
	
	// 게시글 갯수 조회
	int totalRows = noticeDao.getTotalRows(param);
	
	// Pagination객체를 생성
	Pagination pagination = new Pagination(currentPage, totalRows, rows);
	
	// 게시글 목록 조회
	param.put("sort", sort);
	param.put("begin", pagination.getBegin());
	param.put("end", pagination.getEnd());
	
	List<Notice> noticeList = noticeDao.getNotices(param);
%>
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">공지사항</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-3">
			<div class="card">
				<div class="card-header">전체 게시판 목록</div>
				<div class="card-body">
				<% if(loginedEmp == null) {
					
				} else {
				%>
					<div class="d-grid gap-2">
						<button class="btn btn-dark btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#modal-form-posts">공지사항 등록</button>
					</div>
				<%} %>
					<jsp:include page="../../common/tree.jsp" />
				</div>
			</div>
		</div>
		<div class="col-9">
			<div class="card">
				<div class="card-header">공지사항</div>
				<div class="card-body">
				
					<form class="mb-3" method="get" action="list.jsp">
					<input type="hidden" name="page" value="<%=currentPage %>" />
					<input type="hidden" name="sort" value="<%=sort %>" />
						<div class="mb-2 d-flex justify-content-between">
							<div>
								<select class="form-select form-select-xs" name="rows" onchange="changeRows()">
									<option value="10" <%=rows == 10 ? "checked" : "" %>> 10</option>
									<option value="15" <%=rows == 15 ? "checked" : "" %>> 15</option>
									<option value="20" <%=rows == 20 ? "checked" : "" %>> 20</option>
								</select>
							</div>
							<div>
							<% if (loginedEmp == null) {
								
							   } else {
							%>
									<small><input type="checkbox" name="reading" value="Y" <%=!reading.isEmpty() ? "checked" : "" %>> 안읽은 게시글</small>
							<%} %>
								<select class="form-select form-select-xs" name="opt">
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
								<col width="*">
								<col width="14%">
								<col width="20%">
								<col width="7%">
								<col width="7%">
							</colgroup>
							<thead>
								<tr class="bg-light">
									<th><input type="checkbox" id="checkbox-all-toggle" onchange="toggleAllCheckUncheck()"></th>
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
	if (noticeList.isEmpty()) {
%>
		<tr><td class="text-center" colspan="6"> 게시글 정보가 없습니다. </td></tr>
<%
	} else {
		for (Notice notice : noticeList) {
	
%>
								<tr>
									<td><input type="checkbox" name="noticeNo" value="<%=notice.getPostNo()%>"/></td>
									<td><%=notice.getPostNo() %></td>
									<td><a href="detail.jsp?no=<%=notice.getPostNo() %>" class="text-decoration-none text-dark"><%=notice.getTitle() %></a></td>
									<td><%=notice.getEmployee().getName() %></td>
									<td><%=StringUtils.dateToText(notice.getCreatedDate()) %></td>
									<td><%=notice.getReadCount() %></td>
									<td><%=notice.getSuggestionCount() %></td>
								</tr>
<%
		}
	}
%>
							</tbody>
						</table>
					</form>
<%
	if (!noticeList.isEmpty()) {
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

<%
	if (loginedEmp == null) {
		
	} else {
%>
					<div class="text-end">
						<button class="btn btn-dark btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-posts">등록</button>
						<button class="btn btn-outline-dark btn-xs">삭제</button>
					</div>
<%
	}
%>	
				
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
	
	$(function() {
		$("[name=reading]").change(function() {
			var form = document.querySelector("form");
			form.submit();
		})
	});
	
	function toggleAllCheckUncheck() {
		// 전체 선택/해제 체크박스의 체크상태를 조회하다.
		var el = document.querySelector("#checkbox-all-toggle");
		var currentChecked = el.checked;
		
		// 모든 보유기술 체크박스의 체크상태를 위에서 조회한 전체 선택/해제 체크박스의 체크상태와 같은 상태로 만든다.
		var collection = document.querySelectorAll('[name=noticeNo]');
		for (var index = 0; index < collection.length; index++) {
			var el = collection[index];
			el.checked = currentChecked;
		}
	}

	function uncheck() {
		// 체크박스 자바를 선택해제하기
		var el = document.querySelectorAll('[name=noticeNo]')[0];
		el.checked = false;
	}
	function check() {
		// 체크박스 자바를 해제하기
		var el = document.querySelectorAll('[name=noticeNo]')[0];
		el.checked = true;
	}
	function toggleCheck() {
		// 체크박스 자바를 선택해제를 토글하기
		var el = document.querySelectorAll('[name=noticeNo]')[0];
		el.checked = !el.checked
	}
	function checkAll() {
		// 체크박스 전체 선택하기
		var collection = document.querySelectorAll('[name=noticeNo]');
		for (var index = 0; index < collection.length; index++) {
			var el = collection[index];
			el.checked = true;
		}
	}
	function uncheckAll() {
		// 체크박스 전체 선택하기
		var collection = document.querySelectorAll('[name=noticeNo]');
		for (var index = 0; index < collection.length; index++) {
			var el = collection[index];
			el.checked = false;
		}
	}
</script>
</body>
</html>