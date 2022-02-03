<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
</head>
<script>
//Search 이벤트 -> makequery 메서드 사용하기위해 jsp파일에 배치
$(function() {	
	// SearchType 이 '---' 면 keyword 클리어
	$('#searchType').change(function() {
		if ($(this).val()=='n') $('#keyword').val('');
	}); //change
	// 검색후 요청
 	$('#searchBtn').on("click", function() {
		self.location="fcclientregf"
			+"${pageMaker.makeQuery(1)}"
			+'&keyword='
			+$('#keyword').val()
			+'&gbFlag='
			+$('#flag').val()
	}); //on_click 
	
	
}) //ready

function move(){
	self.location="fcclientregf"
		+"${pageMaker.makeQuery(1)}"
		+'&keyword='
		+$('#keyword').val()
		+'&gbFlag='
		+$('#flag').val()
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
				${fcId}점 고객 리스트</h4>
				</div>
				<div class="card-body">
					<div class="dataTable-top">
						<div class="container-fluid">
							<div class="row">
								<div class="col-sm-2">
									<select id="completeOrderSearchType" class="form-select" onchange="completeOrderSearchChange()">
										<option value="memo" selected="selected">메모내용</option>
									</select>
								</div>
							
									<div class="col-sm-2" id="searchInput">
										<input class="form-control me-2" type="search" id="keyword"
											placeholder="Search" value="${pageMaker.cri.keyword}" aria-label="Search">
									</div>
									
										
										
								<div class="col-sm-2">
									<button id="searchBtn" class="btn btn-outline-primary">검색</button>
								</div>
									<div class="col-sm-6" id="gbFlag" align="right">
										<c:if test="${gbFlag == '' || gbFlag == null}">
											<input type="hidden" id="flag">
											<a href="#" class="selecteD" onclick="selectALLGB('A')"> 
												<span id="flagA">전체</span>
											</a>&nbsp; 
											<a href="#" class="notSelecteD" onclick="selectALLGB('G')">
												<span id="flagN">단골</span>
											</a>&nbsp; 
											<a href="#" class="notSelecteD" onclick="selectALLGB('B')">
												<span id="flagY">블랙리스트</span>
											</a>&nbsp;
										</c:if>
										
										<c:if test="${gbFlag == 'G'}">
											<input type="hidden" id="flag" value="G">
											<a href="#" class="notSelecteD" onclick="selectALLGB('A')"> 
												<span id="flagA">전체</span>
											</a>&nbsp; 
											<a href="#" class="selecteD" onclick="selectALLGB('G')">
												<span id="flagN">단골</span>
											</a>&nbsp; 
											<a href="#" class="notSelecteD" onclick="selectALLGB('B')">
												<span id="flagY">블랙리스트</span>
											</a>&nbsp;											
										</c:if>
										
										<c:if test="${gbFlag == 'B'}">
											<input type="hidden" id="flag" value="B">
											<a href="#" class="notSelecteD" onclick="selectALLGB('A')"> 
												<span id="flagA">전체</span>
											</a>&nbsp; 
											<a href="#" class="notSelecteD" onclick="selectALLGB('G')">
												<span id="flagN">단골</span>
											</a>&nbsp; 
											<a href="#" class="selecteD" onclick="selectALLGB('B')" style="color: red;">
												<span id="flagY">블랙리스트</span>
											</a>&nbsp;																		
										</c:if>
									</div>	
							</div>		
						</div>
					</div>
					<!-- table -->
					<table id="t_itemselect" class="table table-striped table-hover">
						<thead align="center">
							<tr>
								<th scope="col" width="10%">NO</th>
								<th scope="col" width="20%">고객 연락처</th>
								<th scope="col" width="45%">메모내용</th>
								<th scope="col" width="15%">단골/블랙</th>
								<th scope="col" width="10%">수정/삭제</th>
							</tr>
						</thead>
						<tbody align="center">
							<c:if test="${empty fcClientList}">
							<tr><td colspan="6" class="fw-bold fs-5">조회할 내용이 없습니다.</td></tr>
							</c:if>
							<c:forEach var="vo" items="${fcClientList}" varStatus="vs">
								<tr>
									<th>${vs.index + 1}</th>
									<td>${vo.clientPhone}</td>
									<td>${vo.memo}</td>
									<c:if test="${vo.gbFlag == 'G' }">
										<td style="color: green;">
											단골
										</td>
									</c:if>
									<c:if test="${vo.gbFlag == 'B' }">
										<td style="color: Red;">
											블랙리스트
										</td>
									</c:if>
									<td><span class="btn"  onclick="fcClientListModalShow(${vo.seq})" style="padding: 0px;">  
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-wrench" viewBox="0 0 16 16">
										  <path d="M.102 2.223A3.004 3.004 0 0 0 3.78 5.897l6.341 6.252A3.003 3.003 0 0 0 13 16a3 3 0 1 0-.851-5.878L5.897 3.781A3.004 3.004 0 0 0 2.223.1l2.141 2.142L4 4l-1.757.364L.102 2.223zm13.37 9.019.528.026.287.445.445.287.026.529L15 13l-.242.471-.026.529-.445.287-.287.445-.529.026L13 15l-.471-.242-.529-.026-.287-.445-.445-.287-.026-.529L11 13l.242-.471.026-.529.445-.287.287-.445.529-.026L13 11l.471.242z"/>
										</svg>								
									</span></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
			<!-- tabel bottom -->				
					<div class="dataTable-bottom">
						<nav class="dataTable-pagination">
							<ul class="pagination">
								<c:if test="${pageMaker.prev}">
								
									<li class="page-item"><a class="page-link" href="fcclientregf${pageMaker.searchQuery(pageMaker.spageNo-1)}"
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
										<li class="page-item"><a href="fcclientregf${pageMaker.searchQuery(i)}">${i}</a></li>
										</c:if>
									</c:forEach>
									
									
									<c:if test="${pageMaker.next}">
										<li class="page-item"><a class="page-link" href="fcclientregf${pageMaker.searchQuery(pageMaker.epageNo+1)}" 
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
							<button type="button" id="fcClientDelete" class="btn btn-danger"  >삭제</button>&nbsp;&nbsp;
							<button type="button" id="fcClientUpdate" class="btn btn-success" >수정</button>
			</div>
		</div>
	</div>
</div>
<!-- 고객관리 조회/수정/삭제 모달 -->







<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>