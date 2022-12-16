<%@page import="com.community.vo.Position"%>
<%@page import="com.community.vo.Department"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.community.dao.PositionDao"%>
<%@page import="com.community.dao.DepartmentDao"%>
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
<%
	// 부서, 직위의 Dao 및 List를 생성한다.
	DepartmentDao deptDao = new DepartmentDao();
	PositionDao posDao = new PositionDao();
	Map<String, Object> param = new HashMap<>();
	List<Department> deptList = deptDao.getAllDepts();
	List<Position> posList = posDao.getAllPositions();
%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">부서/직위 관리</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="card">
				<div class="card-header">전체 부서 목록</div>
				<div class="card-body">
					<p>전체 부서목록을 확인하세요.</p>
					<table class="table table-sm">
						<colgroup>
							<col width="15%">
							<col width="*">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>이름</th>
								<td></td>
							</tr>
						</thead>
						<tbody>
							<%
								if (deptList.isEmpty()) {
							%>
							<tr><td class="text-center" colspan="6"> 부서 정보가 없습니다. </td></tr>
							<%
								} else {
									for (Department dept : deptList) {
							%>
							<tr>
								<td><%=dept.getNo() %></td>
								<td><%=dept.getName() %></td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
							<%		
									}
								}
							%>
						</tbody>
					</table>
				</div>
				<div class="card-footer text-end">
					<button class="btn btn-primary btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-dept">신규 등록</button>
				</div>
			</div>
		</div>
		<div class="col">
			<div class="card">
				<div class="card-header">전체 직위 목록</div>
				<div class="card-body">
					<p>전체 직위목록을 확인하세요.</p>
					<table class="table table-sm">
						<colgroup>
							<col width="10%">
							<col width="15%">
							<col width="15%">
							<col width="*">
							<col width="10%">
						</colgroup>
						<thead>
							<tr>
								<th></th>
								<th>번호</th>
								<th>순서</th>
								<th>직위이름</th>
								<td></td>
							</tr>
						</thead>
						<tbody>
							<%
								if (posList.isEmpty()) {
							%>
										<tr><td class="text-center" colspan="6"> 직위 정보가 없습니다. </td></tr>
							<%
								} else {
									for (Position pos : posList) {
							%>
							<tr>
								<td><input type="checkbox" /></td>
								<td><%=pos.getNo() %></td>
								<td><%=pos.getSeq() %></td>
								<td><%=pos.getName() %></td>
								<td><button class="btn btn-outline-primary btn-xs">수정</button></td>
							</tr>
							<%
									}
								}
							%>
						</tbody>
					</table>
					<div>
						<button class="btn btn-outline-secondary btn-xs">맨 위로</button>
						<button class="btn btn-outline-secondary btn-xs">위로</button>
						<button class="btn btn-outline-secondary btn-xs">아래로</button>
						<button class="btn btn-outline-secondary btn-xs">맨 아래로</button>
					</div>
				</div>
				<div class="card-footer text-end">
					<button class="btn btn-primary btn-xs" data-bs-toggle="modal" data-bs-target="#modal-form-dept">신규 등록</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 부서정보 등록폼 -->
<div class="modal" tabindex="-1" id="modal-form-dept">
	<div class="modal-dialog">
		<form id="form-add-dept" class="border p-3 bg-light" method="post" action="deptregister.jsp">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">부서정보 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm" >부서명</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" name="deptName" placeholder="부서명을 입력하세요">
						</div>
					</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-xs">등록</button>
			</div>
		</div>
		</form>
	</div>
</div>
<!-- 부서정보 수정 폼 -->
<div class="modal" tabindex="-1" id="modal-modifyform-dept">
	<div class="modal-dialog">
		<form  id="form-modify-dept" class="border p-3 bg-light" method="post" action="modifyDept.jsp">
		<input type="hidden" name="deptNo" value="100" />
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">부서정보 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
					<div class="row mb-2">
						<label class="col-sm-2 col-form-label col-form-label-sm">부서명</label>
						<div class="col-sm-10">
							<input type="text" class="form-control form-control-sm" name="deptName" placeholder="부서명을 입력하세요">
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
<!-- 직위정보 등록폼 -->
<div class="modal" tabindex="-1" id="modal-form-position">
	<div class="modal-dialog">
		<form id="form-add-position" class="border p-3 bg-light" method="post" action="addPosition.jsp">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">직위정보 등록폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row mb-2">
					<label class="col-sm-2 col-form-label col-form-label-sm" >노출순위</label>
					<div class="col-sm-10">
						<input type="text" class="form-control form-control-sm" name="seq" placeholder="노출순위를 입력하세요">
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-2 col-form-label col-form-label-sm" >직위명</label>
					<div class="col-sm-10">
						<input type="text" class="form-control form-control-sm" name="name" placeholder="직위명을 입력하세요">
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary btn-xs" data-bs-dismiss="modal">닫기</button>
				<button type="submit" class="btn btn-primary btn-xs">등록</button>
			</div>
		</div>
		</form>
	</div>
</div>
<!-- 부서정보 수정 폼 -->
<div class="modal" tabindex="-1" id="modal-form-position">
	<div class="modal-dialog">
		<form id="form-add-position" class="border p-3 bg-light" method="post" action="modifyPosition.jsp">
		<input type="hidden" name="positionNo" value="100" />
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">직위정보 수정폼</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<div class="row mb-2">
					<label class="col-sm-2 col-form-label col-form-label-sm" >노출순위</label>
					<div class="col-sm-10">
						<input type="text" class="form-control form-control-sm" name="seq" placeholder="노출순위를 입력하세요">
					</div>
				</div>
				<div class="row mb-2">
					<label class="col-sm-2 col-form-label col-form-label-sm" >직위명</label>
					<div class="col-sm-10">
						<input type="text" class="form-control form-control-sm" name="name" placeholder="직위명을 입력하세요">
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
</body>
</html>