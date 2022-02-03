<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<jsp:useBean id="now" class="java.util.Date" />
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

tbody tr {
	cursor: pointer;
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
				$('#searchBtn').on(
						"click",
						function() {
							self.location = "complainBoardf"
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
	<!-- navtop inlcud -->
	<%@ include file="navtop.jsp"%>

	<!-- layoutSidenav 시작 -->
	<div id="layoutSidenav">
		<%@ include file="navside.jsp"%>
		<div id="layoutSidenav_content">
			<!-- 본문 시작 -->
			<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="now" />
			<div class="container-fluid">
				<div class="row mt-5 mb-1">
					<div class="col-md-3"></div>
					<div class="col-md-6" align="center">
						<h1 class="display-6">고객의 소리</h1>
					</div>
					<div class="col-md-3"></div>
				</div>
				<!-- 컨텐츠 -->
				<div id="content">
					<!-- 공지사항 -->
					<div id="csNoticeBoard" class="container" style="display: block;">
						<div class="row justify-content-md-center py-5">

							<div
								class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
								<div class="dataTable-top">
									<div class="container-fluid px-0">
										<div class="row">
											<div class="col-sm-2">
												<select name="searchType" id="searchType"
													class="form-select" onchange="changeSearchComplainOption()">
													<option value="none"
														<c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/>>-
														-</option>
													<option value="title"
														<c:out value="${pageMaker.cri.searchType=='title' ? 'selected':''}"/>>제목</option>
													<option value="content"
														<c:out value="${pageMaker.cri.searchType=='content' ? 'selected':''}"/>>내용</option>
													<option value="titleContent"
														<c:out value="${pageMaker.cri.searchType=='titleContent' ? 'selected':''}"/>>제목+내용</option>
													<option value="clientName"
														<c:out value="${pageMaker.cri.searchType=='clientName' ? 'selected':''}"/>>작성자</option>
													<option value="fcId"
														<c:out value="${pageMaker.cri.searchType=='fcId' ? 'selected':''}"/>>가맹점</option>
													<option value="clientPhone"
														<c:out value="${pageMaker.cri.searchType=='clientPhone' ? 'selected':''}"/>>연락처</option>
													<option value="completeFlag"
														<c:out value="${pageMaker.cri.searchType=='completeFlag' ? 'selected':''}"/>>처리완료여부</option>
												</select>
											</div>



											<div class="col-sm-3" id="changeCompleteFinder">
												<c:if test="${pageMaker.cri.searchType!='completeFlag'}">
													<input class="form-control mr-1" type="search" id="keyword"
														placeholder="Search" value="${pageMaker.cri.keyword}">
													<select class="form-select" id="keywordHide"
														style="display: none;">
														<option value="">- -</option>
														<option value="Y"
															<c:out value="${pageMaker.cri.keyword=='Y' ? 'selected':''}"/>>Y</option>
														<option value="N"
															<c:out value="${pageMaker.cri.keyword=='N' ? 'selected':''}"/>>N</option>
													</select>
												</c:if>
												<c:if test="${pageMaker.cri.searchType=='completeFlag'}">
													<input class="form-control  mr-1" type="search"
														id="keywordHide" placeholder="Search"
														value="${pageMaker.cri.keyword}" style="display: none;">
													<select class="form-select" id="keyword">
														<option value="">- -</option>
														<option value="Y"
															<c:out value="${pageMaker.cri.keyword=='Y' ? 'selected':''}"/>>Y</option>
														<option value="N"
															<c:out value="${pageMaker.cri.keyword=='N' ? 'selected':''}"/>>N</option>
													</select>
												</c:if>

											</div>
											<div class="col-sm-3">
												<button id="searchBtn" class="btn btn-outline-primary">검색</button>
											</div>
										</div>
								</div>
								<div class="row mb-3">
									<div class="col lead px-3" style="font-size: medium;">
										검색결과 <b class="text-primary">${pageMaker.totalRowCount}</b>개
									</div>
								</div>
								<div class="dataTable-container"
									style="font-size: medium; border-top: 1px solid black;">
									<table id="table_id" class="table table-striped table-hover">
										<thead>
											<tr align="center"
												style="height: 50px; vertical-align: middle;">
												<th scope="col" style="width: 100px;">번호</th>
												<th scope="col" style="width: 50px;">말머리</th>
												<th scope="col" style="width: 300px;">제목</th>
												<th scope="col" style="width: 100px;">작성자</th>
												<th scope="col" style="width: 100px;">가맹점</th>
												<th scope="col" style="width: 100px;">날짜</th>
												<th scope="col" style="width: 100px;">처리상태</th>
											</tr>
										</thead>
										<tbody>
											<c:if test="${! empty message }">
												<tr>
													<td colspan="6" class="fw-bold fs-5">${message}</td>
												</tr>
											</c:if>

											<c:forEach var="list" items="${boardList}">
												<tr
													onclick="javascript:location.href='complainDetail?seq=${list.seq}'"
													style="vertical-align: middle; height: 50px;">
													<td align="center">${list.seq}</td>
													<td align="center">${list.head}</td>

													<fmt:parseDate var="regdate" value="${list.regdate}"
														pattern="yyyy-MM-dd" />
													<fmt:formatDate var="regdate" value="${regdate}"
														pattern="yyyyMMdd" />

													<td>${list.title}<c:if test="${now-regdate<7}">
															<b class="text-primary" style="font-size: small;">NEW</b>
														</c:if>
													</td>

													
													<td align="center">${list.clientName}</td>
													<td align="center">${list.fcId}</td>
													<td align="center">${list.regdate}</td>
													<td align="center">${list.completeFlag}</td>
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
													href="complainBoardf${pageMaker.searchQuery(pageMaker.spageNo-1)}"
													aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
												</a></li>
											</c:if>
											<c:if test="${! pageMaker.prev}">
												<li class="page-item disabled"><a class="page-link"
													aria-label="Previous"> <span aria-hidden=true>&laquo;</span>
												</a></li>
											</c:if>
											<c:forEach var="i" begin="${pageMaker.spageNo}"
												end="${pageMaker.epageNo}">
												<c:if test="${i==pageMaker.cri.currPage}">
													<li class="page-item active" aria-current="page"><a
														class="page-link">${i}</a></li>
												</c:if>
												<c:if test="${i!=pageMaker.cri.currPage}">
													<li class="page-item"><a
														href="complainBoardf${pageMaker.searchQuery(i)}">${i}</a></li>
												</c:if>
											</c:forEach>
											<c:if test="${pageMaker.next}">
												<li class="page-item"><a class="page-link"
													href="complainBoardf${pageMaker.searchQuery(pageMaker.epageNo+1)}"
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

			<!-- footer inlcud -->
			<div><%@ include file="footer.jsp"%></div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/headOffice_Script.js"></script>
</body>
</html>