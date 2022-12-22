<%@page import="com.community.dao.BoardDao"%>
<%@page import="com.community.vo.Board"%>
<%@page import="com.community.vo.Employee"%>
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
	Employee emp = (Employee) session.getAttribute("loginedEmp");

	int rows = StringUtils.stringToInt(request.getParameter("rows"), 10);

	int currentPage = StringUtils.stringToInt(request.getParameter("page"), 1);
	String keyword = StringUtils.nullToValue(request.getParameter("keyword"), "");
	String opt = StringUtils.nullToValue(request.getParameter("opt"), "title");
	String read = StringUtils.nullToValue(request.getParameter("read"), "");
	
	Map<String, Object> param = new HashMap<>();
	if(!keyword.isEmpty() && !opt.isEmpty()) {
		param.put("keyword", keyword);
		param.put("opt", opt);
	}
	if(read != null & emp != null) {
		param.put("read", read);
		param.put("readEmp", emp.getEmpNo());
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
	<%
		if(emp != null) {
	%>					
						<button class="btn btn-dark btn-sm mb-3" data-bs-toggle="modal" data-bs-target="#modal-form-posts">질문 등록</button>
	<%
		}
	%>						
					</div>
					<jsp:include page="../../common/tree.jsp" />
				</div>
			</div>
		</div>
		<div class="col-9">
			<div class="card">
				<div class="card-header">묻고 답하기 게시판</div>
				<div class="card-body">
					<form class="mb-3" method="get" action="list.jsp" id="questionForm">
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
								<small><input type="checkbox" name="read" value="Y" <%=!read.isEmpty() ? "checked" : ""  %>/> 안읽은 게시글</small>
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
								<col width="15%">
								<col width="7%">
								<col width="7%">
							</colgroup>
							<thead>
								<tr class="bg-light">
									<th></th>
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
	<%
		if(emp != null) {
	%>
					<td><input type="radio" name="checking" value=<%=question.getPostNo() %> /></td>
	<%					
		} else {
	%>
					<td></td>
	<%
		}
	%>				
					<td id="sendPostNo" ><%=question.getPostNo() %></td>
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
							<li class="page-item">
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
	
	 	if(emp != null) { 
	%>					
					<div class="text-end">
						<button class="btn btn-dark btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-posts">질문 등록</button>
						<!-- <button class="btn btn-primary btn-xs disabled" data-bs-toggle="modal" data-bs-target="#modal-form-answer" id="answerButton">답변 등록</button> -->
						<button class="btn btn-outline-dark btn-xs disabled" id="submitPostNo">삭제</button>
					</div>
 	<%
		}
	%> 
				</div>
			</div>
		</div>
	</div>
</div>

<!-- ------------------------------답변----------------------------------- -->

<%-- 
<div class="modal" tabindex="-1" id="modal-form-answer">
	<div class="modal-dialog modal-lg">
	<form class="border p-3 bg-light" id="sendForm" method="post" action="../../board/qna/register.jsp" >
		<!-- 게시글의 글 번호을 value에 설정하세요 -->
		<input type="hidden" name="postNo"/>
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">답변</h5>
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
								<option value="<%=board.getBoardNo() %>"> <%=board.getName() %></option>
								<%=board.getBoardNo() == question.getBoard().getBoardNo() ? "selected" : "disabled" %>
	<%
		}
	%>								
							</select>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" readonly name="title" value="">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">작성자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" value="<%=emp != null ? emp.getName() : "" %>" readonly="readonly" name="writer">
						</div>
					</div>
					<div class="row mb-2">
						<div class="col-sm-8 offset-sm-2">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="imp" value="N">
								<label class="form-check-label">일반</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="imp" value="Y">
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
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-xs">답변</button>
			</div>
		</div>
	</form>
	</div>
</div>
 --%>
 
<jsp:include page="../../common/modal-form-posts.jsp">
	<jsp:param name="boardNo" value="104"/>
</jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script>

/* -------------------------------------------------------		Button(Form을 submit)		----------------------------------------------------------------- */
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

	
	
/* -------------------------------------------------------		읽은 게시글 form 전달		----------------------------------------------------------------- */	
	
	$(function() {
		$("[name=read]").change(function() {
			var form = document.querySelector("form");
			form.submit();
		});
		
		
		
/* -------------------------------------------------------		checkBox 제이쿼리		----------------------------------------------------------------- */	
		
		$("#questionForm [name=checking]").change(function() {
			toggleSelectedButton();
		});
		
		function toggleSelectedButton() {
			
			let checkedCheckingLength = $("#questionForm [name=checking]:checked").length;
			
			/* let $answerButton = $("#answerButton"); */
			let $submitPostNo = $("#submitPostNo");
			
			if(checkedCheckingLength == 0) {
				/* $answerButton.addClass('disabled'); */
				$submitPostNo.addClass('disabled');
			} else {
				/* $answerButton.removeClass('disabled'); */
				$submitPostNo.removeClass('disabled');
			}
		}
	
	

/* -------------------------------------------------------		modal 답변		----------------------------------------------------------------- */	

		/* 
		 let answerModal = new bootstrap.Modal("#modal-form-answer");
				         

		   $("#answerButton").click(function() {
		      
			      let checkingRadio = $("#questionForm [name=checking]:checked").val();
			      
			      $.getJSON("detail.jsp", {postNo:checkingRadio}, function(question) {
				     	 let postNo = question.postNo;
				         let boardNo = question.board.boardNo;
				         let title = question.title;
				         let important = question.important;
				         let content = question.content;
				         
				         $("#modal-form-answer [name=postNo]").val(postNo);
				         $("#modal-form-answer [name=boardNo]").val(boardNo);
				         $("#modal-form-answer [name=title]").val("┗ Re: " + title);
				         $("#modal-form-answer [name=important]").val(important);
				         $("#modal-form-answer [name=content]").val(content);
				         
				         
				     	 answerModal.show();
			      })
		   })
		    */
		   
		   
/* -------------------------------------------------------		list에서 게시물 삭제		----------------------------------------------------------------- */	
		
		$("#submitPostNo").click(function() {
			
			let checkingRadio = $("#questionForm [name=checking]:checked").val();
			location.href= "delete.jsp?postNo=" + checkingRadio
					
		})
		 
	
	});
</script>
</body>
</html>