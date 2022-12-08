<%@page import="com.community.vo.Position"%>
<%@page import="com.community.dao.PositionDao"%>
<%@page import="com.community.dao.DepartmentDao"%>
<%@page import="com.community.vo.Department"%>
<%@page import="java.util.List"%>
<%@page import="com.community.util.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/logincheck.jsp" %>
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
<%
	
	
	Department myDept = loginedEmp.getDepartment();
	Position mypos = loginedEmp.getPosition();
	
	

%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">내 정보 보기</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col-3">
			<div class="card">
				<div class="card-header">나의 메뉴</div>
				<div class="card-body">
					<div class="list-group">
						<a data-bs-toggle="collapse" href="#myinfo" aria-expanded="true" aria-controls="myinfo" class="list-group-item list-group-item-action <%="aria-expanded".equals("true") ? "active" : "" %>">내 정보 보기</a>
						<a data-bs-toggle="collapse" href="#myboard" aria-expanded="false" aria-controls="myboard" class="list-group-item list-group-item-action <%="aria-expanded".equals("true") ? "active" : "" %>">내가 작성한 게시글</a>
						<a data-bs-toggle="collapse" href="#myreply"  aria-expanded="false" aria-controls="myreply" class="list-group-item list-group-item-action <%="aria-expanded".equals("true") ? "active" : "" %>">내가 작성한 댓글</a>
						<a href="" class="list-group-item list-group-item-action">나에게 온 알림</a>
					</div>
				</div>
				<div class="card-body">
					<div class="list-group">
						<a href="../updateform.jsp" class="list-group-item list-group-item-action">비밀번호 변경하기</a>
					</div>
				</div>
			</div>
		</div>
		<div class="col-9">
			<div class="row mb-3">
				<div class="col-12">
					<p>내 정보를 확인하세요</p>
					<table class="table table-bordered">
						<colgroup>
							<col width="15%">
							<col width="35%">
							<col width="15%">
							<col width="35%">
						</colgroup>
						<tbody>
							<tr>
								<th class="bg-light">직원번호</th><td><%=loginedEmp.getEmpNo() %></td>
								<th class="bg-light">입사일</th><td><%=StringUtils.dateToText(loginedEmp.getCreatedDate()) %></td>
							</tr>
							<tr>
								<th class="bg-light">소속부서</th><td><%=myDept.getName() %></td>
								<th class="bg-light">직위</th><td><%=mypos.getName() %></td>
							</tr>
							<tr>
								<th class="bg-light">이름</th><td colspan="3"><%=loginedEmp.getName() %></td>
							</tr>
							<tr>
								<th class="bg-light">연락처</th><td><%=loginedEmp.getPhone() %></td>
								<th class="bg-light">이메일</th><td><%=loginedEmp.getEmail() %></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div class="row mb-3 collapse" id="myinfo">
				<div class="col-12">
					<div class="card">
						<div class="card-header">내 정보</div>
						<div class="card-body">
							<div class="row p-3">
								<div class="col-4">
								<div class="card">
									<div class="card-body bg-primary text-white text-bold">
										<h5>내가 작성한 글</h5>
										<small>내가 작성한 글은 <strong>10개</strong> 입니다.</small>
									</div>
								</div>
								</div>
								<div class="col-4">
									<div class="card">
										<div class="card-body bg-success text-white text-bold">
											<h5>내가 작성한 댓글</h5>
											<small>내가 작성한 댓글은 <strong>10개</strong> 입니다.</small>
										</div>
									</div>
								</div>
								<div class="col-4">
									<div class="card">
										<div class="card-body bg-danger text-white text-bold">
											<h5>내에게 온 알림</h5>
											<small>나에게 온 알림은 <strong>10개</strong> 입니다.</small>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row mb-3 collapse" id="myboard">
				<div class="col-12">
					<div class="card">
						<div class="card-header">내가 작성한 게시글</div>
						<div class="card-body">
							<table class="table table-sm border-top">
							<colgroup>
								<col width="9%">
								<col width="*">
								<col width="10%">
								<col width="12%">
								<col width="7%">
								<col width="7%">
							</colgroup>
							<thead>
								<tr class="bg-light">
									<th>번호</th>
									<th>제목</th>
									<th>작성자</th>
									<th>등록일</th>
									<th>조회</th>
									<th>추천</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>100000</td>
									<td><a href="" class="text-decoration-none text-dark"> 궁금한 게 있습니다. </a></td>
									<td>라이언</td>
									<td>2022-12-07</td>
									<td>77</td>
									<td>52</td>
								</tr>
							</tbody>
						</table>
						</div>
					</div>
				</div>
			</div>
			<div class="row mb-3 collapse" id="myreply">
				<div class="col-12">
					<div class="card">
						<div class="card-header">내가 작성한 댓글</div>
						<div class="card-body">
							<table class="table table-sm border-top">
							<colgroup>
								<col width="15%">
								<col width="*">
								<col width="10%">
								<col width="12%">
							</colgroup>
							<thead>
								<tr class="bg-light">
									<th>게시글 번호</th>
									<th>댓글 내용</th>
									<th>작성자</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>100000</td>
									<td><a href="" class="text-decoration-none text-dark">안녕하세요.</a></td>
									<td>라이언</td>
									<td>2022-12-07</td>
								</tr>
							</tbody>
						</table>
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