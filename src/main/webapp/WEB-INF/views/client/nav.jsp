<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-danger">
		<div class="container px-4 px-lg-5">
			<a class="navbar-brand" href="home">FEDERICO PIZZA</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="menuList?menuFlag=pizza">피자</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="menuList?menuFlag=sets">세트</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="menuList?menuFlag=side">사이드</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#!">이벤트</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#!">매장찾기</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#!">고객게시판</a></li>

				</ul>
				<div>로그인</div>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<button class="btn btn-outline-dark" onclick="location.href='cart'">
						<i class="bi-cart-fill me-1"></i> Cart 
						<span id="cartNumber" class="badge bg-dark text-white ms-1 rounded-pill">0</span>
					</button>
			</div>
		</div>
	</nav>
</body>
</html>