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
	
	<!-- 현재시간 + 가맹점별 deliveryTime 계산 -->
	<jsp:useBean id="now" class="java.util.Date"/>
	<fmt:formatDate value="${now}" pattern="HH" var="now_hour"/>
	<fmt:formatDate value="${now}" pattern="mm" var="now_minute"/>
	<fmt:parseNumber var="delivery_ms" value="${now_hour*60*60*1000 + now_minute*60*1000 + deliveryTime*60*1000}" />
	<fmt:parseNumber var="now_hh" value="${delivery_ms/1000/60/60}" integerOnly="true" />
	<fmt:formatNumber var="now_mm" value="${delivery_ms/1000/60%60}" pattern="00" />
	<div>
	</div>
	<!-- Section--> 
	<section class="container" style=" min-height: 900px; padding-bottom: 168px;">
	<!-- 본문 시작 -->
		<div class="container" style="width: 940px;">
			<br><div class="text-center mt-5"><h1 class="display-6">주문이 완료되었습니다 : )</h1></div>
			<br><div class="text-center mt-5"><p class="lead" style="font-size: xx-large;">배달완료 예정시간은 
			<span class="lead" style="font-size:xx-large; color: crimson;">${now_hh}시${now_mm}분</span>입니다.</p></div>
		</div>
		<div class="row justify-content-md-center mt-5">
		<img src="/federico/resources/Image/delievery2.png"
					style="width: 400px; opacity: 0.4">
		</div>				
		<div class="row justify-content-md-center mt-5">
				<div class="col-sm" align="center">
					<button class="btn btn-danger" type="button"
						onclick="javaScript:location.href='home'">메인홈페이지 이동</button>
				</div>
		</div>
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

