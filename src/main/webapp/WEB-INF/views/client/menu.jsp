<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>페데리꼬 피자</title>
<!-- Favicon-->
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<style>
@media (min-width: 992px) {
  #carouselExampleIndicators {
   height: 500px;
  }
} 

.menu-card { height: 240px; width: 550px; display: inline-block; margin: 20px; z-index: 500; position: relative;} 

.menu-hidden{ 
			height: 100%; width: 100%; display: none; background-color: rgba(105, 105, 105, 0.5); 
			position: absolute; left: 0; top: 0; z-index: 300;
				}
.menu-button{ margin: auto; display: none; position: absolute; right:20px; top:190px; z-index: 100;}

input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
}

</style>

</head>
<body>
	<!-- Navigation-->
	<%@include file="nav.jsp"%>
	
	<!-- Section-->
	<section class="container" style="height: auto; min-height: 100%; padding-bottom: 168px;">

		<c:if test="${flag == 'pizza'}">
			<br>
			<div class="text-center fw-bold fst-italic fs-1">PIZZA</div>
			<div class="text-center fs-4 fst-italic">
				<span class="badge bg-danger">FEDERICO</span>만의 개성이 담긴 피자를 주문해보세요
			</div>
		</c:if>
		<c:if test="${flag == 'sets'}">
			<br>
			<div class="text-center fw-bold fst-italic fs-1">SET</div>
			<div class="text-center fs-4 fst-italic">
				<span class="badge bg-danger">FEDERICO</span>의 개성을 모아둔 세트를 만나보세요
			</div>
		</c:if>
		<c:if test="${flag == 'side'}">
			<br>
			<div class="text-center fw-bold fst-italic fs-1">SIDE</div>
			<div class="text-center fs-4 fst-italic">
				<span class="badge bg-danger">FEDERICO</span>만의 특별한 사이드메뉴를 경험해보세요
			</div>
		</c:if>
		<hr>


		<div class="container">
			<!-- 메뉴조회 카드 시작 -->
			<c:forEach var="vo" items="${list}" varStatus="vs">
				<div class="card menu-card" id="card${vs.index}"
					onmouseover="btnShow(${vs.index})"
					onmouseleave="btnHide(${vs.index})">
					<div class="row no-gutters">
						<!-- 이미지 들어가는 부분 -->
						<div class="col-5">
							<img src="${vo.menuImage }" height="240px" />
						</div>
						<!-- 이미지 들어가는 부분 -->
						<!-- 내용 들어가는 부분 -->
						<div class="col-7">
							<div class="card-body">
								<span class="fw-bold fs-2">${vo.menuName }</span>
								<p class="card-text">${vo.menuIntro}</p>
							</div>
							<!-- 내용 들어가는 부분 -->
						</div>
					</div>
					<div class="menu-hidden" id="hidden${vs.index}">
					<c:if test="${empty loginID && empty client}">
						<button type="button" class="btn btn-success menu-button" id="hiddenbtn${vs.index}"
						onclick="showAddCartModal(${vo.menuIndex})">
							장바구니</button>
					</c:if>		
					<c:if test="${! empty loginID && ! empty client}">
						<button type="button" class="btn btn-success menu-button" id="hiddenbtn${vs.index}"
						onclick="showAddCartModalMember(${vo.menuIndex}, '${loginID}')">
							장바구니</button>
					</c:if>		
					</div>
				</div>
			</c:forEach>
		</div>
	</section>
	
	<!-- 장바구니 추가 모달 -->
	<div class="modal fade " id="addCartModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="fcOrderDetailModal">장바구니 추가</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<!-- "modal-body" -->
				<div class="modal-body">
					<div align="center">
						<svg xmlns="http://www.w3.org/2000/svg" width="65" height="65" fill="currentColor" class="bi bi-arrow-down-circle-fill btn" id="arrowUp" viewBox="0 0 16 16"
							onclick="arrowDown('addCartQty')">
						  <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
						</svg>						
						&nbsp;&nbsp;<span  id="addCartQty" style="font-size: 2.5rem; text-align: center;">1</span>&nbsp;&nbsp;
						<svg xmlns="http://www.w3.org/2000/svg" width="65" height="65" fill="currentColor" class="bi bi-arrow-up-circle-fill btn" id="arrowDown" viewBox="0 0 16 16"
							onclick="arrowUp('addCartQty')">
						  <path d="M16 8A8 8 0 1 0 0 8a8 8 0 0 0 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
						</svg>					
					</div>
				</div>
				<!-- modal-body -->
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
						<button type="button" class="btn btn-primary" id="btn-addCart">추가</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 장바구니 추가 모달 -->










	<!-- Footer-->
	<%@include file="footer.jsp"%>
	

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/client_Script.js"></script>
</body>
</html>

