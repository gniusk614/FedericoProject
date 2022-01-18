<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-danger mb-5">
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
</body>
</html>