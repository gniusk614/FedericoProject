<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.8.js"></script>
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/federico/resources/css/styles.css" rel="stylesheet" />

<script>



</script>

</head>
<body>
	<!-- Navigation-->	
	<%@include file="nav.jsp"%>
	
	<!-- Section--> 
	<section class="container" style="height: auto; min-height: 100%; padding-bottom: 168px;">
	<!-- 본문 시작 -->
		<div class="container" style="width: 940px;">
			<br><div class="text-center"><h1 class="display-6">주문/결제</h1></div>
			<hr>
			<!-- 가맹점 선택 -->
			<span class="font-monospace fw-bold">&nbsp;가맹점 선택  :  </span>
			<select id="selectarea" class="form-select" style="width: 200px; display: inline;" onchange="selectArea()">
				<option value="default" selected>지역</option>
				<option value="서울">서울</option>
				<option value="경기">경기</option>
				<option value="인천">인천</option>
				<option value="대전">대전</option>
				<option value="부산">부산</option>
				<option value="대구">대구</option>
				<option value="울산">울산</option>
				<option value="세종">세종</option>
				<option value="광주">광주</option>
				<option value="강원">강원</option>
				<option value="충북">충북</option>
				<option value="충남">충남</option>
				<option value="경북">경북</option>
				<option value="경남">경남</option>
				<option value="전북">전북</option>
				<option value="전남">전남</option>
				<option value="제주">제주</option>
			
			</select>&nbsp;&nbsp;&nbsp;&nbsp;
			<select id="selectFranchise" class="form-select" style="width: 200px; display: inline;" onchange="selectFc()">
				<option>- - -</option>
			</select>				
			<hr>
			<!-- 배송지,가맹점 정보 -->
			<div>
				<table class="table table-borderless">
					<tr>
						<th width="100px" class="font-monospace">배달지정보</th>
						<td id="client_address">${clientAddress}</td>
					</tr>
					<tr>
						<th rowspan="2" class="font-monospace">매장정보</th>
						<td><span id="fcId"></span>&nbsp;<span id="fcPhone"></span></td>
					</tr>
					<tr>
						<td id="fcAddress"></td>
					</tr>
					<tr>
						<th class="font-monospace">배달료</th>
						<td>3000원</td>
					</tr>
				</table>
			</div><!-- 배송지,가맹점 정보 -->
			<hr><br>
			<!-- 주문정보 -->
			<div>
				<span class="fw-bold fs-6 mx-1 font-monospace">주문메뉴</span>
				<div class="" style="background-color: #f2f2f2; min-height: 500px;">
					<div class="container-fluid">
						<br>
						<!-- 메뉴헤더 -->
						<div class="row fw-bold fs-5 font-monospace" align="center">
							<div class="col-6">
								메뉴
							</div>
							<div class="col-2">
								수량
							</div>
							<div class="col-4" align="right" style="padding-right: 60px;">
								가격
							</div>
						</div>	<!-- 메뉴헤더 -->				
						<hr>
						<!-- 메뉴 본문 -->
						<c:forEach var="vo" items="${list}" varStatus="vs">
							<div  class="row  fs-5" style="height: 100px;">
								<div class="col-6" id="menuName${vs.index}" align="left" style="padding-left: 50px; line-height: 100px;">${vo.menuVo.menuName}</div>
								<div class="col-2" align="center" style="line-height: 100px;">
									${vo.menuQty}
								</div>
								<div class="col-4"  align="right" style="padding-right: 60px;  line-height: 100px;	">
									<fmt:formatNumber value="${vo.menuVo.menuPrice * vo.menuQty}"/>원
								</div>
							</div><hr><!-- 메뉴 본문 -->
							<!-- 필요정보 숨기기 -->
							<c:set var="totalPrice" value="${totalPrice + (vo.menuVo.menuPrice * vo.menuQty) }"/>
							<c:set var="totalQty" value="${totalQty + vo.menuQty}"/>
							<c:if test="${vs.last}">
							<input type="hidden" id="save" value="${vs.index}" data-totalPrice=${totalPrice} data-totalQty=${totalQty }>
							</c:if>
						</c:forEach>
						<!-- 메뉴 푸터 -->
						<div class="row">
							<div class="col-6"></div>
							<div class="col-2" align="right">
								<div class="mb-1">총 주문금액</div>
								<div class="mb-1">배달비</div>
								<div class="my-3" style="height: 40px; line-height: 50px;">최종 결제금액</div>
							</div>
							<div class="col-4" align="right" style="padding-right: 60px;">
								<div class="mb-1"><span style="font-size: 1.2rem"><fmt:formatNumber value="${totalPrice}"/></span><span>원</span></div>
								<div class="mb-1"><span style="font-size: 1.2rem">3,000</span><span>원</span></div>
								<div class="my-3" style="color: crimson; height: 40px;"><span class="fs-3 fw-bold"><fmt:formatNumber value="${totalPrice+3000}"/></span>원</div>
							</div>
						</div>
					</div>
				</div><br><hr><br>	
				<!-- 결제방식 고르기 -->
				<span class="fs-4">결제수단 선택</span><br>
					<div class="form-check form-check-inline mt-3">
					  <input class="form-check-input" type="radio" name="radioPay" id="radioCard" value="card">
					  <label class="form-check-label" for="radioCard">카드결제</label>
					</div>&nbsp;&nbsp;&nbsp;
					<div class="form-check form-check-inline mb-3">
					  <input class="form-check-input" type="radio" name="radioPay" id="radioKakao" value="kakao">
					  <label class="form-check-label" for="radioKakao">카카오페이</label>
					</div>					
				<!-- 주문자 정보 -->
				<br><hr><br>
				<span class="fs-4">주문자 정보</span>
				<hr>
				<div class="container" style="width: 800px;">
					<div id="client_Name">${clientName}</div>
					<hr>
					<div id="client_Phone">${fn:substring(clientPhone,0,3)}-${fn:substring(clientPhone,3,7)}-${fn:substring(clientPhone,7,11)}</div>
					<hr>
					<div class="input-group mb-3">
						<input type="text" id="clientMemo" class="form-control" size="80" placeholder="주문 시 요청사항 (40자 까지 입력가능)">
					</div>
				</div>
			</div>
			<hr><br>				
			<div class="mb-5" align="center">
				<button type="button" class="btn btn-danger" id="payBtn" onclick="alert('결제수단을 선택해주세요.')" style=" width: 250px;" disabled="disabled">
					결제 하기
				</button>
			</div>
			<!-- iam페이 용 데이터 숨기기 -->
			<form action="ordercomplete?iam=iam" method="post" id="iamForm">
				<input id="iamfcId" name="fcId" type="hidden" value="">
				<input id="iamMemo" name="memo" type="hidden" value="">
			</form>
			
			
			
			
			
		</div><!-- 본문 끝 -->
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

