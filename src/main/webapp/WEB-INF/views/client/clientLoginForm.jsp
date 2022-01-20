<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>페데리꼬 피자</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/inCheck.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>

<style>
.checked {
	border-bottom: 2px solid black;
	color: black;
}

.checked .a {
	font-size: large;
	color: gray;
}
</style>
</head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<body>


	<!-- Navigation-->
	<%@include file="nav.jsp"%>
	<!-- 본문 시작 -->
	<section class="container py-5"
		style="height: auto; min-height: 100%; padding-bottom: 168px;">
		<div class="container-fluid">
			<div class="row mb-5">
				<div class="col-md-3"></div>
				<div class="col-md-6" align="center">
					<h1 class="display-6">로그인</h1>
				</div>
				<div class="col-md-3"></div>
			</div>
			<div class="row justify-content-md-center" style="height: 50px;">
				<div id="clientLogin" class="col-sm-3 checked" align="center"
					style="font-size: large; color: black; border-bottom: 2px solid black; cursor: pointer;"
					onclick="clickEffect('clientLogin'); showdiv('clientLogin');">
					회원로그인</div>
				<div id="nonOrder" class="col-sm-3 checked" align="center"
					style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
					onclick="clickEffect('nonOrder'); showdiv('nonOrder');">
					비회원주문</div>
				<div id="nonOrderCheck" class="col-sm-3 checked" align="center"
					style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
					onclick="clickEffect('nonOrderCheck'); showdiv('nonOrderCheck');">
					비회원주문조회</div>
			</div>
			<div id="content">
				<div id="outer_1" class="container" style="display: block;">
					<div class="row justify-content-md-center mt-5 mb-5"
						style="font-size: x-large;">
						<div class="col-md-3" align="center">
							<div id="innerTitle">
								페데리코를 즐기기 위해<br> <span style="color: Crimson;">로그인</span>을
								해주세요 :)
							</div>
						</div>
						<div class="col-md-2" align="center"></div>
						<div class="col-md-3" align="center">
							<div>
								페데리코의 가족이 되시면<br> 특별한 혜택을 드립니다.
							</div>
						</div>
						<div class="row justify-content-md-center" style="height: 400px;">
							<div id="innerContent" class="col-md-3">
								<div id="inner_1" style="display: block;">
									<div align="center">
										<form action="clientLogin" method="post">
											<div class="row justify-content-md-center mt-5"
												style="height: 200px;">
												<div class="col">
													<div class="form-floating mb-3">
														<input class="form-control" type="text" id="clientId"
															name="clientId" placeholder="clientId" /> <label
															for="clientId" style="font-size: large; color: gray;">아이디</label>
													</div>
													<div class="form-floating mb-3">
														<input class="form-control" id="clientPassword"
															name="clientPassword" type="password"
															placeholder="clientPassword" /> <label
															for="clientPassword"
															style="font-size: large; color: gray;">비밀번호</label>
													</div>
													<div style="font-size: small; color: red;">
														<c:if test="${not empty message}">${message}</c:if>
													</div>
													<div class="row">
														<div class="col" align="right">
															<a class="small" href="passwordReset"
																style="font-size: medium;">아이디/비밀번호 찾기</a>
														</div>
													</div>

												</div>
											</div>
											<div class="row" style="height: 100px;">
												<div
													class="d-flex align-items-center justify-content-between mb-0">
													<button class="btn btn-danger" type="submit"
														style="width: 100%; height: 60px; font-size: large;">로그인</button>
												</div>
											</div>
										</form>
									</div>
								</div>
								<!-- 바뀔내용(비회원주문) -->
								<div id="inner_2" style="display: none;">
									<div class="col-md-3" align="center">야호</div>
								</div>
							</div>
							<div class="col-md-1" align="center"
								style="border-right: 1px dashed gray;"></div>
							<div class="col-md-1" align="center"></div>
							<div class="col-md-3" align="center">
								<div class="row justify-content-md-center mt-5"
									style="height: 200px;">
									<header class="mt-5 mb-5">
										<div id="carouselExampleIndicators" class="carousel slide"
											data-bs-ride="carousel">
											<div class="carousel-inner">
												<div class="carousel-item active">
													<img src="/federico/resources/Image/tmp6AE0.jpeg"
														class="d-block w-100" alt="...">
												</div>
												<div class="carousel-item">
													<img src="/federico/resources/Image/tmpBBB9.jpeg"
														class="d-block w-100" alt="...">
												</div>
											</div>
											<button class="carousel-control-prev" type="button"
												data-bs-target="#carouselExampleIndicators"
												data-bs-slide="prev">
												<span class="carousel-control-prev-icon" aria-hidden="true"></span>
												<span class="visually-hidden">Previous</span>
											</button>
											<button class="carousel-control-next" type="button"
												data-bs-target="#carouselExampleIndicators"
												data-bs-slide="next">
												<span class="carousel-control-next-icon" aria-hidden="true"></span>
												<span class="visually-hidden">Next</span>
											</button>
										</div>
									</header>
								</div>
								<div class="row" style="height: 100px;">
									<div
										class="d-flex align-items-center justify-content-between mb-0">
										<button class="btn btn-outline-danger" type="submit"
											style="width: 100%; height: 60px; font-size: large;">회원가입</button>
									</div>
								</div>
							</div>



						</div>
					</div>
				</div>
				<div id="outer_2" class="container" style="display: none;">
					<div class="row justify-content-md-center mt-5 mb-5"
						style="font-size: x-large;">서어어어엉공?</div>
				</div>
			</div>
		</div>
	</section>
	<!-- footer inlcud -->
	<%@ include file="footer.jsp"%>


	
	
	
	



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/client_Script.js"></script>
</body>
</html>