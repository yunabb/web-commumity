<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Post"%>
<%@page import="com.community.dao.PostDao"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.vo.Board"%>
<%@page import="java.util.List"%>
<%@page import="com.community.dao.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    	/* emp는 로그인 변수 */
    	Employee emp = (Employee) session.getAttribute("loginedEmp");
    %>
<div class="modal" tabindex="-1" id="modal-form-posts">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">게시글 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">

				<form class="border p-3 bg-light" action="../../common/register.jsp" id="sendForm">

				<form class="border p-3 bg-light" >

					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">게시판 이름</label>
						<div class="col-sm-5">
							<select class="form-select form-select-sm" name="boardNo">
	<%
		int postNo = StringUtils.stringToInt(request.getParameter("postNo"));
	
		/* 질문등록 -> 게시판 목록 가져오기 */
		BoardDao boardDao = BoardDao.getInstance();
		List<Board> boardList = boardDao.getBoards();
		
		for(Board board : boardList) {
	%>							
								<option value="<%=board.getBoardNo() %>"><%=board.getName() %></option>
	<%
		}
		
		/* 게시글 수정 모달 posts.xml, postDao, Post(Vo) 이용해서 부탁드립니다! */
		
		PostDao postDao = PostDao.getInstance();
		// List<Post> postList = postDao.get
	%>								
							</select>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" name="title" value=""/>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">작성자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" readonly="readonly" value="<%=emp != null ? emp.getName() : ""%>" name="writer" />
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
							<textarea rows="5" class="form-control" name="content" ></textarea>
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
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="button" class="btn btn-primary btn-xs" onclick="submitRegister()">등록</button>
			</div>
		</div>
	</div>
</div>

<script>
	function submitRegister() {
		var titleField = document.querySelector("[name=title]");
		var contentField = document.querySelector("[name=content]");
		
		if(titleField.value === "") {
			alert("제목을 입력해 주세요");
			titleField.focus();
			return false;
		}
		
		if(contentField.value === "") {
			alert("내용을 입력해 주세요");
			contentField.focus();
			return false;
		}
		document.getElementById("sendForm").submit();
	}
</script>
