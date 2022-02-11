<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
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
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
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

.my.pagination > .active > a, 
.my.pagination > .active > span, 
.my.pagination > .active > a:hover, 
.my.pagination > .active > span:hover, 
.my.pagination > .active > a:focus, 
.my.pagination > .active > span:focus {
  background: crimson;
  border-color: crimson;
}
tbody tr {
    cursor: pointer;
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
					<h1 class="display-6">마이페이지</h1>
				</div>
				<div class="col-md-3"></div>
			</div>
			<div class="row justify-content-md-center" style="height: 50px;">
				<div id="orderList" class="col-sm-4 checked" align="center"
					style="font-size: large; color: black; border-bottom: 2px solid black; cursor: pointer;"
					onclick="clickEffect('orderList'); showinfoDiv('myOrderList')">
					주문내역</div>
				<div id="infoUp" class="col-sm-4 checked" align="center"
					style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
					onclick="clickEffect('infoUp');  showinfoDiv('myInfoUp')">정보수정</div>
				<div id="deleteClient" class="col-sm-4 checked" align="center"
					style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
					onclick="clickEffect('deleteClient'); showinfoDiv('deleteMyInfo')">회원탈퇴</div>
			</div>
			<!-- 컨텐츠 -->
			<div id="content">
				<div id="myOrderList" class="container myinfo"
					style="display: block;">
					<div class="row justify-content-md-center mt-1 py-5">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<div class="dataTable-top"></div>
							<div class="row mb-3">
								<div class="col lead px-3" style="font-size: medium;">
									검색결과 <b style="color: crimson;">${pageMaker.totalRowCount}</b>개
								</div>
							</div>
							<div class="dataTable-container"
								style="font-size: medium; border-top: 1px solid black;">
								<table id="table_id" class="table table-striped table-hover">
									<thead>
										<tr align="center"
											style="height: 50px; vertical-align: middle;">
											<th scope="col" style="width: 100px;">주문번호</th>
											<th scope="col" style="width: 200px;">주소</th>
											<th scope="col" style="width: 100px;">가맹점</th>
											<th scope="col" style="width: 200px;">주문날짜</th>
											<th scope="col" style="width: 200px;">결제금액</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${! empty message }">
											<tr>
												<td colspan="6" class="fw-bold fs-5">${message}</td>
											</tr>
										</c:if>
										<c:forEach var="list" items="${orderList}">
											<tr onclick="orderDetail(${list.orderNumber})"
												style="vertical-align: middle; height: 50px;">
												<td align="center">${list.orderNumber}</td>
												<td align="center">${list.clientAddress}</td>
												<td align="center">${list.fcId}</td>
												<td align="center">${list.orderDate}</td>
												<fmt:formatNumber value="${list.price}" pattern="#,###"
													var="price" />
												<td align="center">${price}원</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="dataTable-bottom">
								<nav class="dataTable-pagination">
									<ul class="pagination my">
										<c:if test="${pageMaker.prev}">
											<li class="page-item"><a class="page-link"
												href="clientMyInfo${pageMaker.searchQuery(pageMaker.spageNo-1)}"
												aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
											</a></li>
										</c:if>
										<c:if test="${! pageMaker.prev}">
											<li class="page-item disabled"><a class="page-link"
												aria-label="Previous"> <span aria-hidden=true>&laquo;</span>
											</a></li>
										</c:if>
										<c:forEach var="i" begin="${pageMaker.spageNo}"
											end="${pageMaker.epageNo}">
											<c:if test="${i==pageMaker.cri.currPage}">
												<li class="page-item active" aria-current="page"><a
													class="page-link">${i}</a></li>
											</c:if>
											<c:if test="${i!=pageMaker.cri.currPage}">
												<li class="page-item"><a
													href="clientMyInfo${pageMaker.searchQuery(i)}">${i}</a></li>
											</c:if>
										</c:forEach>
										<c:if test="${pageMaker.next}">
											<li class="page-item"><a class="page-link"
												href="clientMyInfo${pageMaker.searchQuery(pageMaker.epageNo+1)}"
												aria-label="Next"> <span aria-hidden="true">&raquo;</span>
											</a></li>
										</c:if>
										<c:if test="${! pageMaker.next}">
											<li class="page-item disabled"><a class="page-link"
												aria-label="Next"> <span aria-hidden="true">&raquo;</span>
											</a></li>
										</c:if>
									</ul>
								</nav>
							</div>
						</div>
					</div>
				</div>
				<div id="myInfoUp" class="container myinfo" style="display: none;">
					<div class="row mt-5 mb-2">
						<font style="font-size: x-large;"><b>비밀번호 확인</b></font><br>
						<p class="lead" style="color: gray; font-size: medium;">
							정보를 안전하게 보호하기 위해 <b style="color: crimson;">비밀번호를 다시 한 번 입력</b>해
							주세요.
						</p>
						<hr>
					</div>
					<div class="row justify-content-md-center mt-5 mb-5">
						<div class="col-6">
							<div class="row mb-5">
								<div class="col">
									<div class="form-floating">
										<input class="form-control" id="clientPassword"
											name="clientPassword" type="password"
											placeholder="clientPassword" /> <label for="clientPassword"
											style="font-size: large; color: gray;">비밀번호</label>
									</div>
								</div>
							</div>
							<div class="row mt-3" align="center">
								<div class="col">
									<button class="btn btn-danger" onclick="infoUp()"
										style="width: 40%; height: 60px; font-size: large;">확인</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="deleteMyInfo" class="container myinfo"
					style="display: none;">
					<div class="row mt-5">
						<p class="lead" style="color: gray; font-size: medium;">
							회원탈퇴 이후 <b style="color: crimson;">동일한 아이디로 재가입</b>이 불가합니다.
						</p>
						<hr>
					</div>
					<div class="row justify-content-md-center">
						<font style="font-size: x-large;">온라인서비스 이용이 만족스럽지 못하셨나요?</font><br>
						<p class="lead" style="color: gray; font-size: medium;">회원탈퇴
							사유를 선택해 주시면 서비스 개선을 통해 더욱 발전하는 페데리코가 되겠습니다.</p>
						<hr>
					</div>
					<div class="row justify-content-md-center mt-2 mb-2">
						<div class="btn-group mt-3 mb-5" role="group"
							aria-label="Basic radio toggle button group">
							<input type="radio" class="btn-check" name="btnradio" id="homepage" value="홈페이지 사용 불편" autocomplete="off" checked> 
							<label class="btn btn-outline-danger" for="homepage"  onchange="showETCbox()">홈페이지 사용 불편</label> 
							
							<input type="radio" class="btn-check" name="btnradio" id="service" value="서비스 불만족" autocomplete="off"> 
							<label class="btn btn-outline-danger" for="service" onchange="showETCbox()">서비스 불만족</label> 
							
							<input type="radio" class="btn-check" name="btnradio" id="infomation" value="필요한 정보의 부족" autocomplete="off"> 
							<label class="btn btn-outline-danger" for="infomation" onchange="showETCbox()">필요한 정보의 부족</label> 
							
							<input type="radio" class="btn-check" name="btnradio" id="product" value="제품 불만족" autocomplete="off"> 
							<label class="btn btn-outline-danger" for="product" onchange="showETCbox()">제품 불만족</label> 
							
							<input type="radio" class="btn-check" name="btnradio" id="etc" value="기타" autocomplete="off">
							<label class="btn btn-outline-danger" for="etc" onchange="showETCbox()">기타</label>
						</div>
						<hr>
					</div>
					<div class="row justify-content-md-center mt-2 mb-2">
						<button class="btn btn-danger" onclick="deleteClient()"
							style="width: 40%; height: 60px; font-size: large;">회원탈퇴</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- footer include -->
	<%--  <%@ include file="footer.jsp"%> --%>

	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/client_Script.js"></script>
</body>
</html>