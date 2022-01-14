<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/headOffice_Script.js"></script>
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
				미처리 발주내역</h4>
				</div>
				<div class="card-body">
					<div class="dataTable-top">
						<div class="container-fluid">
							<div class="row">
								<div class="col-sm-1">
									<select id="" class="form-select" aria-label="Default select example">
										<option value="none" <c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/>> - - </option>
										<option value="" <c:out value="${pageMaker.cri.searchType=='code' ? 'selected':''}"/>>품 명</option>
										<option value="" <c:out value="${pageMaker.cri.searchType=='name' ? 'selected':''}"/>>분 류<option>
									</select>
								</div>
								<div class="col-sm-3">
										<input class="form-control me-2" type="search"
											placeholder="Search" value="${pageMaker.cri.keyword}" aria-label="Search">
								</div>
								<div class="col-sm-2">
									<button id="itemsearch" class="btn btn-outline-primary">검색</button>
								</div>
								<div class="col-sm-7"></div>
								
							</div>
						</div>
					</div>
					<!-- table -->
					<table id="t_itemselect" class="table table-striped table-hover">
						<thead align="center">
							<tr>
								<th scope="col" width="10%">발주번호</th>
								<th scope="col" width="30%">가맹점명</th>
								<th scope="col" width="25%">상세내역</th>
								<th scope="col" width="20%">발주일</th>
								<th scope="col" width="15%">처리여부</th>
							</tr>
						</thead>
						<tbody align="center">
							<c:if test="${! empty message }">
							${message }
							</c:if>
							<c:forEach var="vo" items="${list}" varStatus="status">
								<tr>
									<th scope="row">${vo.fcOrderSeq}</th>
									<td>${vo.fcId}</td>
									<td><span class="btn" onclick="fcOrderDetailForm(${vo.fcOrderSeq})">상세내역 보기</span></td>
									<td>${vo.fcOrderDate}</td>
									<td>${vo.fcOrderFlag}</td>
									
								</tr>
							</c:forEach>
						</tbody>
					</table>
			<!-- tabel bottom -->				
					<div class="dataTable-bottom">
						<nav class="dataTable-pagination">
							<ul class="pagination">
								<li class="page-item"><a class="page-link" href="#"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
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
        <h5 class="modal-title" id="fcOrderDetailModal">발주 상세내역</h5>
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
		  <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		  <button type="button" class="btn btn-primary" onclick="fcOrderComplete()">완료처리</button>
		</div>
      </div>
    </div>
  </div>
</div><!-- 발주상세조회 modal -->








<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>