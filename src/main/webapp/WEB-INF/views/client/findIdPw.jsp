<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
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
<script src="/federico/resources/ckeditor/ckeditor.js"></script>
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
			<div class="row mb-5">
				<div class="col-md-3"></div>
				<div class="col-md-6" align="center">
					<h1 class="display-6">아이디/비밀번호찾기</h1>
				</div>
				<div class="col-md-3"></div>
			</div>
			<div class="row justify-content-md-center" style="height: 50px;">
				<div id="findId" class="col-sm-4 checked" align="center"
					style="font-size: large; color: black; border-bottom: 2px solid black; cursor: pointer;"
					onclick="clickEffect('findId'); showIdPwDiv('findId');">
					아이디찾기</div>
				<div id="findPw" class="col-sm-4 checked" align="center"
					style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
					onclick="clickEffect('findPw'); showIdPwDiv('findPw');">
					비밀번호찾기</div>
			</div>
			<!-- 컨텐츠 -->
			<div id="content">
				<!-- 아이디찾기 -->
				<div id="findIdForm" class="container" style="display: block;">
					<div class="row justify-content-md-center mt-5"
						style="height: 200px;">
						<div class="col-6">
							<div class="form-floating mb-3">
								<input class="form-control" type="text" id="clientName"
									name="clientName" placeholder="clientName" /> <label
									for="clientName" style="font-size: large; color: gray;">고객명</label>
							</div>
							<div class="form-floating mb-3">
								<input class="form-control" id="clientPhone" name="clientPhone"
									type="text" placeholder="clientPhone" /> <label
									for="clientPhone" style="font-size: large; color: gray;">휴대폰번호</label>
							</div>
							<div
								class="d-flex align-items-center justify-content-between mb-0">
								<button class="btn btn-danger" type="submit"
									onclick="findId()"
									style="width: 100%; height: 60px; font-size: large;">아이디찾기</button>
							</div>
						</div>
					</div>
					<div class="row justify-content-md-center mt-5" style="height: 200px;">
						<div class="col-6" id="findIdMessage" hidden="hidden">
							<hr>
							<div style="height: 100px;" align="center">
							고객님의 아이디는 <span id="data" style="color:crimson; font-weight: bold;"></span> 입니다.
							</div>
							<button class="btn btn-outline-danger"
									onclick="location.href='clientLoginf'"
									style="width: 100%; height: 60px; font-size: large;">로그인</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 비밀번호찾기 -->
		<div id="findPwForm" class="container" style="display: none;">
			<div class="row justify-content-md-center mt-5"
				style="height: 200px;">
				<div class="col-6">
					<div class="form-floating mb-3">
						<input class="form-control" type="text" id="clientId"
							name="clientId" placeholder="clientId" /> <label for="clientId"
							style="font-size: large; color: gray;">아이디</label>
					</div>
					<div class="col py-3" id="joinPhoneCheckBtn" align="center"
						onclick="findIdCheck()"
						style="cursor: pointer; border-radius: 5px 5px 5px 5px; height: 100px; border: 1px solid crimson">
						<img src="/federico/resources/Image/phoneimg.png"
							style="width: 40px;"><br> <span id="checkText"
							style="color: crimson">휴대폰 인증</span>
					</div>
				</div>

			</div>
		</div>
	</section>
	<!-- footer include -->
	 <%@ include file="footer.jsp"%> 


<!-- 휴대폰인증 모달 -->
	<div class="modal fade" id="phoneCheckModal" role="dialog">
		<div class="modal-dialog"
			style="width: 500px; ">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">휴대폰 인증</h5>
					<button type="button" class="btn-close infoClose"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="card">
						<div class="card-body">
							<div class="form mb-3">
								<input class="form-control" type="text" id="inputClientName"
									name="inputClientName" placeholder="고객명" />
								<div class="invalid-feedback" id="failMessage"
									style="font-size: small;" align="left"></div>
							</div>
							<div class="form input-group mb-3">
								<input class="form-control" id="inputPhoneNumber"
									oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');"
									name="clientPhone" type="text" placeholder="핸드폰번호" />
								<button class="btn btn-outline-danger" type="button"
									id="button-addon2" onclick="findPwsendSms()">인증번호 발송</button>
								<div class="invalid-feedback" id="phoneMessage"
									style="font-size: small;" align="left"></div>
							</div>
							<div class="form input-group mb-3">
								<input class="form-control" id="inputCertifiedNumber"
									name="inputCertifiedNumber" type="text"
									oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');"
									placeholder="인증번호" readonly="readonly" />
								<button class="btn btn-outline-danger" type="button"
									id="checkBtn">인증번호 확인</button>
							</div>
						</div>
						<div class="modal-footer">
						<div class="container-fluid">
							<div class="row">
								<button type="button" class="btn btn-secondary infoClose"
									data-bs-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/client_Script.js"></script>
</body>
</html>