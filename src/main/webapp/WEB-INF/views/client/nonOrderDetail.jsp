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
	
	<c:if test="${not empty alert}">
	<script>
		alert('주문내역이 없습니다.');
		location.href='clientLoginf';
	</script>
	</c:if>
	
	<!-- Section-->
	<section class="container" style="height: auto; min-height: 100%; padding-bottom: 168px;">
		<!-- 본문 시작 -->
		<c:if test="${empty orderInfo}">
			<div class="container" style="width: 940px;">
				<div class="row justify-content-md-center mt-5">
					<div class="col-12" align="center">
						<span class="lead" style="font-size: xx-large;"><b>${orderInfo.clientName}</b>님의
							주문내역이 비어있습니다.</span>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty orderInfo}">
		<div class="container" style="width: 940px;">
			<div class="row justify-content-md-center mt-5">
				<div class="col-12" align="center">
					<span class="lead" style="font-size: xx-large;"><b>${orderInfo.clientName}</b>님의
						주문내역입니다.</span>
				</div>
			</div>
			<hr>
			<!-- 배송지,가맹점 정보 -->
			<div>
				<table class="table table-borderless">
					<tr>
						<th width="100px" class="font-monospace">고객명</th>
						<td>${orderInfo.clientName}</td>
					</tr>
					<tr>
						<th width="100px" class="font-monospace">연락처</th>
						<td>${orderInfo.clientPhone}</td>
					</tr>
					<tr>
						<th width="100px" class="font-monospace">주소</th>
						<td>${orderInfo.clientAddress}</td>
					</tr>
					<tr>
						<th width="100px" class="font-monospace">매장정보</th>
						<td>${orderInfo.fcId}</td>
					</tr>
					<tr>
						<th width="100px" class="font-monospace">주문번호</th>
						<td>${orderInfo.orderNumber}</td>
					</tr>
					<tr>
						<th width="100px" class="font-monospace">주문요청사항</th>
						<td>${orderInfo.memo}</td>
					</tr>
					<tr>
						<th width="100px" class="font-monospace">주문시간</th>
						<td>${orderInfo.orderDate}</td>
					</tr>
				</table>
			</div>
			<!-- 배송지,가맹점 정보 -->
			<hr>
			<!-- 주문정보 -->
			<div>
				<span class="fw-bold fs-6 mx-1 font-monospace">주문메뉴</span>
				<br>
				<div style="background-color: #f2f2f2; min-height: 300px;">
					<div class="container-fluid">
						<br>
						<!-- 메뉴헤더 -->
						<div class="row fw-bold fs-5 font-monospace" align="center">
							<div class="col-6">메뉴</div>
							<div class="col-2">수량</div>
							<div class="col-4" align="right" style="padding-right: 60px;">
								가격</div>
						</div>
						<!-- 메뉴헤더 -->
						<hr>
						<!-- 메뉴 본문 -->
						<c:forEach var="vo" items="${list}" varStatus="vs">
							<div class="row  fs-5" style="height: 100px;">
								<div class="col-6" id="menuName${vs.index}" align="left"
									style="padding-left: 50px; line-height: 100px;">${vo.menuVo.menuName}</div>
								<div class="col-2" align="center" style="line-height: 100px;">
									${vo.menuQty}</div>
								<div class="col-4" align="right"
									style="padding-right: 60px; line-height: 100px;">
									<fmt:formatNumber value="${vo.menuVo.menuPrice * vo.menuQty}" />
									원
								</div>
							</div>
							<hr>
							<!-- 메뉴 본문 -->
							<!-- 필요정보 숨기기 -->
							<c:set var="totalPrice"
								value="${totalPrice + (vo.menuVo.menuPrice * vo.menuQty) }" />
							<c:set var="totalQty" value="${totalQty + vo.menuQty}" />
							<c:if test="${vs.last}">
								<input type="hidden" id="save" value="${vs.index}"
									data-totalPrice=${totalPrice } data-totalQty=${totalQty }>
							</c:if>
						</c:forEach>
						<!-- 메뉴 푸터 -->
						<div class="row">
							<div class="col-6"></div>
							<div class="col-2" align="right">
								<div class="mb-1">총 주문금액</div>
								<div class="mb-1">배달비</div>
								<div class="my-3" style="height: 40px; line-height: 50px;">최종
									결제금액</div>
							</div>
							<div class="col-4" align="right" style="padding-right: 60px;">
								<div class="mb-1">
									<span style="font-size: 1.2rem"><fmt:formatNumber
											value="${totalPrice}" /></span><span>원</span>
								</div>
								<div class="mb-1">
									<span style="font-size: 1.2rem">3,000</span><span>원</span>
								</div>
								<div class="my-3" style="color: crimson; height: 40px;">
									<span class="fs-3 fw-bold"><fmt:formatNumber
											value="${totalPrice+3000}" /></span>원
								</div>
							</div>
						</div>
						<div class="row px-5">
							<div class="col-4 mb-4" align="left">
								<button class="btn btn-outline-danger" onclick="orderCancel(${orderInfo.orderNumber})">주문취소</button>
							</div>
						</div>
					</div>
				</div>
				<br>
				<br>
				<br>
			</div>
		</div>
		</c:if>
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

