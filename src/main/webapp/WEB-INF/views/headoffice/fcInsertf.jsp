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
<title>Federico Company</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/headOffice_Script.js"></script>
<script src="/federico/resources/myLib/inCheck.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f956895faa75830c33aed1c2b4e71939&libraries=services,clusterer,drawing"></script>
<style>
a:visited {
	text-decoration: none;
	color: black;
}

a:hover {
	text-decoration: none;
	color: black;
}

a {
	color: black;
	text-decoration: none;
}
</style>
</head>
<body>
	<%@ include file="navtop.jsp"%>
	<!-- layoutSidenav 시작 -->
	<div id="layoutSidenav">
		<%@ include file="navside.jsp"%>
		<div id="layoutSidenav_content">
			<!-- 본문 시작 -->
			<div class="container-fluid px-4" style="margin-top: 20px;">
				<div class="card" id="contentCard">
					<div class="card-header">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-shop" viewBox="0 0 16 16">
  						<path
								d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.371 2.371 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976l2.61-3.045zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0zM1.5 8.5A.5.5 0 0 1 2 9v6h1v-5a1 1 0 0 1 1-1h3a1 1 0 0 1 1 1v5h6V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5zM4 15h3v-5H4v5zm5-5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1v-3zm3 0h-2v3h2v-3z" />
					</svg>
						가맹점 계정생성
					</div>
					<div class="card-body">
						<div class="container-fluid px-4">
							<div class="col-sm-6">
								<div class="form-group gy-5">
									<label class="form-label">가맹점ID</label>
									<div class="input-group mb-2 ">
										<input type="text" id="fcId" class="form-control">
										<button class="btn btn-outline-primary" type="button"
											id="fcidDupcheck">중복확인</button>
										<div class="invalid-feedback" id="fcidMessage"></div>
										<div class="valid-feedback" id="fcidsuccessMessage"></div>
									</div>
								</div>
								<!-- 맞으면 스크립트에서 ${password}.addclass('is-valid')addclass -->
								<div class="form-group has-success mb-2">
									<label class="form-label">비밀번호</label> <input type="password"
										class="form-control" id="fcPassword"
										placeholder="길이4이상, 영문자, 숫자와 특수문자는 1개 이상 포함">
									<div class="invalid-feedback" id="fcpMessage"></div>
								</div>
								<!-- 맞으면 스크립트에서 ${passwordRepeat}.addclass('is-valid')addclass -->
								<!-- 틀리면 스크립트에서 ${passwordRepeat}.addclass('is-invalid')addclass -->
								<div class="form-group has-danger mb-2">
									<label class="form-label">비밀번호 확인</label> <input
										type="password" class="form-control" id="fcPasswordRepeat"
										disabled="disabled">
									<div class="invalid-feedback" id="fcprMessage"></div>
								</div>
								<div class="form-group mb-2">
									<label class="form-label">점주명</label> <input type="text"
										id="fcName" class="form-control">
								</div>
								<div class="form-group mb-2">
									<label class="form-label">지 역</label> <select
										class="form-select" id="fcArea">
										<option value="서울" selected>서울</option>
										<option value="경기">경기</option>
										<option value="인천">인천</option>
										<option value="대전">대전</option>
										<option value="부산">부산</option>
										<option value="대구">대구</option>
										<option value="울산">울산</option>
										<option value="세종">세종</option>
										<option value="광주">광주</option>
										<option value="강원">강원</option>
										<option value="충북">충북</option>
										<option value="충남">충남</option>
										<option value="경북">경북</option>
										<option value="경남">경남</option>
										<option value="전북">전북</option>
										<option value="전남">전남</option>
										<option value="제주">제주</option>
									</select>
								</div>
								<div class="row">
									<label class="form-label">가맹점 주소입력</label>
									<div class="col-sm-8">
										<div class="input-group mb-2">
											<input id="post" type="text" class="form-control" readonly
												placeholder="우편번호">
											<button class="btn btn-outline-primary" type="button"
												onclick="findAddr()">주소검색</button>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="input-group mb-2">
										<input id="address" class="form-control" type="text"
											placeholder="주소" readonly>
									</div>
								</div>
								<div class="row">
									<div class="input-group mb-2">
										<input id="addressDetail" type="text" class="form-control"
											placeholder="상세주소">
									</div>
								</div>
								<div class="form-group mb-2">
									<label class="form-label">연락처</label> <input type="text" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');"
										id="fcPhone" class="form-control">
								</div>
								<label class="form-label">담당직원</label>
								<div class="input-group mb-2 ">
									<input type="text" id="fchoId" readonly="readonly" onfocus="fcSearchStaff()" class="form-control">
								</div>
							</div>

						</div>
					</div>
					<div class="card-footer">
						<input class="btn btn-primary" type="button" id="fcSubmitBtn"
							value="계정생성"> <input class="btn btn-secondary"
							type="reset" id="fcInputresetBtn" value="입력취소">
					</div>
				</div>
			</div>
			<!-- footer inlcud -->
			<div><%@ include file="footer.jsp"%></div>
		</div>
		<!-- 본문 끝 -->
	</div>
	<!-- layoutSidenav 끝 -->



<div class="modal fade" id="hoIdSearchModal" role="dialog">
		<div class="modal-dialog"
			style="width: 500px; ">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">직원명단</h5>
					<button type="button" class="btn-close infoClose"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="card">
						<div class="card-body">
							<div id="resultArea"></div>
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
				   bgColor: "#162525", //바탕 배경색
				   searchBgColor: "#FFFFFF", //검색창 배경색
				   contentBgColor: "#FFFFFF", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
				   pageBgColor: "#FFFFFF", //페이지 배경색
				   textColor: "#162525", //기본 글자색
				   queryTextColor: "#162525", //검색창 글자색
				   outlineColor: "#444444" //테두리
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
</body>
</html>