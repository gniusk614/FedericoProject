<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>페데리꼬 피자</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/inCheck.js"></script>
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
	
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
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
<body>
	<%@include file="nav.jsp"%>
	<!-- Section-->
	<section class="container py-5"
		style="height: auto; min-height: 100%; padding-bottom: 168px;">

		<div class="container-fluid">
			<div class="row mb-5">
				<div class="col-md-3"></div>
				<div class="col-md-6" align="center">
					<h1 class="display-6">내 정보수정</h1>
				</div>
				<div class="col-md-3"></div>
			</div>
			<hr>
			<!-- 본문 시작 -->
			<div class="container">
				<div class="container" style="width: 940px;">
					<div class="row justify-content-md-center mt-5 py-0">
						<div class="col-10" align="center">
							<div class="form-group gy-5">
								<div class="input-group mb-4">
									<input type="text" id="clientId" name="clientId"
										class="form-control" value="${clientVO.clientId}"
										readonly="readonly">
								</div>
							</div>
							<div class="form-group gy-5">
								<div class="input-group mb-4">
									<input type="text" id="clientName" name="clientName"
										class="form-control" value="${clientVO.clientName}"
										readonly="readonly">
								</div>
							</div>
							<div class="form-group has-success mb-4">
								<button type="button" class="btn btn-outline-danger"
									onclick="javascript:$('#pwchangeModal').modal('show');"
									style="width: 100%">비밀번호 변경</button>
							</div>

							<div class="input-group mb-4">
								<input id="clientPhone" name="clientPhone" class="form-control"
									type="text" readonly="readonly" value="${clientVO.clientPhone}">
								<button class="btn btn-outline-danger" type="button"
									id="button-addon2"
									onclick="javascript:$('#phoneCheckModal_up').modal('show');">휴대폰인증</button>
							</div>
							<div class="input-group mb-4">
								<input id="clientBirthday" name="clientBirthday"
									class="form-control" type="text" readonly="readonly"
									value="${clientVO.clientBirthday}">
							</div>


							<div class="input-group mb-4">
								<input type="text" class="form-control" id="inputEmail"
									value="${fn:substringBefore(clientVO.clientEmail, '@')}"
									placeholder="이메일"> <span class="input-group-text">@</span>
								<input id="emailServer" type="text" class="form-control"
									value="${fn:substringAfter(clientVO.clientEmail, '@')}"
									readonly="readonly"> <select class="form-select"
									id="selectServer">
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
										value="${clientVO.clientAddress}" readonly="readonly">
									<button class="btn btn-outline-danger" type="button"
										onclick="findAddr()">주소검색</button>
								</div>
							</div>
							<div class="row">
								<div class="input-group mb-4">
									<input id="addressDetail" type="text" class="form-control" disabled="disabled"
										placeholder="상세주소">
									<div class="invalid-feedback" id="cadMessage" align="left"></div>
								</div>
							</div>

							<div class="row px-0">
								<div class="col-3" align="left">
									<span onclick="joinCheckboxCheck('sms')"
										style="cursor: pointer;"> <i id="smsCheckbox_no"
										class="bi bi-check-circle danger" style="color: crimson;"></i>
										<i id="smsCheckbox_yes" class="bi bi-check-circle-fill danger"
										style="color: crimson; display: none;"></i> SMS 수신동의
									</span>
								</div>
								<div class="col-3" align="left">
									<span onclick="joinCheckboxCheck('email')"
										style="cursor: pointer;"> <i id="emailCheckbox_no"
										class="bi bi-check-circle danger" style="color: crimson;"></i>
										<i id="emailCheckbox_yes"
										class="bi bi-check-circle-fill danger"
										style="color: crimson; display: none;"></i> E-mail 수신동의
									</span>
								</div>
							</div>

							<div class="row px-0" style="height: 100px;">
								<div
									class="d-flex align-items-center justify-content-between mb-0">

									<input type="hidden" id="smsCheck" name="smsCheck"
										value="${smsCheck}"> <input type="hidden"
										id="emailCheck" name="emailCheck" value="${emailCheck}">
									<button class="btn btn-secondary"
										onclick="window.history.back()"
										style="width: 50%; height: 60px; font-size: large;">뒤로가기</button>
									&nbsp;&nbsp;
									<button class="btn btn-danger" type="submit"
										onclick="UpdateMyinfo()"
										style="width: 50%; height: 60px; font-size: large;">확인</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- 휴대폰인증 모달 -->
	<div class="modal fade" id="phoneCheckModal_up" role="dialog">
		<div class="modal-dialog" style="width: 500px;">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">휴대폰 인증</h5>
					<button type="button" class="btn-close infoClose"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="card">
						<div class="card-body">
							<div class="form input-group mb-3">
								<input class="form-control" id="inputPhoneNumber"
									oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');"
									name="PhoneNumber" type="text" placeholder="핸드폰번호" />
								<button class="btn btn-outline-danger" type="button"
									id="button-addon2" onclick="infoUpsendSms()">인증번호 발송</button>
								<div class="invalid-feedback" id="phoneMessage"
									style="font-size: small;" align="left"></div>
							</div>
							<div class="form input-group mb-3">
								<input class="form-control" id="inputCertifiedNumber"
									name="inputCertifiedNumber" type="text"
									oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');"
									placeholder="인증번호" readonly="readonly" />
								<button class="btn btn-outline-danger" type="button" onclick="phoneCheckBtnInfoUp()"
									id="checkBtn">인증번호 확인</button>
							</div>
						</div>
						<div class="modal-footer">
							<div class="container-fluid">
								<div class="row justify-content-md-center">
									<div class="col-6">
										<input class="btn btn-danger" id="phoneChangeConfirm"
											type="button" onclick="phonechangeSumit()"
											style="width: 100%;" value="수정" disabled="disabled">
									</div>
									<div class="col-6">
										<button type="button" class="btn btn-secondary infoClose"
											style="width: 100%;" data-bs-dismiss="modal">Close</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<div class="modal fade" id="pwchangeModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
	  								<path
								d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z" />
								</svg>
						&nbsp;비밀번호 수정
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div id="modal-body" class="modal-body">
					<div class="container-fluid px-4">
						<div class="form-group gy-5">
							<div class="form-group has-success mb-4">
								<input type="password" class="form-control" id="clientPassword"
									name="clientPassword"
									placeholder="새로운 비밀번호(8~16자리 영문자, 숫자와 특수문자는 1개 이상 포함)"
									maxlength="16">
								<div class="invalid-feedback" id="cpMessage" align="left"></div>
							</div>
							<div class="form-group has-danger mb-4">
								<input type="password" class="form-control"
									id="clientPasswordRepeat" disabled="disabled"
									placeholder="비밀번호 확인">
								<div class="invalid-feedback" id="cprMessage" align="left"></div>
							</div>
							<div>
								<br>
							</div>
							<div class="row">
								<div class="col-6">
									<input class="btn btn-danger" type="button" style="width: 100%;"
										onclick="pwchangeSumit()" value="수정">
								</div>
								<div class="col-6">
									<button type="button" class="btn btn-secondary" style="width: 100%;"
										onclick="$('#pwchangeModal').modal('hide')">Close</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>



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
						$('#addressDetail').attr('disabled',false);
					} else if (jibunAddr !== '') {
						$("#address").val(jibunAddr);
						$('#addressDetail').attr('disabled',false);
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
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/client_Script.js"></script>
</body>
</html>

