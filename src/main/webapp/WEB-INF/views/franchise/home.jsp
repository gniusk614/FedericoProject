<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페데리꼬 피자</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/franchise_Script.js"></script>
</head>
<body>
<!-- navtop inlcud -->
<%@ include file="navtop.jsp" %>

<!-- layoutSidenav 시작 -->
<div id="layoutSidenav">
	<%@ include file="navside.jsp" %>
	<div id="layoutSidenav_content">
	<!-- 본문 시작 -->
		<div class="container-fluid">
			<!-- 메인화면 배송시간 설정 -->
			<div class="row my-1" style="height: 30px;" align="right">
				<div class="col-10" style="background-color: tan; height: 30px;"></div>
				<div class="col-2" style="background-color: green; height: 30px;">
					<div class="input-group mb-3">
					  <input type="text" class="form-control" placeholder="Recipient's username" aria-label="Recipient's username" aria-describedby="button-addon2">
					  <button class="btn btn-outline-secondary" type="button" id="button-addon2">Button</button>
					</div>				
				</div>
			</div>
			<!-- 메인화면 주문현황 -->
			<div class="row m-1" style=" border: 1px solid lightgray; height: 400px; overflow: auto;">
				<div class="container-fluid" align="center">
					<div class="mt-1 mb-3">
						<span class="fs-3 fw-bold">주문 접수 현황</span>
					</div>
					<!-- 주문정보 나오는 테이블 -->
						<table class="table table-striped">
							<thead>
								<tr align="center">
									<th style="width: 10%">주문번호</th>
									<th style="width: 30%">배송지</th>
									<th style="width: 30%">고객요청사항</th>
									<th style="width: 10%">연락처</th>
									<th style="width: 10%">상세보기</th>
									<th style="width: 10%">주문일시</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty orderList}">
									<tr><th colspan="6"><span>미처리 주문정보가 없습니다.</span></th></tr>
								</c:if>								
								<c:forEach var="vo" items="${orderList}">

									<tr align="center">
										<td style="width: 10%">${vo.orderNumber}</td>
										<td style="width: 30%">${vo.clientAddress}</td>
										<td style="width: 30%">${vo.memo}</td>
										<td style="width: 10%">${fn:substring(vo.clientPhone,0,3)}-${fn:substring(vo.clientPhone,3,7)}-${fn:substring(vo.clientPhone,7,10)}</td>
										<td style="width: 10%; padding-top: 4px;">
											<span class="btn py-0" onclick="showOrderDetail(${vo.orderNumber})"><svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-search" 
											viewBox="0 0 16 16" >
											  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
											</svg></span></td>																		
										<td style="width: 10%">${vo.orderDate}</td>
									</tr>
								</c:forEach>
								
								
								
							</tbody>
						</table><!-- 주문정보 나오는 테이블 -->
				</div>
			</div><!-- 메인화면 주문현황 -->
		
			<!-- 주문상세정보 모달 -->
			<div class="modal fade " id="orderDetailModal" tabindex="-1">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">주문상세정보 - <span id="detailNumber">1</span>번</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<!-- "modal-body" -->
						<div class="modal-body">
							<!-- table head -->
							<div>
								<span>고객 요청사항</span><br>
								<span id="memo">이이이</span>
							</div>
							<hr>
							<table class="table">
								<thead><tr align="center">
									<th width="15%">주문상세번호</th>
									<th width="37%">메 뉴</th>
									<th width="13%">수 량</th>
									<th width="15%">단 가 </th>
									<th width="20%">금 액</th>
								</tr></thead>
							<!-- table body -->
								<tbody id="orderDetailBody" align="center">
									<!-- ajax 처리 -->
								</tbody>
								<tfoot><tr align="right">
									<th colspan="7" style="font-weight: bold;">
									<span  id="orderDetailFooter"></span> 원</th>
								</tr></tfoot>
							
							</table>
						</div>
						<!-- modal-body -->
						<div class="modal-footer">
										<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>&nbsp;&nbsp;
										<button type="button" class="btn btn-danger" id="">완료처리</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 주문상세정보 모달 -->
		
		
		
		
		</div> <!-- 본문 끝 -->
		
		<!-- footer inlcud -->
		<div><%@ include file="footer.jsp" %></div>
	</div> 
</div> <!-- layoutSidenav 끝 -->			





<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>