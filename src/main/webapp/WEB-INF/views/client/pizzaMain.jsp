<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>페데리꼬 피자</title>
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<style>
@media (min-width: 992px) {
  #carouselExampleIndicators {
   height: 500px;
  }
}


</style>
</head>
<body>
	<!-- Navigation-->
	<%@include file="nav.jsp"%>
	
	
	<!-- Header-->
	<header class="bg-danger py-5">
			<div id="carouselExampleIndicators" class="carousel slide"
				data-bs-ride="carousel">
				<div class="carousel-indicators" style="z-index:3;">
					<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="0" class="active" aria-current="true"
						aria-label="Slide 1"></button>
					<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="1" aria-label="Slide 2"></button>
					<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="2" aria-label="Slide 3"></button>
				</div>
				<div class="carousel-inner" style="z-index: 1; position: relative;" >
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
	</header>
	<!-- Section-->
	<section class="py-5 bg-danger" style="height: 300px; z-index: 3; position: relative; margin-bottom: 168px;">
		<div id="result">&nbsp;&nbsp;각 메뉴 화면 ajax로 불러오기</div>
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

