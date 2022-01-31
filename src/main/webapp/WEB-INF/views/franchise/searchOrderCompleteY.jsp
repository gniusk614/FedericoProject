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
<!-- calendar 관련 cdn -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />

<script>
//Search 이벤트 -> makequery 메서드 사용하기위해 jsp파일에 배치
$(function() {	
	// SearchType 이 '---' 면 keyword 클리어
	$('#searchType').change(function() {
		if ($(this).val()=='n') $('#keyword').val('');
	}); //change
	// 검색후 요청
 	$('#searchBtn').on("click", function() {
		self.location="completeorder"
			+"${pageMaker.makeQuery(1)}"
			+"&searchType="
			+$('#completeOrderSearchType').val()
			+'&keyword='
			+$('#keyword').val()
			// 기간검색용 쿼리스트링
			+'&minDate='
			+$('#minDate').val()
			+'&maxDate='
			+$('#maxDate').val()
	}); //on_click 
}) //ready
</script>
</style>
</head>
<body>
<!-- navtop inlcud -->
<%@ include file="navtop.jsp" %>

<!-- layoutSidenav 시작 -->
<div id="layoutSidenav">
	<%@ include file="navside.jsp" %>
	<div id="layoutSidenav_content">
<!-- 본문 시작 -->
		<div class="container-fluid px-4" style="margin-top: 20px;">
			<div class="card">
				<div class="card-header">
					<h4><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-collection" viewBox="0 0 16 16">
					  <path d="M2.5 3.5a.5.5 0 0 1 0-1h11a.5.5 0 0 1 0 1h-11zm2-2a.5.5 0 0 1 0-1h7a.5.5 0 0 1 0 1h-7zM0 13a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 16 13V6a1.5 1.5 0 0 0-1.5-1.5h-13A1.5 1.5 0 0 0 0 6v7zm1.5.5A.5.5 0 0 1 1 13V6a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5h-13z"/>
					</svg>
				완료 주문내역</h4>
				</div>
				<div class="card-body">
					<div class="dataTable-top">
						<div class="container-fluid">
							<div class="row">
								<div class="col-sm-2">
									<select id="completeOrderSearchType" class="form-select" onchange="completeOrderSearchChange()">
										<option value="none" <c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/>> - - </option>
										<option value="orderNumber" <c:out value="${pageMaker.cri.searchType=='orderNumber' ? 'selected':''}"/>>주문번호</option>
										<option value="orderDate" <c:out value="${pageMaker.cri.searchType=='orderDate' ? 'selected':''}"/>>기 &nbsp;간</option>
									</select>
								</div>
							
								<c:if test="${pageMaker.cri.searchType!='orderDate'}">
									<div class="col-sm-2" id="searchInput">
										<input class="form-control me-2" type="search" id="keyword"
											placeholder="Search" value="${pageMaker.cri.keyword}" aria-label="Search">
									</div>
									
									<div class="col-sm-5" id="datePicker" style="display: none;">
										<div class="row">
											<div class="input-group date col" id="datetimepicker1" data-target-input="nearest"> 
												<input id="minDate" type="text" class="form-control datetimepicker-input" data-target="#datetimepicker1" value="" > 
												<div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker"> 
													<div class="input-group-text">
														<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-calendar" viewBox="0 0 16 16">
														  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
														</svg>														
													</div> 
												</div> 
											</div> 
										
											<div class="input-group date col" id="datetimepicker2" data-target-input="nearest"> 
												<input id="maxDate" type="text" class="form-control datetimepicker-input" data-target="#datetimepicker2" value="" > 
												<div class="input-group-append" data-target="#datetimepicker2" data-toggle="datetimepicker"> 
													<div class="input-group-text">
														<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
														  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
														  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
														</svg>														
													</div> 
												</div> 
											</div>
										</div>
									</div>
								</c:if>
							
										
										
								<c:if test="${pageMaker.cri.searchType=='orderDate'}">
									<div class="col-sm-2" id="searchInput" style="display: none;">
										<input class="form-control me-2" type="search" id="keyword"
											placeholder="Search" value="${pageMaker.cri.keyword}" aria-label="Search" >
									</div>
									<div class="col-sm-5" id="datePicker">
										<div class="row">
											<div class="input-group date col" id="datetimepicker1" data-target-input="nearest"> 
												<input id="minDate" type="text" class="form-control datetimepicker-input" data-target="#datetimepicker1" value="${minDate}" > 
												<div class="input-group-append" data-target="#datetimepicker1" data-toggle="datetimepicker"> 
													<div class="input-group-text">
														<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-calendar" viewBox="0 0 16 16">
														  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
														</svg>	
													</div> 
												</div> 
											</div> 
										
											<div class="input-group date col" id="datetimepicker2" data-target-input="nearest"> 
												<input id="maxDate" type="text" class="form-control datetimepicker-input" data-target="#datetimepicker2" value="${maxDate}" > 
												<div class="input-group-append" data-target="#datetimepicker2" data-toggle="datetimepicker"> 
													<div class="input-group-text">
														<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
														  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
														  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
														</svg>	
													</div> 
												</div> 
											</div>
										</div>
								</div>									
								</c:if>
								
								
								
								
								<div class="col-sm-2">
									<button id="searchBtn" class="btn btn-outline-primary">검색</button>
								</div>
								<c:if test="${pageMaker.cri.searchType!='orderDate'}">
									<div class="col-sm-6" id="divPlace"></div>
								</c:if>
								<c:if test="${pageMaker.cri.searchType=='orderDate'}">
										<div class="col-sm-3" id="divPlace"></div>
								
								</c:if>
							</div>								
						</div>
					</div>
				</div>
				<!-- table -->
				<table class="table table-striped table-hover">
					<thead align="center">
						<tr>
								<th style="width: 10%">주문번호</th>
								<th style="width: 30%">배송지</th>
								<th style="width: 30%">고객요청사항</th>
								<th style="width: 10%">연락처</th>
								<th style="width: 10%">상세보기</th>
								<th style="width: 10%">주문일시</th>
						</tr>
					</thead>
						<tbody>
							<c:if test="${empty completeList}">
								<tr align="center"><th colspan="6"><span>완료 주문정보가 없습니다.</span></th></tr>
							</c:if>								
							<c:forEach var="vo" items="${completeList}">

								<tr align="center">
									<td style="width: 10%">${vo.orderNumber}</td>
									<td style="width: 30%">${vo.clientAddress}</td>
									<td style="width: 30%">${vo.memo}</td>
									<td style="width: 10%">${fn:substring(vo.clientPhone,0,3)}-${fn:substring(vo.clientPhone,3,7)}-${fn:substring(vo.clientPhone,7,11)}</td>
									<td style="width: 10%; padding-top: 4px;">
										<span class="btn py-0" onclick="showOrderDetail(${vo.orderNumber},'${vo.clientAddress}', '${vo.clientPhone}', '${vo.memo}')" >
										<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" >
										  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
										</svg></span></td>																		
									<td style="width: 10%">${vo.orderDate}</td>
								</tr>
							</c:forEach>
						</tbody><!-- 완료 주문정보 나오는 테이블 -->
				</table>
		<!-- tabel bottom -->				
				<div class="dataTable-bottom">
					<nav class="dataTable-pagination">
						<ul class="pagination">
							<c:if test="${pageMaker.prev}">
								<li class="page-item"><a class="page-link" href="completeorder${pageMaker.searchQuery(pageMaker.spageNo-1)}"
									aria-label="Previous"> <span aria-hidden=true>&laquo;</span>
								</a></li>
							</c:if>	
							<c:if test="${! pageMaker.prev}">
								<li class="page-item disabled"><a class="page-link"
									aria-label="Previous"> <span aria-hidden=true>&laquo;</span>
								</a></li>
							</c:if>	
								<c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
									<c:if test="${i==pageMaker.cri.currPage}">
									<li class="page-item active" aria-current="page"><a class="page-link">${i}</a></li>
									</c:if>
									<c:if test="${i!=pageMaker.cri.currPage}">
									<li class="page-item"><a href="completeorder${pageMaker.searchQuery(i)}">${i}</a></li>
									</c:if>
								</c:forEach>
								
								
								<c:if test="${pageMaker.next}">
									<li class="page-item"><a class="page-link" href="completeorder${pageMaker.searchQuery(pageMaker.epageNo+1)}" 
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
	<!-- 완료주문상세정보 모달 -->
	<div class="modal fade " id="orderDetailModal" tabindex="-1">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">주문상세정보 - <span id="detailNumber"></span>번  -  완료</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<!-- "modal-body" -->
				<div class="modal-body">
					<!-- table head -->
					<div class="mb-2">
						<span class="fw-bold">배송지</span><br>
						<span id="clientAdrress"></span>
					</div>
					<div>
						<span class="fw-bold">고객 요청사항</span><br>
						<span id="memo"></span>
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
								<button type="button" class="btn btn-secondary" onclick="hideOrderDetailModal()">닫기</button>&nbsp;&nbsp;
								<button type="button" class="btn btn-primary" >인쇄</button>&nbsp;&nbsp;
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 완료주문상세정보 모달 -->		
		
		
		
		
		<!-- footer inlcud -->
		<div><%@ include file="footer.jsp" %></div>
	</div> <!-- 본문 끝 -->
</div> <!-- layoutSidenav 끝 -->			



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>