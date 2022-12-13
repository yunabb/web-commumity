<%@page import="com.community.vo.Position"%>
<%@page import="com.community.dao.PositionDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.community.vo.Department"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.community.dao.DepartmentDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" >
<title>웹 애플리케이션</title>
</head>
<body>
<jsp:include page="../common/header.jsp">
	<jsp:param name="menu" value="home"/>
</jsp:include>
<div class="container">
 <h1 class="mb-3 fs-4 border p-2 bg-light">회원가입 폼</h1>
	
	<%
		// 회원가입 실패로 form.jsp?error=invalid 로 재요청했을 때 errorCode의 값은 invalid다.
		String errorCode = request.getParameter("error");
	%>
	
	<%
		if ("invalid".equals(errorCode)) {
	%>
		<div class="alert alert-danger">
			이메일이 이미 사용중입니다.
		</div>
	<%
		}
	%>
	
	<form class="bg-light border p-3" method="post" action="register.jsp">
		<div class="mb-3">
			<label class="form-label">회원번호</label>
			<input type="text" class="form-control" name="id" value="회원번호는 가입 순서에 따라 자동으로 부여됩니다." aria-label="Disabled input example" readonly="readonly" />
		</div>
		<div class="mb-3">
			<label class="form-label">비밀번호</label>
			<input type="password" class="form-control" name="password" />
		</div>
		<div class="mb-3">
			<label class="form-label">비밀번호 확인</label>
			<input type="password" class="form-control" name="password2" />
		</div>
		<div class="mb-3">
			<label class="form-label">이름</label>
			<input type="text" class="form-control" name="name" />
		</div>
		<div class="mb-3">
			<label class="form-label">이메일</label>
			<input type="text" class="form-control" name="email" />
		</div>
		<div class="mb-3">
			<label class="form-label">전화번호</label>
			<input type="text" class="form-control" name="phone" />
		</div>
		<div class="mb-3">
			<label class="form-label">부서</label>
			<select id="text" name="dept" required autofocus>
			<%
				DepartmentDao deptDao = new DepartmentDao();
				List<Department> deptList = deptDao.getAllDepts();
				
				for(Department dept : deptList) {
			%>
    			<option value="<%=dept.getNo() %>"><%=dept.getName() %></option>
    		<%
				}
    		%>
			</select>
		</div>
		<div class="mb-3">
			<label class="form-label">직위</label>
			<select id="text" name="pos" required autofocus>
			<%
				PositionDao posDao = new PositionDao();
				List<Position> posList = posDao.getAllPositions();
				
				for(Position pos : posList) {
			%>
    			<option value="<%=pos.getNo() %>"><%=pos.getName() %></option>
    		<% 
				}
    		%>
			</select>
		</div>
		<div class="text-end">
			<a href="employees.jsp" class="btn btn-secondary">취소</a>
			<button type="submit" class="btn btn-primary">회원가입</button>
		</div>
	</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">

</script>
</body>
</html>