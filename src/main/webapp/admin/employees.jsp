<%@page import="com.community.vo.Position"%>
<%@page import="com.community.dao.PositionDao"%>
<%@page import="com.community.vo.Department"%>
<%@page import="com.community.dao.DepartmentDao"%>
<%@page import="com.community.vo.Employee"%>
<%@page import="java.util.List"%>
<%@page import="com.community.util.Pagination"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.community.util.StringUtils"%>
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
<div class="container my-3">
<%

	// 행 갯수, 정렬방식, 요청한 페이지번호, 검색옵션, 검색키워드를 조회한다.
	// 값이 존재하지 않으면 기본값을 설정한다.
	int rows = StringUtils.stringToInt(request.getParameter("rows"), 10);
	int currentPage = StringUtils.stringToInt(request.getParameter("page"), 1);

	EmployeeDao empDao = new EmployeeDao();
	DepartmentDao deptDao = new DepartmentDao();
	PositionDao posDao = new PositionDao();
	Map<String, Object> param = new HashMap<>();

	// 게시글 갯수 조회
	int totalRows = empDao.getTotalRows();

	// Pagination객체를 생성
	Pagination pagination = new Pagination(currentPage, totalRows, rows);

	// 게시글 목록 조회
	param.put("begin", pagination.getBegin());
	param.put("end", pagination.getEnd());

	List<Employee> empList = empDao.getAllEmp(param);

%>
	<div class="row mb-3">
		<div class="col">
			<h1 class="heading">직원 관리</h1>
		</div>
	</div>
	<div class="row mb-3">
		<div class="col">
			<div class="card">
				<div class="card-header">직원 리스트</div>
				<div class="card-body">
					<p>직원 목록을 확인하세요.</p>
					<table class="table table-sm">
						<colgroup>
							<col width="10%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
							<col width="15%">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>이름</th>
								<td>부서명</td>
								<td>직위</td>
								<td>연락처</td>
								<td>이메일</td>								
								<td></td>
							</tr>
						</thead>
						<tbody>
							<%
								if (empList.isEmpty()) {
							%>
										<tr><td class="text-center" colspan="6"> 회원 정보가 없습니다. </td></tr>
							<%
								} else {
									for (Employee emp : empList) {
										Department dpt = deptDao.getNameByEmpNo(emp.getEmpNo());
										Position pos = posDao.getNameByEmpNo(emp.getEmpNo());
							%>
										<tr>
											<td><%=emp.getEmpNo() %></td>
											<td><%=emp.getName() %></td>
											<td><%=dpt.getName() %></td>
											<td><%=pos.getName() %></td>
											<td><%=emp.getPhone() %></td>
											<td><%=emp.getEmail() %></td>
											<td>
												<a href="emp-modifyform.jsp?no=<%=emp.getEmpNo() %>" class="btn btn-outline-primary btn-xs">수정</a>
												<a href="emp-delete.jsp?no=<%=emp.getEmpNo() %>" class="btn btn-outline-secondary btn-xs">삭제</a>
											</td>
										</tr>
							<%		
									}
								}
							%>
						</tbody>
					</table>
					<nav>
						<%
							if (!empList.isEmpty()) {
							int beginPage = pagination.getBeginPage();	// 시작 페이지번호
							int endPage = pagination.getEndPage();		// 끝 페이지번호
							boolean isFirst = pagination.isFirst();		// 첫 페이지인지 여부, 이전 버튼의 비활성화에서 사용
							boolean isLast = pagination.isLast();		// 마지막 페이지인지 여부, 다음 버튼의 비활성화에서 사용
							int prevPage = pagination.getPrevPage();	// 이전 페이지번호, 이전 버튼에서 사용
							int nextPage = pagination.getNextPage();	// 다음 페이지번호, 다음 버튼에서 사용
						%>
							<div aria-label="navigation">
								<ul class="pagination justify-content-center">
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
							</div>
							<%
								}
							%>
					</nav>
				</div>
				<div class="card-footer text-end">
					<a href="registerform.jsp" class="btn btn-primary btn-xs">신규 등록</a>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</body>
</html>