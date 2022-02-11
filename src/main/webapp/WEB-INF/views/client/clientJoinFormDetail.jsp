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
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
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
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<style>
.checked {
	border-bottom: 2px solid black;
	color: black;
}

.checked .a {
	font-size: large;
	color: gray;
}
table, tr, td, th {
	border: 1px solid black;
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
					<h1 class="display-6">회원가입</h1>
				</div>
				<div class="col-md-3"></div>
			</div>
			<div class="row justify-content-md-center">
				<div class="row justify-content-md-center"
					style="height: 50px; border-bottom: 1px solid gray; width: 700px;">
					<div class="col-sm-6" align="center">
						<img src="/federico/resources/Image/num_1_fill.png"
							style="width: 30px"> <span
							style="font-size: large; color: crimson; font-weight: bold;">
							&nbsp;&nbsp;&nbsp;&nbsp;･･</span>&nbsp;&nbsp;&nbsp;&nbsp; <img
							src="/federico/resources/Image/num_2.png" style="width: 30px"><span
							style="font-size: large; color: crimson; font-weight: bold;">&nbsp;&nbsp;정보입력</span>
					</div>
					<!-- 컨텐츠 -->
					<div id="content">
						<div class="row justify-content-md-center mt-5 lead">
							<div style="font-size: xx-large;">
								페데리코에 가입하기 위해서는<br> <span style="color: crimson;">정보입력</span>
								이 필요해요 :)
							</div>
						</div>
						<div class="row justify-content-md-center mt-5 py-0">
							<form action="clientJoin" method="post">
								<div class="col-10">
									<div class="form-group gy-5">
										<div class="input-group mb-4">
											<input type="text" id="clientId" name="clientId" class="form-control" placeholder="아이디(6-12자리)" maxlength="12">
											<button class="btn btn-outline-danger" type="button" onclick="clientIdDubCheck()">중복확인</button>
											<div class="invalid-feedback" id="cidMessage"></div>
											<div class="valid-feedback" id="cidsuccessMessage"></div>
										</div>
									</div>
									<div class="form-group has-success mb-4">
										<input type="password" class="form-control" id="clientPassword" name="clientPassword" placeholder="비밀번호(8~16자리 영문자, 숫자와 특수문자는 1개 이상 포함)" maxlength="16" >
										<div class="invalid-feedback" id="cpMessage"></div>
									</div>
									<div class="form-group has-danger mb-4">
										<input type="password" class="form-control" id="clientPasswordRepeat" disabled="disabled" placeholder="비밀번호 확인">
										<div class="invalid-feedback" id="cprMessage"></div>
									</div>
									<div class="input-group mb-4">
										<input type="text" class="form-control" id="inputEmail" placeholder="이메일">
										<span class="input-group-text">@</span> 
										<input id="emailServer" type="text" class="form-control" value="naver.com" readonly="readonly"> 
										<select class="form-select" id="selectServer">
											<option selected value="naver.com">naver.com</option>
											<option value="daum.net">daum.net</option>
											<option value="gmail.com">gmail.com</option>
											<option value="nate.com">nate.com</option>
											<option value="etc">직접입력</option>
										</select>
										<div class="invalid-feedback" id="cemMessage"></div>
									</div>
									<div class="row">
										<div class="input-group mb-2">
											<input id="address" class="form-control" type="text"
												placeholder="주소" readonly>
											<button class="btn btn-outline-danger" type="button"
												onclick="findAddr()">주소검색</button>
										</div>
									</div>
									<div class="row">
										<div class="input-group mb-4">
											<input id="addressDetail" type="text" class="form-control"
												placeholder="상세주소">
											<div class="invalid-feedback" id="cadMessage"></div>
										</div>
									</div>
									<div class="row">
										<div class="input-group mb-2">
											<input id="clientBirthday" name="clientBirthday" class="form-control" type="text" placeholder="[선택] 생년월일 ex) 900614" maxlength="6">
											<div class="invalid-feedback" id="cbdMessage"></div>
										</div>
									</div>
									<div class="row px-0" style="height: 100px;">
										<div
											class="d-flex align-items-center justify-content-between mb-0">
											<input type="hidden" id="clientName" name="clientName" value="${clientName}"> 
											<input type="hidden" id="clientPhone" name="clientPhone" value="${clientPhone}">
											<input type="hidden" id="smsCheck" name="smsCheck" value="${smsCheck}">
											<input type="hidden" id="emailCheck" name="emailCheck" value="${emailCheck}">
											<input type="hidden" id="clientAddress" name="clientAddress">
											<input type="hidden" id="clientEmail" name="clientEmail">
											<button class="btn btn-secondary" type="reset" style="width: 50%; height: 60px; font-size: large;">취소</button>&nbsp;&nbsp;
											<button class="btn btn-danger" type="button"
												onclick="return clientIncheck()"
												style="width: 50%; height: 60px; font-size: large;">확인</button>
										</div>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
				</div>
	</section>
<%-- 	<!-- footer inlcud -->
	<%@ include file="footer.jsp"%>

 --%>


	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script>
		function findAddr() {
			var width = 500; //팝업의 너비
			var height = 600;
			
			new daum.Postcode({
				width: width, //생성자에 크기 값을 명시적으로 지정해야 합니다.
			    height: height,
				oncomplete : function(data) {
					
					var roadAddr = data.roadAddress; // 도로명 주소 변수
					var jibunAddr = data.jibunAddress; // 지번 주소 변수

					$('#post').val(data.zonecode);
					if (roadAddr !== '') {
						$("#address").val(roadAddr);
					} else if (jibunAddr !== '') {
						$("#address").val(jibunAddr);
					}
				},
				theme : {
						   bgColor: "#C00C0C", //바탕 배경색
						   emphTextColor: "#C01160" //강조 글자색
					}
			}).open({
				left: (window.screen.width/2)-(width/2),
			    top: (window.screen.height/2)-(height/2),
				popupTitle: '주소검색'
			});
		}
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/client_Script.js"></script>
</body>
</html>