<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style >
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
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-danger">
		<div class="container px-4 px-lg-5">
			<a href="home"><img src="/federico/resources/Image/tLogo.png" style="width:170px;"></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="menuList?menuFlag=pizza">피자&nbsp;&nbsp;</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="menuList?menuFlag=sets">세트&nbsp;&nbsp;</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="menuList?menuFlag=side">사이드&nbsp;&nbsp;</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="csEventf?flag=doing">이벤트&nbsp;&nbsp;</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="fcSearch">매장찾기&nbsp;&nbsp;</a></li>
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="cscenterf">고객센터&nbsp;&nbsp;</a></li>
				</ul>
				
					<c:if test="${empty clientLoginID}">
						<div>
							<a href="clientJoinf" style="color:white;">회원가입</a>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
						<div>
							<a href="clientLoginf" style="color:white;">로그인</a>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</c:if>				
					<c:if test="${not empty clientLoginID}">
						<div>
							<a href="clientMyInfo" style="color:white;">마이페이지</a>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
						<div>
							<a href="clientLogout" style="color:white;">로그아웃</a>&nbsp;&nbsp;&nbsp;&nbsp;
						</div>
					</c:if>				
					<c:if test="${empty clientLoginID}">
						<button class="btn btn-light" onclick="location.href='cart?m=n'">
						<i class="bi-cart-fill me-1"></i> Cart 
						<c:if test="${empty listSize}">
							<span id="listSize" class="badge bg-black text-white ms-1 rounded-pill">0</span>
						</c:if>
						<c:if test="${! empty listSize}">
							<span id="listSize" class="badge bg-black text-white ms-1 rounded-pill">${listSize}</span>
						</c:if>
						</button>
					</c:if>
					<c:if test="${! empty clientLoginID}">
					<button id="clientloginId" class="btn btn-light" onclick="location.href='cart?m=y'" data-clientloginid=${clientLoginID}>
						<i class="bi-cart-fill me-1"></i> Cart 
						<c:if test="${empty listSize}">
							<span id="listSize" class="badge bg-black text-white ms-1 rounded-pill">0</span>
						</c:if>
						<c:if test="${! empty listSize}">
							<span id="listSize" class="badge bg-black text-white ms-1 rounded-pill">${listSize}</span>
						</c:if>
					</button>
					</c:if>
			</div>
		</div>
	</nav>
	
	
</body>
</html>