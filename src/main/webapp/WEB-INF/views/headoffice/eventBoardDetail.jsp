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
	<!-- navtop include -->
	<%@ include file="navtop.jsp"%>

	<!-- layoutSidenav 시작 -->
	<div id="layoutSidenav">
		<%@ include file="navside.jsp"%>
		<div class="container-fluid">
			<div class="row mt-5 mb-1">
				<div class="col-md-3"></div>
				<div class="col-md-6" align="center">
					<h1 class="display-6">이벤트 게시판</h1>
				</div>
				<div class="col-md-3"></div>
			</div>
			<!-- 컨텐츠 -->
			<div id="content">
				<!-- 이벤트 게시판 -->
				<div id="csEventBoard" class="container" style="display: block;">
					<div class="row justify-content-md-center py-5">
						<div class="dataTable-wrapper dataTable-loading no-footer">
							<div class="dataTable-container"
								style="border-top: 1px solid black;">
								<table id="table_id" class="table">
									<thead>
										<tr class="lead"
											style="font-size: medium; height: 70px; vertical-align: middle;">
											<td scope="col"
												style="width: 700px; font-size: x-large; font-weight: bold;">${eventDetail.title}
											</td>
											<td scope="col" style="width: 100px; color: gray;">작성자&nbsp;<b>${eventDetail.hoId}</b></td>
										</tr>
									</thead>
								</table>
								<div class="row py-3 px-5"
									style="min-height: 500px; border-bottom: 1px solid black;" align="justify">
									<div>
										<pre style="font-size: medium;">${eventDetail.content}</pre>
									</div>
								</div>
								<div class="row mt-4 px-3">
									<div class="col-6" align="left">
										<button class="btn btn-outline-primary" style="width: 100px;"
											onclick="javascript:location.href='eventBoardf'">목록</button>
									</div>
									<div class="col-6" align="right">
										<button class="btn btn-outline-primary" style="width: 100px;"
											onclick="javascript:location.href='eventUpdatef?eventSeq=${eventDetail.eventSeq}'">
											수정
										</button>
										<button class="btn btn-outline-primary" style="width: 100px;"
											onclick="eventDelete('${eventDetail.eventSeq}')">
											삭제
										</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<!-- footer include -->
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