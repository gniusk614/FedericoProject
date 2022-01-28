<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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



</style>
<script>
	//Search 이벤트 -> makequery 메서드 사용하기위해 jsp파일에 배치
	$(
			function() {
				// SearchType 이 '---' 면 keyword 클리어
				$('#searchType').change(function() {
					$('#keyword').val('');
				}); //change
				// 검색후 요청
				$('#searchBtn').on( "click", function() {
							self.location = "cscenterf"
									+ "${pageMaker.makeQuery(1)}"
									+ "&searchType=" + $('#searchType').val()
									+ '&keyword=' + $('#keyword').val()
						}); //on_click 

			}) //ready
</script>
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
					<h1 class="display-6">고객센터</h1>
				</div>
				<div class="col-md-3"></div>
			</div>
			<div class="row justify-content-md-center" style="height: 50px;">
				<div id="csNotice" class="col-sm-4 checked" align="center"
					style="font-size: large; color: black; border-bottom: 2px solid black; cursor: pointer;"
					onclick="clickEffect('csNotice'); showCsDiv('csNotice');">
					공지사항</div>
				<div id="csComp" class="col-sm-4 checked" align="center"
					style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
					onclick="clickEffect('csComp'); showCsDiv('csComp');">
					고객의소리</div>
			</div>
			<!-- 컨텐츠 -->
			<div id="content">
				<!-- 공지사항 -->
				<div id="csNoticeBoard" class="container" style="display: block;">
					<div class="row justify-content-md-center mt-5 py-5">
					
						<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<div class="dataTable-top">
								<div class="container-fluid px-0">
									<div class="row">
										<div class="col-sm-2">
											<select name="searchType" id="searchType" class="form-select">
												<option value="none"
													<c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/>>- -</option>
												<option value="title"
													<c:out value="${pageMaker.cri.searchType=='title' ? 'selected':''}"/>>제목</option>
												<option value="content"
													<c:out value="${pageMaker.cri.searchType=='content' ? 'selected':''}"/>>내용</option>
												<option value="titleContent"
													<c:out value="${pageMaker.cri.searchType=='titleContent' ? 'selected':''}"/>>제목+내용</option>
											</select>
										</div>
										<div class="col-sm-3">
												<input class="form-control mr-1" type="search" id="keyword" placeholder="Search" value="${pageMaker.cri.keyword}">
										</div>
										<div class="col-sm-6">
											<button id="searchBtn" class="btn btn-outline-danger">검색</button>
										</div>
									</div>
								</div>
							</div>
							<div class="row mb-3">
							<div class="col lead px-3" style="font-size: medium;">
							검색결과 <b style="color: crimson;">${pageMaker.totalRowCount}</b>개
							</div>
							</div>
							<div class="dataTable-container" style="font-size:medium; border-top: 1px solid black;">
								<table id="table_id" class="table table-striped table-hover">
									<thead>
										<tr align="center" style="height: 50px; vertical-align:middle;">
											<th scope="col" style="width: 100px;">번호</th>
											<th scope="col" style="width: 500px;">제목</th>
											<th scope="col" style="width: 200px;">날짜</th>
											<th scope="col" style="width: 100px;">조회수</th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${! empty message }">
											<tr>
												<td colspan="6" class="fw-bold fs-5">${message}</td>
											</tr>
										</c:if>
										
										<c:forEach var="noticeList" items="${noticeList}">
											<tr onclick="" style="vertical-align:middle; height: 50px; background-color:Gainsboro; cursor: point;" align="left">
												<td align="center"><b style="color: crimson;">공지</b></td>
												<td>${noticeList.title}</td>
												<td align="center">${noticeList.regdate}</td>
												<td align="center">${noticeList.cnt}</td>
											</tr>
										</c:forEach>
										<c:forEach var="list" items="${boardList}">
											<tr onclick="" style="vertical-align:middle; height: 50px; cursor: point;">
												<td align="center">${list.seq}</td>
												<td>${list.title}</td>
												<td align="center">${list.regdate}</td>
												<td align="center">${list.cnt}</td>
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
												href="cscenterf${pageMaker.searchQuery(pageMaker.spageNo-1)}"
												aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
											</a></li>
										</c:if>
										<c:if test="${! pageMaker.prev}">
											<li class="page-item disabled"><a class="page-link"
												aria-label="Previous"> <span aria-hidden=true>&laquo;</span>
											</a></li>
										</c:if>
										<c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
											<c:if test="${i==pageMaker.cri.currPage}">
												<li class="page-item active" aria-current="page"><a
													class="page-link">${i}</a></li>
											</c:if>
											<c:if test="${i!=pageMaker.cri.currPage}">
												<li class="page-item"><a href="cscenterf${pageMaker.searchQuery(i)}">${i}</a></li>
											</c:if>
										</c:forEach>
										<c:if test="${pageMaker.next}">
											<li class="page-item"><a class="page-link"
												href="cscenterf${pageMaker.searchQuery(pageMaker.epageNo+1)}"
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
					</div>
				</div>

				<!-- 고객의 소리 -->
				<div id="csCompForm" class="container" style="display: none;">
					<div class="row justify-content-md-center">
					고객의 소리입니다.
					</div>
				</div>
	</section>
	<!-- footer inlcud -->
	<%-- <%@ include file="footer.jsp"%> --%>




	
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/client_Script.js"></script>
</body>
</html>