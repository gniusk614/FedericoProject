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
		<br><div class="text-center fw-bold fst-italic fs-1">장바구니</div>	
		<!-- 장바구니 메뉴 -->
		<div class="container-fluid">
			<hr><div class="row" align="center">
				<div class="col-6 fw-bold fs-5">메뉴</div>
				<div class="col-2 fw-bold fs-5">수량</div>
				<div class="col-2 fw-bold fs-5">가격</div>
				<div class="col-1 fw-bold fs-5">변경</div>
				<div class="col-1 fw-bold fs-5">삭제</div>
			</div><hr>
	<%-- 		<div class="row" align="center">
				<div class="col-6" >
					<img src="/federico/resources/uploadImage/menuImage/Prosciutto-Lucola_pizza.png"
					 width="200" height="200" align="left">
					<span class="fw-bold fs-4" style="vertical-align: top;">
						맛있는피자
					</span>
				</div>
				<div class="col-2" style="line-height: 200px;">
					3개
				</div>
				<div class="col-2" style="line-height: 200px;">
					<fmt:formatNumber value="8000"/>원
				</div>
				<div class="col-1" style="line-height: 200px;">
					변경
				</div>
				<div class="col-1" style="line-height: 200px;">
					삭제
				</div>
			</div><hr> --%>
			
			<c:forEach var="vo" items="${list}" varStatus="vs">
			<div class="row" align="center">
				<div class="col-6" >
					<img src="${vo.menuVo.menuImage}"
					 width="200" height="200" align="left">
					<span class="fw-bold fs-4" style="vertical-align: top;">
						${vo.menuVo.menuName}
					</span>
				</div>
				<div class="col-2" style="line-height: 200px;">
					-   ${vo.menuQty}  +
				</div>
				<div class="col-2" style="line-height: 200px;">
					<fmt:formatNumber value="${vo.menuVo.menuPrice * vo.menuQty}"/>원
				</div>
				<div class="col-1" style="line-height: 200px;">
					변경
				</div>
				<div class="col-1" style="line-height: 200px;">
					삭제
				</div>
			</div><hr>
			</c:forEach>
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

