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
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" />
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
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
				<div
					class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
					<div class="dataTable-top">
						<div class="col-sm-1">
							<select name="searchType" id="searchType" class="form-select"
								aria-label="Default select example">
								<option value="none"
									<c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/>>
									- -</option>
								<option value="code"
									<c:out value="${pageMaker.cri.searchType=='code' ? 'selected':''}"/>>사원번호</option>
								<option value="name"
									<c:out value="${pageMaker.cri.searchType=='name' ? 'selected':''}"/>>이름</option>
								<option value="posi"
									<c:out value="${pageMaker.cri.searchType=='posi' ? 'selected':''}"/>>직급</option>
								<option value="phon"
									<c:out value="${pageMaker.cri.searchType=='phon' ? 'selected':''}"/>>핸드폰번호</option>
							</select>
						</div>
						<div class="col-sm-4">
							<form class="d-flex">
								<input class="form-control me-2" type="search"
									placeholder="Search" value="${pageMaker.cri.keyword}"
									aria-label="Search">
								<button id="searchBtn" class="btn btn-outline-primary">Search</button>
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
										<td><span id="${list.staffCode}" class="modalbtn">
												<svg xmlns="http://www.w3.org/2000/svg" width="16"
													height="16" fill="currentColor" class="bi bi-zoom-in"
													viewBox="0 0 16 16">
										  <path fill-rule="evenodd"
														d="M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11zM13 6.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0z" />
										  <path
														d="M10.344 11.742c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1 6.538 6.538 0 0 1-1.398 1.4z" />
										  <path fill-rule="evenodd"
														d="M6.5 3a.5.5 0 0 1 .5.5V6h2.5a.5.5 0 0 1 0 1H7v2.5a.5.5 0 0 1-1 0V7H3.5a.5.5 0 0 1 0-1H6V3.5a.5.5 0 0 1 .5-.5z" />
										</svg>
										</span></td>
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
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="card">
							<div class="card-header">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-square" viewBox="0 0 16 16">
  								<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
  								<path d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1v-1c0-1-1-4-6-4s-6 3-6 4v1a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12z"/>
								</svg>
								사원 상세 정보
							</div>
							<div class="card-body">
								<table class="table table-striped">
									<thead>
										<tr>
											<th scope="col" colspan="2">사원 번호</th>
											<th scope="col" colspan="2">이 름</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<th scope="row" colspan="2"><div id="staffCode"></div></th>
											<td colspan="2"><div id="staffName"></div></td>
										</tr>
										<tr>
											<td colspan="4">
												<table class="table mb-0">
													<tr>
														<th scope="col">직 급</th>
														<td colspan="3"><div id="staffPosition"></div></td>
													</tr>
													<tr>
														<th scope="col">연 락 처</th>
														<td colspan="3"><div id="staffPhone"></div></td>
													</tr>
													<tr>
														<th scope="col">E-mail</th>
														<td colspan="3"><div id="staffEmail"></div></td>
													</tr>
												</table>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
			crossorigin="anonymous"></script>
		<script src="/federico/resources/js/scripts.js"></script>
		<script src="/federico/resources/assets/demo/chart-area-demo.js"></script>
		<script src="/federico/resources/assets/demo/chart-bar-demo.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest"
			crossorigin="anonymous"></script>
		<script src="/federico/resources/js/datatables-simple-demo.js"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>