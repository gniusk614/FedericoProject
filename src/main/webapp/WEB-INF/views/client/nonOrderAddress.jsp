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
					<h1 class="display-6">배달지 선택</h1>
				</div>
			</div>
			<div class="row justify-content-md-center">
				<div class="col-sm-9 checked" align="center"></div>
			</div>
			<div class="row justify-content-md-center mt-5"
				style="height: 100px;">
				<div class="col-sm-8" align="center"
					style="background-color: WhiteSmoke; border-radius: 10px 10px 10px 10px;">
					<table style="width: 100%; height: 100px; border: none;">
						<tr>
							<td class="align-middle">
								<div class="row">
									<div class="col" id="nonName">
										<b>${nonName}</b>
									</div>
								</div>
							</td>
							<td>
								<div class="col" align="left">
									<div class="row">
										<div class="col" id="nonPhone">
											<b>${nonPhone}</b>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col" id="nonAddress">주소를 입력해주세요</div>
								</div>
								<div class="row">
									<div class="col" id="nonAddressDetail"></div>
								</div>
							</td>
							<td>
								<div class="col-sm" align="center">
									<button class="btn btn-danger" type="button"
										onclick="javaScript: $('#addressModal').modal('show');">주소찾기</button>
								</div>
							</td>
						</tr>

					</table>
				</div>
			</div>
			<div class="row justify-content-md-center mt-5">
				<img src="/federico/resources/Image/delievery2.png"
					style="width: 400px; opacity: 0.4">
			</div>
			<form id="jumun" method="POST" >
				<input type="hidden" name="nonName" value="${nonName}"> 
				<input type="hidden" name="nonPhone" value="${nonPhone}">
				<input type="hidden" name="nonAddress">
			</form>

			<div class="row justify-content-md-center mt-5">
				<div class="col-sm" align="center">
					<c:if test="${not empty list}">
					<button class="btn btn-danger" type="button"
						onclick="moveOrder(1)">주문하러가기</button>
					</c:if>
					<c:if test="${empty list}">
					<button class="btn btn-danger" type="button"
						onclick="moveOrder(2)">메뉴선택하러가기</button>
					</c:if>
				</div>
			</div>
		</div>
	</section>


	<!-- footer inlcud -->
	<%@ include file="footer.jsp"%>

	<div class="modal fade" id="addressModal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">주소 찾기</h5>
					<button type="button" class="btn-close infoClose"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="card">
						<div class="card-header">
							<i class="bi bi-house-fill"></i> 주소 찾기</a>
						</div>
						<div class="card-body">
							<div class="row">
								<div class="col-sm-8">
									<div class="input-group mb-2">
										<input id="post" type="text" class="form-control" readonly
											placeholder="우편번호">
										<button class="btn btn-outline-danger" type="button"
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
						</div>
					</div>
					<div class="modal-footer">
						<div class="container-fluid">
							<div class="row">
								<div class="col" align="right">
									<button type="button" class="btn btn-danger"
										onclick="inputAddress()">입 력</button>
									<button type="button" class="btn btn-secondary"
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