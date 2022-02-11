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
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
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
</head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<body>
	<c:if test="${not empty message}">
		<script>
			alert('출력할 글이 없습니다.');
			location.href = history.go(-1);
		</script>
	</c:if>

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
			<!-- 컨텐츠 -->
			<div id="content">
				<!-- 공지사항 -->
				<div id="csNoticeBoard" class="container" style="display: block;">
					<div class="row justify-content-md-center mt-5 py-5">
						<div class="dataTable-wrapper dataTable-loading no-footer">
							<div class="dataTable-container"
								style="border-top: 1px solid black;">
								<table id="table_id" class="table">
									<thead>
										<tr class="lead"
											style="font-size: medium; height: 70px; vertical-align: middle;">
											<td scope="col" style="width: 700px; font-size: x-large; font-weight: bold;">${noticeDetail.title}
											</td>
											<td scope="col" style="width: 100px; color: gray;">
											<fmt:parseDate var="regdate" value="${noticeDetail.regdate}"
														pattern="yyyy-MM-dd" />
													<fmt:formatDate var="regdate" value="${regdate}"
														pattern="yyyy-MM-dd" />
												<div style="border-right: 1px solid lightgray;">
													${regdate}</div>
											</td>
											<td scope="col" style="width: 100px; color: gray;">조회수&nbsp;${noticeDetail.cnt}</td>
										</tr>
									</thead>
								</table>
								<div class="row py-3 px-5" style="min-height: 500px; border-bottom: 1px solid black;">
									<div align="justify"><pre style="font-size: medium;">${noticeDetail.content}</pre></div>
								</div>
								<div class="row mt-4 px-3">
									<div class="col-6" align="left">
									<button class="btn btn-outline-danger" style="width: 100px;"
									onclick="javascript:location.href='cscenterf'">목록</button>
									</div>
									<div class="col-6" align="right">
									<button class="btn btn-outline-danger" style="width: 100px;"
									onclick="javascript:location.href='csNoticeDetail?seq=${noticeDetail.seq-1}'">
										<i class="bi bi-caret-left-fill"></i>
										이전글
									</button>
									<button class="btn btn-outline-danger" style="width: 100px;"
									onclick="javascript:location.href='csNoticeDetail?seq=${noticeDetail.seq+1}'">
										다음글
										<i class="bi bi-caret-right-fill"></i>
									</button>
									</div>
								</div>
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
	<!-- footer include -->
	<%-- <%@ include file="footer.jsp"%> --%>




	
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/client_Script.js"></script>
</body>
</html>