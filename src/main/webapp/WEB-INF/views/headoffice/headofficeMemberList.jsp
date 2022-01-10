<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>사원 정보 리스트</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
.b {
	border: 1px solid black;
}
</style>
</head>
<body>
	<div class="container-fluid px-4 b">
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">사원번호</th>
					<th scope="col">이 름</th>
					<th scope="col">직 급</th>
					<th scope="col">핸드폰번호</th>
					<th scope="col">E-mail</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${memberList}" varStatus="status">
					<tr>
						<th scope="row">${status.count}</th>
						<td>${list.staffCode}</td>
						<td>${list.staffName}</td>
						<td>${list.staffPosition}</td>
						<td>${list.staffPhone}</td>
						<td>dkajs@mdo.com</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="row b">
			<div class="col"></div>
			<div class="col">
				<ul class="pagination">
					<li class="page-item"><a class="page-link" href="#"
						aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
					</a></li>
					<li class="page-item"><a class="page-link" href="#">1</a></li>
					<li class="page-item"><a class="page-link" href="#">2</a></li>
					<li class="page-item"><a class="page-link" href="#">3</a></li>
					<li class="page-item"><a class="page-link" href="#"
						aria-label="Next"> <span aria-hidden="true">&raquo;</span>
					</a></li>
				</ul>
			</div>
			<div class="col"></div>
		</div>
		<div class="row ">
			<nav class="navbar navbar-light bg-light">
				<div class="col"></div>
				<div class="col -8">
					<select class="form-select" aria-label="Default select example" style="width:130px;">
						<option selected>검색 설정</option>
						<option value="1">사원번호</option>
						<option value="2">이름</option>
						<option value="3">직급</option>
						<option value="3">핸드폰번호</option>
					</select>
					<form class="d-flex">
						<input class="form-control me-2" type="search"
							placeholder="Search" aria-label="Search">
						<button class="btn btn-outline-success" type="submit">Search</button>
					</form>
				</div>
				<div class="col"></div>
			</nav>
		</div>
	</div>
</body>
</html>