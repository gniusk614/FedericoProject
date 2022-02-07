<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<script>
//Search 이벤트 -> makequery 메서드 사용하기위해 jsp파일에 배치
$(function() {	
	// SearchType 이 '---' 면 keyword 클리어
	$('#searchType').change(function() {
		if ($(this).val()=='n') $('#keyword').val('');
	}); //change
	// 검색후 요청
 	$('#searchBtn').on("click", function() {
		self.location="selectfcorder"
			+"${pageMaker.makeQuery(1)}"
			+"&searchType="
			+$('#completeOrderSearchType').val()
			+'&keyword='
			+$('#keyword').val()
			+'&fcOrderFlag='
			+$('#flag').val()
			+'&minDate='
			+$('#minDate').val()
			+'&maxDate='
			+$('#maxDate').val()
	}); //on_click 
	
	
}) //ready


function move(){
	self.location="selectfcorder"
		+"${pageMaker.makeQuery(1)}"
		+"&searchType="
		+$('#completeOrderSearchType').val()
		+'&keyword='
		+$('#keyword').val()
		+'&fcOrderFlag='
		+$('#flag').val()
		+'&minDate='
		+$('#minDate').val()
		+'&maxDate='
		+$('#maxDate').val()
}
</script>
<style type="text/css">
.selecteD {
	font-weight: bold; color: green; text-decoration: none; font-size: 1.1rem;
}

.notSelecteD {
	font-weight: normal; color: black; text-decoration: none; font-size: 1rem;
}

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
				자재 발주내역 조회</h4>
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
								<c:if test="${pageMaker.cri.searchType=='orderDate'}">
									<div class="col-sm-3" id="flagYN" align="right">
										<c:if test="${flaG == '' || flaG == null}">
										<input type="hidden" id="flag">
										<a href="#" class="selecteD" onclick="selectALLYN('A')"> 
											<span id="flagA"  >전체</span>
										</a>&nbsp; 
										<a href="#" class="notSelecteD" onclick="selectALLYN('N')">
											<span id="flagN">미확인</span>
										</a>&nbsp; 
										<a href="#" class="notSelecteD" onclick="selectALLYN('Y')">
											<span id="flagY">확인완료</span>
										</a>&nbsp;
										</c:if>
										
										<c:if test="${flaG == 'N'}">
										<input type="hidden" id="flag" value="N">
										<a href="#" class="notSelecteD" onclick="selectALLYN('A')"> 
											<span id="flagA">전체</span>
										</a>&nbsp; 
										<a href="#" class="selecteD" onclick="selectALLYN('N')">
											<span id="flagN">미확인</span>
										</a>&nbsp; 
										<a href="#" class="notSelecteD" onclick="selectALLYN('Y')">
											<span id="flagY">확인완료</span>
										</a>&nbsp;											
										</c:if>
										
										<c:if test="${flaG == 'Y'}">
										<input type="hidden" id="flag" value="Y">
										<a href="#" class="notSelecteD" onclick="selectALLYN('A')"> 
											<span id="flagA">전체</span>
										</a>&nbsp; 
										<a href="#" class="notSelecteD" onclick="selectALLYN('N')">
											<span id="flagN">미확인</span>
										</a>&nbsp; 
										<a href="#" class="selecteD" onclick="selectALLYN('Y')">
											<span id="flagY">확인완료</span>
										</a>&nbsp;																		
										</c:if>
									</div>	
								</c:if>
								<c:if test="${pageMaker.cri.searchType!='orderDate'}">
									<div class="col-sm-6" id="flagYN" align="right">
										<c:if test="${flaG == '' || flaG == null}">
										<input type="hidden" id="flag">
										<a href="#" class="selecteD" onclick="selectALLYN('A')"> 
											<span id="flagA"  >전체</span>
										</a>&nbsp; 
										<a href="#" class="notSelecteD" onclick="selectALLYN('N')">
											<span id="flagN">미확인</span>
										</a>&nbsp; 
										<a href="#" class="notSelecteD" onclick="selectALLYN('Y')">
											<span id="flagY">확인완료</span>
										</a>&nbsp;
										</c:if>
										
										<c:if test="${flaG == 'N'}">
										<input type="hidden" id="flag" value="N">
										<a href="#" class="notSelecteD" onclick="selectALLYN('A')"> 
											<span id="flagA">전체</span>
										</a>&nbsp; 
										<a href="#" class="selecteD" onclick="selectALLYN('N')">
											<span id="flagN">미확인</span>
										</a>&nbsp; 
										<a href="#" class="notSelecteD" onclick="selectALLYN('Y')">
											<span id="flagY">확인완료</span>
										</a>&nbsp;											
										</c:if>
										
										<c:if test="${flaG == 'Y'}">
										<input type="hidden" id="flag" value="Y">
										<a href="#" class="notSelecteD" onclick="selectALLYN('A')"> 
											<span id="flagA">전체</span>
										</a>&nbsp; 
										<a href="#" class="notSelecteD" onclick="selectALLYN('N')">
											<span id="flagN">미확인</span>
										</a>&nbsp; 
										<a href="#" class="selecteD" onclick="selectALLYN('Y')">
											<span id="flagY">확인완료</span>
										</a>&nbsp;																		
										</c:if>
									</div>	
								</c:if>								
							</div>		
						</div>
					</div>
					<!-- table -->
					<table id="t_itemselect" class="table table-striped table-hover">
						<thead align="center">
							<tr>
								<th scope="col" width="10%">발주번호</th>
								<th scope="col" width="30%">발주일</th>
								<th scope="col" width="20%">발주금액</th>
								<th scope="col" width="25%">상세내역</th>
								<th scope="col" width="15%">본사확인</th>
							</tr>
						</thead>
						<tbody align="center">
							<c:if test="${empty fcOrderList}">
							<tr><td colspan="6" class="fw-bold fs-5">조회할 내용이 없습니다.</td></tr>
							</c:if>
							<c:forEach var="vo" items="${fcOrderList}" varStatus="vs">
								<tr>
									<th scope="row">${vo.fcOrderSeq}</th>
									<td>${vo.fcOrderDate}</td>
									<td><fmt:formatNumber value="${vo.sumPrice}" pattern="#,###"/></td>
									<td>
										<span class="btn py-0" onclick="fcOrderDetailForm(${vo.fcOrderSeq})" >
											<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" >
											  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z"/>
										</svg></span>
										</td>
									<td>${vo.fcOrderFlag}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
			<!-- tabel bottom -->				
					<div class="dataTable-bottom">
						<nav class="dataTable-pagination">
							<ul class="pagination">
								<c:if test="${pageMaker.prev}">
									<li class="page-item"><a class="page-link" href="fcorder${pageMaker.searchQuery(pageMaker.spageNo-1)}&flag=N"
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
										<li class="page-item"><a href="fcorder${pageMaker.searchQuery(i)}&flag=N">${i}</a></li>
										</c:if>
									</c:forEach>
									
									
									<c:if test="${pageMaker.next}">
										<li class="page-item"><a class="page-link" href="fcorder${pageMaker.searchQuery(pageMaker.epageNo+1)}&flag=N" 
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
		<!-- footer inlcud -->
		<div><%@ include file="footer.jsp" %></div>
	</div> <!-- 본문 끝 -->
</div> <!-- layoutSidenav 끝 -->			


<!-- 발주상세조회 modal -->
<div class="modal fade" id="fcOrderDetailModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="fcOrderDetailModal">자재발주 상세내역</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<!-- "modal-body" -->
		<span id="fcOrderNumber" style="font-weight: bold; font-size: 1.2rem;"><!-- 발주번호, ajax 처리  --></span>
		<table class="table">
			<!-- table head -->
			<thead><tr align="center">
				<th width="12%">발주상세번호</th>
				<th width="10%">분 류</th>
				<th width="25%">품 명</th>
				<th width="10%">수 량</th>
				<th width="10%">단 위</th>
				<th width="20%">단 가</th>
				<th width="23%">금 액</th>
			</tr></thead>
			<!-- table body -->
			<tbody id="fcOrderDeatilTableBody" align="center">
				<!-- ajax 처리 -->
			</tbody>
			<tfoot><tr align="right">
				<th colspan="7" id="fcOrderDetailModalSumCol" style="font-weight: bold;"></th>
			</tr></tfoot>
		
		
		</table>
		</div> <!-- modal-body -->		
		<div class="modal-footer">
		  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>&nbsp;
		  <button type="button" class="btn btn-primary">출력</button>
		</div>
      </div>
    </div>
  </div><!-- 발주상세조회 modal -->		
		
		
		
		
		
		<!-- footer inlcud -->
		<div><%@ include file="footer.jsp" %></div>
	</div> 
</div> <!-- layoutSidenav 끝 -->			



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>