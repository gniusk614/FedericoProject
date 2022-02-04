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
<!-- chart js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
<script>
$(function(){
	
	$.ajax({
		type: 'get',
		url: 'fcchartsevenday',
		success: function(data){
			if(data.success == 'success'){
				var chartLabel =[];
				var chartData =[];
				var chartColor = [];
				var borderColor = [];
				var chartID ="fcLastSevenDaysChart";
				
				
				var data = data.charData;
				$.each(data, function(index, element){
					chartLabel.push(element.chartLabel);
					chartData.push(element.chartCount);
					var strRGBA = 'rgba(154, 205, 50, 0.3)';
					var borderRGBA = 'rgb(50, 205, 89)';
					chartColor.push(strRGBA);
					borderColor.push(borderRGBA);
					
				}) //each
				
				new Chart(chartID, {
					type : 'horizontalBar',
					data : {
						labels : chartLabel,
						datasets : [ {
							label: '매출액',
							data : chartData,
							backgroundColor : chartColor,
							borderColor : borderColor,
							fill : false,
							borderWidth: 1
						} ]
					},
					options : {
						legend: {
								labels: {
										fontColor: 'Black'	
								}
						},
						title: {
								display: true,
								text: '주간 매출 현황',
								fontSize: 20,
								fontStyle: 'bold',
								fontColor: 'black'
						},
						scales: {
								yAxes:[{
										barPercentage:0.4,
										fontColor: 'black'
								}],
								xAxes: [{
										fontColor: 'black'
								}]
						}
					}
				});//그래프		
				
			} else {
				alert('통신장애가 발생했습니다.\n다시 시도해주세요.');
			}
		},
		error: function(){
			alert('통신장애가 발생했습니다.\n다시 시도해주세요.');
		}
	})//ajax
})//ready
</script>


</head>
<body>
<!-- navtop inlcud -->
<%@ include file="navtop.jsp" %>

<!-- layoutSidenav 시작 -->
<div id="layoutSidenav">
	<%@ include file="navside.jsp" %>
	<div id="layoutSidenav_content">
	<!-- 본문 시작 -->
		<div class="container-fluid" id="fcId" data-fcid=${fcId}>
			<!-- 메인화면 배송시간 설정 -->
			<div class="row my-1" style="height: 40px;" align="right">
				<div class="col-9" style="padding-right: 0px;">
				<span style="line-height: 2.5;">배달 소요시간 설정 : </span>
				</div>
				<div class="col-2">
					<div class="input-group mb-3">
					  <input type="text" class="form-control" id="deliveryTime" value="${deliveryTime}" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');">
					  <button class="btn btn-outline-success" type="button" id="deliveryTimeBtn" onclick="updateDeliveryTime()">변경</button>
					</div>	
				</div>
				<div class="col-1"></div>
			</div>
			<!-- 메인화면 주문현황 -->
			<div class="row m-1" style=" border: 1px solid lightgray; height: 400px; overflow: auto;">
				<div class="container-fluid" align="center">
					<div class="mt-1 mb-3">
						<span class="fs-3 fw-bold">주문 접수 현황</span>
					</div>
					<!-- 주문정보 나오는 테이블 -->
						<table class="table table-striped">
							<colgroup>
								<col style="width: 10%;">							
								<col style="width: 30%;">							
								<col style="width: 30%;">							
								<col style="width: 10%;">							
								<col style="width: 10%;">							
								<col style="width: 10%;">							
							</colgroup>
							<thead>
								<tr align="center">
									<th>주문번호</th>
									<th>배송지</th>
									<th>고객요청사항</th>
									<th>연락처</th>
									<th>상세보기</th>
									<th>주문일시</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${empty orderList}">
									<tr align="center"><th colspan="6"><span>미처리 주문정보가 없습니다.</span></th></tr>
								</c:if>								
								<c:forEach var="vo" items="${orderList}">

									<tr align="center">
										<td>${vo.orderNumber}</td>
										<td>${vo.clientAddress}</td>
										<td>${vo.memo}</td>
										<td>${fn:substring(vo.clientPhone,0,3)}-${fn:substring(vo.clientPhone,3,7)}-${fn:substring(vo.clientPhone,7,11)}</td>
										<td style="padding-top: 4px;">
											<span class="btn py-0" onclick="showOrderDetail(${vo.orderNumber}, '${vo.clientAddress}', '${vo.clientPhone}', '${vo.memo}')">
											<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" >
											  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
											</svg></span></td>																		
										<td>${vo.orderDate}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table><!-- 주문정보 나오는 테이블 -->
				</div>
			</div><!-- 메인화면 주문현황 -->
			
			<!-- 메인화면 하단 - 매출현황 등 -->
			<div class="row m-1" style=" border: 1px solid lightgray; height: 400px; overflow: auto;">
					<!-- 하단 좌측 -->
					<div class="col-6 fs-5" align="center">
						<div class="row m-1" style="height: 190px; border: 1px solid lightgray;">
							<div class="col-6">
								<br><span>전일 매출</span><br><b class="fs-2"><fmt:formatNumber value="${fcYesterdaySales}" pattern="#,###"/></b> 원
							</div>
							<div class="col-6">
								<br><span>당일 매출</span><br><b class="fs-2"><fmt:formatNumber value="${fcTodaySales}" pattern="#,###"/></b> 원<br>
							<fmt:parseNumber var="dailySalesRatio" value="${fcTodaySales/fcYesterdaySales * 100}" integerOnly="true" />	
							<c:if test="${dailySalesRatio>=100}">
								<span style="color: blue;">(+ ${dailySalesRatio-100}%)</span>
							</c:if>
							<c:if test="${dailySalesRatio<100}">
								<span style="color: red;">(- ${100-dailySalesRatio}%)</span>
							</c:if>	
							</div>
						</div>
						<div class="row m-1" style="height: 190px; border: 1px solid lightgray;">
							<div class="col-6">
								<br><span>당월 매출</span><br><b class="fs-2"><fmt:formatNumber value="${fcThisMonthSales}" pattern="#,###"/></b> 원<br>
								<c:if test="${fcLastMonthSales != 0}">
									<fmt:parseNumber var="monthlySalesRatio" value="${fcThisMonthSales/fcLastMonthSales * 100}" integerOnly="true" />
									<c:if test="${monthlySalesRatio>=100}">
										<span style="color: blue;">(+ ${monthlySalesRatio-100}%)</span>
									</c:if>
									<c:if test="${monthlySalesRatio<100}">
										<span style="color: red;">(- ${100-monthlySalesRatio}%)</span>
									</c:if>									
								</c:if>		
								<c:if test="${fcLastMonthSales == 0}">
									<span style="color: red;">( - )</span>
								</c:if>

							</div>
							<div class="col-6">
								<br><span>당월 발주금액</span><br><b class="fs-2"><fmt:formatNumber value="${fcThisMonthOrderSum}" pattern="#,###"/></b> 원
							</div>
						</div>
					</div>
					<!-- 하단 우측 -->
					<div class="col-6">
							<div class="container-fluid px-4">
								<canvas id="fcLastSevenDaysChart" class="chartCanvas" ></canvas>
							</div>
					</div>
			</div>
		
		
		
		
			<!-- 주문상세정보 모달 -->
			<div class="modal fade " id="orderDetailModal" tabindex="-1">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">주문상세정보 - <span id="detailNumber"></span>번</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<!-- "modal-body" -->
						<div class="modal-body">
							<!-- table head -->
							<div class="row">
								<div class="col-8">
									<div class="mb-2">
										<span class="fw-bold">배송지</span><br>
										<span id="clientAdrress"></span>
									</div>
									<div>
										<span class="fw-bold">고객 요청사항</span><br>
										<span id="memo"></span>
									</div>
								</div>
								<div class="col-4">
									<span class="fw-bold">고객 연락처</span><br>
									<a href="#" style="text-decoration: none; color: black;">
										<span id="clientPhone" ></span>
									</a>
								</div>
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
										<button type="button" class="btn btn-secondary" onclick="hideOrderDetailModal()" >닫기</button>&nbsp;&nbsp;
										<button type="button" class="btn btn-primary" >인쇄</button>&nbsp;&nbsp;
										<button type="button" class="btn btn-danger" id="orderCompleteBtn">완료처리</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 주문상세정보 모달 -->
		
			<!-- 고객관리 등록 모달 -->
			<div class="modal fade " id="insertRegClientModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">단골,블랙고객 등록</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<!-- "modal-body" -->
						<div class="modal-body">
							<input type="checkbox" class="insertFlag" id="insertGood" value="G"><label for="insertGood" style="color: green;">단골</label> &nbsp;&nbsp;
							<input type="checkbox" class="insertFlag" id="insertBad" value="B"><label for="insertBad" style="color: red;">블랙리스트</label><br>
							<input type="text" class="input-group" id="insertRegClientMemo" placeholder="메모를 작성하세요.">							
						</div>
						<!-- modal-body -->
						<div class="modal-footer">
										<button type="button" class="btn btn-secondary" onclick="javascropt: $('#insertRegClientModal').modal('hide')" >닫기</button>&nbsp;&nbsp;
										<button type="button" class="btn btn-success"  onclick="insertRegClient()">등록</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 고객관리 등록 모달 -->		
		
			<!-- 고객관리 조회/수정/삭제 모달 -->
			<div class="modal fade " id="selectRegClientModal" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">단골,블랙고객 조회/수정/삭제</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<!-- "modal-body" -->
						<div class="modal-body selectFlagParent">
							<input type="checkbox" class="selectFlag" id="selectGood" value="G"><label for="selectGood" style="color: green;">단골</label> &nbsp;&nbsp;
							<input type="checkbox" class="selectFlag" id="selectBad" value="B"><label for="selectBad" style="color: red;">블랙리스트</label><br>
							<input type="text" class="input-group" id="selectRegClientMemo" value="">							
						</div>
						<!-- modal-body -->
						<div class="modal-footer">
										<button type="button" class="btn btn-secondary" onclick="javascropt: $('#selectRegClientModal').modal('hide')" >닫기</button>&nbsp;&nbsp;
										<button type="button" class="btn btn-danger"  onclick="deleteRegClient()">삭제</button>&nbsp;&nbsp;
										<button type="button" class="btn btn-success"  onclick="updateRegClient()">수정</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 고객관리 조회/수정/삭제 모달 -->
		
		
		
		
		</div> <!-- 본문 끝 -->
		
		<!-- footer inlcud -->
		<div><%@ include file="footer.jsp" %></div>





<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>