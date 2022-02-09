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
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/federico/resources/css/styles.css" rel="stylesheet" />

</head>
<body>
	<!-- Navigation-->
	<%@include file="nav.jsp"%>				
	
	<!-- Section--> 
	<section class="container" style="height: auto; min-height: 100%; padding-bottom: 168px;">
		<br><div class="text-center"><h1 class="display-6 lead">장바구니</h1></div>	
		<!-- 장바구니 메뉴 -->
		<div class="container-fluid">
			<hr><div class="row" align="center">
				<div class="col-6 fw-bold fs-6">메뉴</div>
				<div class="col-2 fw-bold fs-6">수량</div>
				<div class="col-2 fw-bold fs-6">가격</div>
				<div class="col-1 fw-bold fs-6">변경</div>
				<div class="col-1 fw-bold fs-6">삭제</div>
			</div><hr>
			<div id="divdiv">
				<c:if test="${empty list}">
					<br><div align="center" style="font-size: xx-large;">장바구니가 <b>비어</b>있습니다.<br></div>
					<div align="center" style="color: gray; font-size: large;">메뉴를 선택해주세요.</div>
					<div align="center" class="my-5">
						<button type="button" class="btn btn-outline-danger btn-lg" onclick="location.href='menuList?menuFlag=pizza'" style="width:350px; border-radius: 50px">
							메뉴 선택하기
						</button>
					</div>
					<div align="center" class="my-5">
					<img src="/federico/resources/Image/noCart2.png" style="opacity: 0.4; width: 500px;">
					</div>
				</c:if>
				<c:if test="${! empty sessionScope.list}"> 
					<c:forEach var="vo" items="${list}" varStatus="vs">
						<div class="row" align="center" style="font-size: 1.1rem;">
							<!-- 메뉴이미지, 이름 -->
							<div class="col-6" >
								<img src="${vo.menuVo.menuImage}"
								 width="200" height="200" align="left">
								<span class="fw-bold fs-4" style="vertical-align: top;">
									${vo.menuVo.menuName}
								</span>
							</div>
							<!-- 메뉴수량 -->
							<div class="col-2" style="line-height: 200px;">
								<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-arrow-down-circle-fill btn" id="arrowUp" viewBox="0 0 16 16"
								 onclick="arrowDown('cartQty${vs.index}')">
							  	<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM8.5 4.5a.5.5 0 0 0-1 0v5.793L5.354 8.146a.5.5 0 1 0-.708.708l3 3a.5.5 0 0 0 .708 0l3-3a.5.5 0 0 0-.708-.708L8.5 10.293V4.5z"/>
								</svg>
								&nbsp;&nbsp;<span  id="cartQty${vs.index}" style="text-align: center;" data-index=${vs.index} data-price=${vo.menuVo.menuPrice} data-seq=${vo.cartSeq }>${vo.menuQty}</span>&nbsp;&nbsp;
								<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="currentColor" class="bi bi-arrow-up-circle-fill btn" id="arrowDown" viewBox="0 0 16 16"
								 onclick="arrowUp('cartQty${vs.index}')">
							    <path d="M16 8A8 8 0 1 0 0 8a8 8 0 0 0 16 0zm-7.5 3.5a.5.5 0 0 1-1 0V5.707L5.354 7.854a.5.5 0 1 1-.708-.708l3-3a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1-.708.708L8.5 5.707V11.5z"/>
								</svg>
							</div>
							<!-- 메뉴가격 -->
							<div class="col-2" id="menuPrice${vs.index}" style="line-height: 200px;">
								<fmt:formatNumber value="${vo.menuVo.menuPrice * vo.menuQty}"/>원
							</div>
							<!-- 변경저장 -->
							<div class="col-1" style="line-height: 200px;">
							<c:if test="${empty clientLoginID}">
								<div id="saveChangeNM${vs.index}" class="badge bg-secondary text-wrap" style="width: 5rem;">
									변경저장
								</div>			
							</c:if>		
							<c:if test="${! empty clientLoginID}">
								<div id="saveChangeM${vs.index}" class="badge bg-secondary text-wrap" style="width: 5rem;">
									변경저장
								</div>			
							</c:if>		
							
							</div>
							<!-- 삭제 -->
							<div class="col-1" style="line-height: 200px;">
								<c:if test="${empty clientLoginID}">
								<a href="javascript:;" style="color: black; text-decoration: none;" onclick="deleteCartMenuNM(${vs.index})">X</a>
								</c:if>
								<c:if test="${! empty clientLoginID}">
								<a href="javascript:;" style="color: black; text-decoration: none;" onclick="deleteCartMenuM(${vs.index})">X</a>
								</c:if>
								
							</div>
						</div><hr><!-- 메뉴이미지, 이름 -->
						<!-- 필요한값 숨기기 -->
						<c:set var="totalPrice" value="${totalPrice + (vo.menuVo.menuPrice * vo.menuQty) }"/>
						<c:if test="${vs.last}">
						<input id="cartSize" type="hidden" value="${vs.count}">
						</c:if>
					</c:forEach>
					<div class="row">
						<div class="col-1"></div>
						<div class="col-5" align="left" style="font-weight: bold; font-size: 1.3rem;">
							합 계
						</div>
						<div class="col-6" align="right">
							<span style="font-weight: bold; font-size: 1.3rem;">총 </span>
							<span id="totalPrice" style="font-weight: bold; font-size: 2rem;"><fmt:formatNumber value="${totalPrice}"/></span>
							<span style="font-weight: bold; font-size: 1.3rem;"> 원</span>
						</div>
					</div>
					<div class="row mt-5">
						<div class="col-6" align="left">
							<button type="button" class="btn btn-outline-danger" onclick="location.href='menuList?menuFlag=pizza'">
								메뉴 보러가기
							</button>
						</div>
						<div align="right" class="col-6" >
							<button type="button" class="btn btn-danger" onclick="location.href='orderInfo'" >
								결제하기
							</button>
						</div>
					</div><br>
				</c:if>
			</div>
		</div><!-- 장바구니 메뉴 -->
		
	</section>
	
	<!-- Footer-->
	<%@include file="footer.jsp"%>
	

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/client_Script.js"></script>
</body>
</html>

