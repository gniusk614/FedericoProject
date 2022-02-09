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
<title>페데리꼬 피자</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/inCheck.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>

<style>
.checked {
	border-bottom: 2px solid black;
	color: black;
}

.checked .a {
	font-size: large;
	color: gray;
}
</style>
</head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<body>


	<!-- Navigation-->
	<%@include file="nav.jsp"%>
	<!-- 본문 시작 -->
	<section class="container py-5"
		style="height: auto; min-height: 100%; padding-bottom: 168px;">
		<div class="container-fluid">
			<div class="row justify-content-md-center mb-2">
				<div class="col-md-6" align="center">
					<h1 class="display-6">고객의 소리 등록 완료</h1>
				</div>
			</div>
			<div class="row justify-content-md-center">
				<div class="col-sm-9 checked" align="center"></div>
			</div>
			<div class="row justify-content-md-center mt-5">
				<div class="col-sm-8 lead" align="center">
					고객의 소리가 등록 완료 되었습니다.<br>
					담당자 확인 후 신속하게 처리하겠습니다.
				</div>
			</div>
			
			<div class="row justify-content-md-center mt-5">
				<img src="/federico/resources/Image/csCenter.png"
					style="width: 400px; opacity: 0.4">
			</div>
			

			<div class="row justify-content-md-center mt-5">
				<div class="col-sm" align="center">
					<button class="btn btn-danger" type="button"
						onclick="javaScript:location.href='home'">메인홈페이지 이동</button>
				</div>
			</div>
		</div>
	</section>


	<!-- footer inlcud -->
	<%@ include file="footer.jsp"%>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/client_Script.js"></script>
</body>
</html>