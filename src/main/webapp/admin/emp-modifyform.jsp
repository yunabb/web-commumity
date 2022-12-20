<%@page import="com.community.vo.Position"%>
<%@page import="com.community.dao.PositionDao"%>
<%@page import="com.community.dao.DepartmentDao"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.community.vo.Department"%>
<%@page import="com.community.util.StringUtils"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="com.community.dao.EmployeeDao"%>
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

	int empNo = StringUtils.stringToInt(request.getParameter("no"));

	EmployeeDao empDao = new EmployeeDao();
	Employee emp = empDao.getEmployeeByNo(empNo);
%>
<div class="container my-3">
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">직원 관리</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="card">
				<div class="card-header">직원 정보 수정폼</div>
				<div class="card-body">
					<p>직원정보를 수정하세요.</p>
					<form class="" method="post" action="emp-modify.jsp">
						<table class="table table-borderless">
							<colgroup>
								<col width="10%">
								<col width="40%">
								<col width="10%">
								<col width="40%">
							</colgroup>
							<tbody>
								<tr>
									<th class="text-end">직원번호</th>
									<td><input name ="no" type="text" class="form-control form-control-sm" value="<%=emp.getEmpNo() %>" readonly="readonly"/></td>
									<th class="text-end">직원이름</th>
									<td><input type="text" class="form-control form-control-sm" value="<%=emp.getName() %>" readonly="readonly"/></td>
								</tr>
								<tr>
									<th class="text-end">이메일</th>
									<td><input type="text" class="form-control form-control-sm" value="<%=emp.getEmail() %>"/></td>
									<th class="text-end">전화번호</th>
									<td><input type="text" class="form-control form-control-sm" value="<%=emp.getPhone() %>" /></td>
								</tr>
								<tr>
									<th class="text-end">소속부서</th>
									<td>
										<select name="dept" class="form-select form-select-sm">
										<%
											DepartmentDao deptDao = new DepartmentDao();
											List<Department> deptList = deptDao.getAllDepts();
											for(Department dept : deptList) {
										%>
											<option value="<%=dept.getNo() %>" <%=dept.getNo() == emp.getDepartment().getNo() ? "selected" : "disabled" %>> <%=dept.getName() %></option>
											<%
											}
											%>
										</select>
									</td>
									<th class="text-end">직위</th>
									<td>
										<select name="pos" class="form-select form-select-sm">
										<%
											PositionDao posDao = new PositionDao();
											List<Position> posList = posDao.getAllPositions();
											for(Position pos : posList) {
										%>
											<option value="<%=pos.getNo() %>" <%=pos.getNo() == emp.getPosition().getNo() ? "selected" : "disabled" %>> <%=pos.getName() %></option>
											<%
											}
											%>
										</select>
									</td>
								</tr>
							</tbody>
						</table>
						<div class="text-end">
							<a href="employees.jsp" class="btn btn-secondary btn-sm">취소</a>
							<button type="submit" class="btn btn-primary btn-sm">수정</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>