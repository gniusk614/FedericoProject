<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>로그인 - Federico Franchise</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script> -->
</head>
<body class="bg-success">
	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row" style="height: 100px;"></div>
					<!-- 로고 -->
					<div class="row justify-content-center mt-1 py-1">
						<div class="col-lg-5" align="center">
							<img src="/federico/resources/Image/franchiseLogin.png" style="width: 400px;">
						</div>
					</div>
					<div class="row justify-content-center">
						<div class="col-lg-5">
							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-body">
									<form action="login" method="post">
										<div class="form-floating mb-3">
											<input class="form-control" type="text" id="fcId"
												name="fcId" placeholder="staffCode" /> <label
												for="inputId">가맹점 ID</label>
										</div>
										<div class="form-floating mb-3">
											<input class="form-control" id="fcPassword" name="fcPassword"
												type="password" placeholder="Password" /> <label
												for="inputPassword">Password</label>
										</div>
										<div style="font-size: small; color: red;">
											<c:if test="${not empty message}">${message}</c:if>
										</div>
										<div
											class="d-flex align-items-center justify-content-between mt-4 mb-0">
											<div class="col-xxl-8">
											</div>
											<div class="col-xxl-4">
												<a class="btn btn-success" href="/federico/">메인으로</a> 
												<input class="btn btn-success" type="submit" value="Login">
												<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
		<div id="layoutAuthentication_footer">
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Fedrico F&C all right reserved</div>
						<div>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
</body>
</html>
