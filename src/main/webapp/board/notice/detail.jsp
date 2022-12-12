<%@page import="com.community.dao.EmployeeDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.vo.Notice"%>
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
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">게시글 상세정보</h1>
		</div>
	</div>
	<%	// list의 no를 가져와서 Notice객체를 가져와 변수notice에 저장한다.
		int NoticeNo = StringUtils.stringToInt(request.getParameter("no"));
		NoticeDao noticeDao = NoticeDao.getInstance();
		Notice notice = noticeDao.getNoticeByPostNo(NoticeNo);
		// notice객체에 작성자번호(Employee.empNo)를 조회하여 객체를 가져오고 그 객체를 변수emp에 저장한다.
		EmployeeDao empDao = new EmployeeDao();
		Employee emp = new Employee();
		emp = empDao.getEmployeeByNoJoin(notice.getEmployees().getEmpNo());
		
		// 조회수 1증가 시킨다.
		notice.setReadCount(notice.getReadCount() +1);
		noticeDao.updateNotice(notice);
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
						<td><%=notice.getPostNo() %></td>
						<th class="text-center bg-light">등록일</th>
						<td><%=StringUtils.dateToText(notice.getCreatedDate()) %></td>
					</tr>
					<tr>
						<th class="text-center bg-light">제목</th>
						<td><%=notice.getTitle() %></td>
						<th class="text-center bg-light">추천수</th>
						<td id="suggestion"><%=notice.getSuggestionCount() %></td>
					</tr>
					<tr>
						<th class="text-center bg-light">작성자</th>
						<td><%=notice.getEmployees().getName() %> <%=emp.getPosition().getName() %></td>
						<th class="text-center bg-light">소속부서</th>
						<td><%=emp.getDepartment().getName() %></td>
					</tr>
					<tr>
						<th class="text-center bg-light">조회수</th>
						<td><%=notice.getReadCount() %></td>
						<th class="text-center bg-light">댓글 수</th>
						<td><%=notice.getCommentCount() %></td>
					</tr>
					<tr>
						<th class="text-center bg-light">내용</th>
						<td colspan="3"><textarea rows="4" class="form-control border-0" readonly></textarea> </td>
					</tr>
				</tbody>
			</table>
			<div class="d-flex justify-content-between">
				<span>
					<a href="delete.jsp" class="btn btn-danger btn-xs">삭제</a>
					<a href="" class="btn btn-warning btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-posts">수정</a>
				</span>
				<span>
					<a href="suggestion.jsp?no=<%=notice.getPostNo() %>" class="btn btn-outline-primary btn-xs" onclick="addSuggestion()">추천</a>
					<button class="btn btn-outline-primary btn-xs">답변</button>
				</span>
			</div>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-12 mb-1">
			<form method="post" action="">
				<!-- 게시글의 글 번호을 value에 설정하세요 -->
				<input type="hidden" name="postNo" value="1000"/>
				<div class="row mb-3">
					<div class="col-sm-11">
						<input type="text" class="form-control form-control-sm" name="content" placeholder="댓글을 남겨주세요">
					</div>
					<div class="col-sm-1 text-end" style="margin-top: 2px;">
						<button class="btn btn-secondary btn-xs">댓글</button>
					</div>
				</div>
			</form>
		</div>
		<div class="col-12">
			<div class="card">
				<!-- 댓글 반복 시작 -->
				<div class="card-body py-1 px-3 small border-bottom">
					<div class="mb-1 d-flex justify-content-between text-muted">
						<span>홍길동</span>
						<span><span class="me-4">2022년 12월 10일</span> <a href="" class="text-danger"><i class="bi bi-trash-fill"></i></a></span>
					</div>
					<p class="card-text">내용</p>
				</div>
				<!-- 댓글 반복 끝 -->
				<div class="card-body py-1 px-3 small border-bottom">
					<div class="mb-1 d-flex justify-content-between text-muted">
						<span>홍길동</span>
						<span><span class="me-4">2022년 12월 10일</span> <a href="" class="text-danger"><i class="bi bi-trash-fill"></i></a></span>
					</div>
					<p class="card-text">내용</p>
				</div>
				<div class="card-body py-1 px-3 small border-bottom">
					<div class="mb-1 d-flex justify-content-between text-muted">
						<span>홍길동</span>
						<span><span class="me-4">2022년 12월 10일</span> <a href="" class="text-danger"><i class="bi bi-trash-fill"></i></a></span>
					</div>
					<p class="card-text">내용</p>
				</div>
				<div class="card-body py-1 px-3 small border-bottom">
					<div class="mb-1 d-flex justify-content-between text-muted">
						<span>홍길동</span>
						<span><span class="me-4">2022년 12월 10일</span> <a href="" class="text-danger"><i class="bi bi-trash-fill"></i></a></span>
					</div>
					<p class="card-text">내용</p>
				</div>
			</div>				
		</div>
	</div>
</div>
<div class="modal" tabindex="-1" id="modal-form-posts">
	<div class="modal-dialog modal-lg">
	<form class="border p-3 bg-light" method="post" action="modify.jsp">
		<!-- 게시글의 글 번호을 value에 설정하세요 -->
		<input type="hidden" name="postNo" value="1000"/>
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">게시글 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">게시판 이름</label>
						<div class="col-sm-5">
							<select class="form-select form-select-sm">
								<option value="100"> 공지사항</option>
								<option value="100"> 파일게시판</option>
								<option value="100"> 갤러리</option>
								<option value="100"> 묻고 답하기</option>
								<option value="100"> 벼룩시장</option>
								<option value="100"> 사는 얘기</option>
							</select>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">제목</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" placeholder="제목">
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">작성자</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" readonly="readonly" value="홍길동">
						</div>
					</div>
					<div class="row mb-2">
						<div class="col-sm-8 offset-sm-2">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="" value="N" checked>
								<label class="form-check-label">일반</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="" value="Y" >
								<label class="form-check-label">중요</label>
							</div>
						</div>
					</div>
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">내용</label>
						<div class="col-sm-10">
							<textarea rows="5" class="form-control">내용을 수정하세요</textarea>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">

function addSuggestion() {
	alert("추천 하였습니다.")
}
</script>
</body>
</html>