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
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
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
	<nav class="navbar navbar-expand-lg navbar-light bg-danger">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="#!">FEDERICO PIZZA</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" id="navbarDropdown" href="#"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">피자</a>
						<ul class="dropdown-menu" aria-labelledby="navbarDropdown">
							<li><a class="dropdown-item" id="original">오리지널</a></li>
							<li><a class="dropdown-item">프리미엄</a></li>
						</ul></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#!">사이드</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#!">세트</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#!">이벤트</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#!">매장찾기</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#!">고객게시판</a></li>

				</ul>
				<div>로그인</div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<form class="d-flex">
					<button class="btn btn-outline-dark" type="submit">
						<i class="bi-cart-fill me-1"></i> Cart <span
							class="badge bg-dark text-white ms-1 rounded-pill">0</span>
					</button>
				</form>
			</div>
		</div>
	</nav>
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
	<section class="py-5 bg-danger" style="height:300px; z-index: 3; position: relative;">
		<div id="result">&nbsp;&nbsp;각 메뉴 화면 ajax로 불러오기</div>
	</section>
	<!-- Footer-->
	<footer class="py-5 bg-dark" style="z-index: 3; position: relative;">
		<div>
			<span style="color: white;">개인정보처리방침</span>&nbsp;&nbsp; <span
				style="color: white;">제공서비스약관</span>&nbsp;&nbsp; <span
				style="color: white;">이메일무단수집거부</span>&nbsp;&nbsp; <span
				style="color: white;">고객센터</span>&nbsp;&nbsp; <span
				style="color: white;">회사소개</span>&nbsp;&nbsp; <span
				style="color: white;"> 주문전화 0000-0000 온라인주문 문의 0000-0000 </span><br>
			<span style="color: white;">가맹문의</span>&nbsp;&nbsp; <span
				style="color: white;">가맹점 전용 페이지</span>&nbsp;&nbsp; <a
				href="headoffice/loginf"><span style="color: white;">본사
					전용 페이지</span></a>&nbsp;&nbsp;
		</div>
		<div>
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2021</p>
		</div>
	</footer>
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

