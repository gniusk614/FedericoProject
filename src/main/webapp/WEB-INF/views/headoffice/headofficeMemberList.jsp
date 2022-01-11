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
	<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
	<link href="/federico/resources/css/styles.css" rel="stylesheet" />
	<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="/federico/resources/myLib/headOffice_Script.js"></script>
<style>
</style>
</head>
<body>
	<div class="container-fluid px-4" style="margin-top: 20px;">
		<div class="card">
			<div class="card-header">
				<svg class="svg-inline--fa fa-table fa-w-16 me-1" aria-hidden="true"
					focusable="false" data-prefix="fas" data-icon="table" role="img"
					xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
					data-fa-i2svg="">
					<path fill="currentColor"
						d="M464 32H48C21.49 32 0 53.49 0 80v352c0 26.51 21.49 48 48 48h416c26.51 0 48-21.49 48-48V80c0-26.51-21.49-48-48-48zM224 416H64v-96h160v96zm0-160H64v-96h160v96zm224 160H288v-96h160v96zm0-160H288v-96h160v96z"></path></svg>
				사원 정보 리스트
			</div>
			<div class="card-body">
				<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
					<div class="dataTable-top">
						<div class="col-sm-1">
							<select class="form-select" aria-label="Default select example">
								<option selected>검색 설정</option>
								<option value="1">사원번호</option>
								<option value="2">이름</option>
								<option value="3">직급</option>
								<option value="3">핸드폰번호</option>
							</select>
						</div>
						<div class="col-sm-4">
							<form class="d-flex">
								<input class="form-control me-2" type="search"
									placeholder="Search" aria-label="Search">
								<button class="btn btn-outline-primary" type="submit">Search</button>
							</form>
						</div>
						<div class="col-sm-7"></div>
					</div>
					<div class="dataTable-container">
						<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">사원번호</th>
							<th scope="col">이 름</th>
							<th scope="col">직 급</th>
							<th scope="col">핸드폰번호</th>
							<th scope="col">E-mail</th>
							<th scope="col"></th>
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
								<td><span id="modalButton" class="btn">자세히</span></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
					</div>
					<div class="dataTable-bottom">
						<nav class="dataTable-pagination">
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
						</nav>
					</div>
				</div>
			</div>
		</div>
			<div class="modal fade" id="modal" role="dialog">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title">사원 상세정보</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
				      <div class="modal-body">
				        <p>Modal body text goes here.</p>
				      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			      </div>
			    </div>
			  </div>
			</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/assets/demo/chart-area-demo.js"></script>
	<script src="/federico/resources/assets/demo/chart-bar-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
	<script src="/federico/resources/js/datatables-simple-demo.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>