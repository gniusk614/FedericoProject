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
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
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

@media (min-width: 992px) {
  #carouselExampleIndicators {
   height: 500px;
  }
}
@font-face {
    font-family: 'Treegarden';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/naverfont_10@1.0/Treegarden.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}


</style>
</head>
<body class="bg-danger">
	<!-- Navigation-->
	<%@include file="nav.jsp"%>
	
	
	<!-- Header-->
	<header class="container bg-danger py-4">
		<div class="row justify-content-md-center mb-3">
			<div class="col-12 lead" align="center" style="font-size:x-large; height: 100px; color: white;">
			페데리코가 준비한 <b>깊은 풍미의 피자</b>를 즐겨보세요<br>
			<p style="font-family: Treegarden; font-size: xx-large;">The uglier it is, the tastier it is .<p>
			</div>
		</div>
		<div class="row justify-content-md-center">
			<div class="col-12">
				<div id="carouselExampleIndicators" class="carousel slide"
					data-bs-ride="carousel" style="overflow: hidden;">
					<div class="carousel-inner" style="z-index: 1;">
						<div class="carousel-item active">
							<img src="/federico/resources/Image/top_mv_notxt01.jpeg"
								class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img src="/federico/resources/Image/top_mv_notxt02.jpeg"
								class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img src="/federico/resources/Image/top_mv_notxt03.jpeg"
								class="d-block w-100" alt="...">
						</div>
					</div>
					<button class="carousel-control-prev" type="button"
						data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>
			<div class="row justify-content-md-center" style="height: 100px;">
				<div class="col-6 bg-light py-4" align="center" 
				style="font-size: x-large; color: crimson; border-top: 1px solid crimson; border-right: 2px solid crimson; border-radius: 5px; cursor: pointer;"
				onclick="javaScript:location.href='menuList?menuFlag=pizza'">
				<img src="/federico/resources/Image/delieveryLogo.png" alt="..." style="width: 50px;">
				&nbsp;&nbsp;&nbsp;주문하기</div>
				<div class="col-6 bg-light py-4" align="center" 
				style="font-size: x-large; color: crimson; border-top: 1px solid crimson; border-radius: 5px; cursor: pointer;" 
				onclick="javaScript: location.href='#'">
				<img src="/federico/resources/Image/mapLogo.png" alt="..." style="width: 40px;">
				&nbsp;&nbsp;&nbsp;매장찾기</div>
			</div>
		</div>
	</header>
	<!-- Section-->
	<section class="container py-5" style="height: 180px; z-index: 3; position: relative; margin-bottom: 168px;">
		
	</section>
	
	<!-- Footer-->
	<%@include file="footer.jsp"%>
	
	<!-- Bootstrap core JS-->
<!-- 	<script>
	var mql = window.matchMedia("screen and (max-width: 768px)");

	if (mql.matches) {
		$('#navbar-brand').html();
		console.log("화면의 너비가 768px 보다 작습니다.");
	} else {
	    console.log("화면의 너비가 768px 보다 큽니다.");
	}
	</script> -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/federico/resources/js/scripts.js"></script>
</body>
</html>

