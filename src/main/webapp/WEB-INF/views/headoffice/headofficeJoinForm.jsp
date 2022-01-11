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
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
  					<path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
				</svg>
				&nbsp;사원 계정 생성
			</div>
			<div class="card-body">
				<div
					class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
					<div class="dataTable-top">
						<!-- 공백 -->
					</div>
					<div class="dataTable-container">
						<form class="row g-3">
							<div class="col-md-6">
								<label for="inputEmail4" class="form-label">Email</label> <input
									type="email" class="form-control" id="inputEmail4">
							</div>
							<div class="col-md-6">
								<label for="inputPassword4" class="form-label">Password</label>
								<input type="password" class="form-control" id="inputPassword4">
							</div>
							<div class="col-12">
								<label for="inputAddress" class="form-label">Address</label> <input
									type="text" class="form-control" id="inputAddress"
									placeholder="1234 Main St">
							</div>
							<div class="col-12">
								<label for="inputAddress2" class="form-label">Address 2</label>
								<input type="text" class="form-control" id="inputAddress2"
									placeholder="Apartment, studio, or floor">
							</div>
							<div class="col-md-6">
								<label for="inputCity" class="form-label">City</label> <input
									type="text" class="form-control" id="inputCity">
							</div>
							<div class="col-md-4">
								<label for="inputState" class="form-label">State</label> <select
									id="inputState" class="form-select">
									<option selected>Choose...</option>
									<option>...</option>
								</select>
							</div>
							<div class="col-md-2">
								<label for="inputZip" class="form-label">Zip</label> <input
									type="text" class="form-control" id="inputZip">
							</div>
							<div class="col-12">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" id="gridCheck">
									<label class="form-check-label" for="gridCheck"> Check
										me out </label>
								</div>
							</div>
							<div class="col-12">
								<button type="submit" class="btn btn-primary">Sign in</button>
							</div>
						</form>
					</div>
					<div class="dataTable-bottom">
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
						<p>Modal body text goes here.</p>
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