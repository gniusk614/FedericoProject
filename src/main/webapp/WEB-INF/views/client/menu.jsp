<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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

.menuIntro {
  width: 260px;
  
  /* 특정 단위로 텍스트를 자르기 위한 구문 */
  white-space: normal;
  display: -webkit-box;
  -webkit-line-clamp: 4; /* 텍스트를 자를 때 원하는 단위 ex) 3줄 */
  -webkit-box-orient: vertical;
  overflow: hidden;  
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
			<div class="text-center"><h1 class="display-6">피자</h1></div>
			<div class="text-center h5 my-4"> 
				맛있고 건강한 피자! 페데리코의 <span style="color: Crimson;">다양한 피자</span>를 주문해 보세요
			</div>
		</c:if>
		<c:if test="${flag == 'sets'}">
			<br>
			<div class="text-center"><h1 class="display-6">세트</h1></div>
			<div class="text-center h5 my-4"> 
				내가 좋아하는 피자와 사이드를 골라 <span style="color: Crimson;">나만의 세트메뉴</span>를 주문해 보세요
			</div>
		</c:if>
		<c:if test="${flag == 'side'}">
			<br>
			<div class="text-center"><h1 class="display-6">사이드</h1></div>
			<div class="text-center h5 my-4"> 
				페데리코만의 <span style="color: Crimson;">특별한 사이드메뉴</span>를 만나보세요
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
							<div class="card-body py-3 px-4">
								<div class="fw-bold fs-4" style="text-align: left;">${vo.menuName }</div>
								<p class="card-text menuIntro mt-1" style="color:gray; height: 100px;">${vo.menuIntro}</p>
								<span class="mt-4 fw-bold fs-4"><fmt:formatNumber value="${vo.menuPrice}"/></span>
							</div>
						</div>
							<!-- 내용 들어가는 부분 -->
					</div>
					<div class="menu-hidden" id="hidden${vs.index}">
					<c:if test="${empty clientLoginID}">
						<button type="button" class="btn btn-danger menu-button" id="hiddenbtn${vs.index}"
						onclick="showAddCartModal(${vo.menuIndex})">
							장바구니</button>
					</c:if>		
					<c:if test="${! empty clientLoginID}">
						<button type="button" class="btn btn-danger menu-button" id="hiddenbtn${vs.index}"
						onclick="showAddCartModalMember(${vo.menuIndex})">
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
						<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-arrow-down-circle-fill btn" id="arrowUp" viewBox="0 0 16 16"
							onclick="arrowDown('addCartQty')">
						  <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
						</svg>						
						&nbsp;&nbsp;<span  id="addCartQty" style="font-size: 2.5rem; text-align: center;">1</span>&nbsp;&nbsp;
						<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-arrow-up-circle-fill btn" id="arrowDown" viewBox="0 0 16 16"
							onclick="arrowUp('addCartQty')">
						  <path d="M16 8A8 8 0 1 0 0 8a8 8 0 0 0 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
						</svg>					
					</div>
				</div>
				<!-- modal-body -->
				<div class="modal-footer">
					<div class="container-fluid">	
						<div class="row">
							<div class="col-6" align="left">
								<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
							</div>
							<div class="col-6" align="right">
								<button type="button" class="btn btn-danger" id="btn-addCart">추가</button>
							</div>
						</div>
					</div>
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

