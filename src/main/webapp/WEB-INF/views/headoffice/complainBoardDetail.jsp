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
<script src="/federico/resources/ckeditor/ckeditor.js"></script>
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
	<!-- navtop inlcud -->
	<%@ include file="navtop.jsp"%>

	<!-- layoutSidenav 시작 -->
	<div id="layoutSidenav">
		<%@ include file="navside.jsp"%>
		<div class="container-fluid">
			<div class="row mt-5 mb-1">
				<div class="col-md-3"></div>
				<div class="col-md-6" align="center">
					<h1 class="display-6">고객의 소리</h1>
				</div>
				<div class="col-md-3"></div>
			</div>
			<!-- 컨텐츠 -->
			<div id="cont">
				<!-- 공지사항 -->
				<div id="csNoticeBoard" class="container" style="display: block;">
					<div class="row justify-content-md-center py-5">
						<div class="dataTable-wrapper dataTable-loading no-footer">
							<div class="dataTable-container"
								style="border-top: 1px solid black;">
								<table id="table_id" class="table">
									<thead>
										<tr class="lead"
											style="font-size: medium; height: 70px; vertical-align: middle;">
											<td scope="col"
												style="width: 400px; font-size: x-large; font-weight: bold;">${complainDetail.title}
											</td>
											<td scope="col" style="width: 100px; ">작성자&nbsp;<b>${complainDetail.clientName}</b></td>
											<td scope="col" style="width: 100px; ">연락처&nbsp;<b>${complainDetail.clientPhone}</b></td>
											<td scope="col" style="width: 100px; ">&nbsp;<b>${complainDetail.clientEmail}</b></td>
											<td scope="col" style="width: 100px; ">
											<div style="border-right: 1px solid lightgray; border-left: 1px solid lightgray;">
											&nbsp;가맹점&nbsp;${complainDetail.fcId}</div></td>
											<td scope="col" style="width: 100px; ">
											<fmt:parseDate var="regdate" value="${complainDetail.regdate}"
														pattern="yyyy-MM-dd" />
														<fmt:formatDate var="regdate" value="${regdate}"
														pattern="yyyy-MM-dd" />
												<div style="border-right: 1px solid lightgray;">
													${regdate}</div>
											</td>
											
										</tr>
									</thead>
								</table>
								<div class="row py-3 px-5"
									style="min-height: 500px; border-bottom: 1px solid lightgray;" align="justify">
									<div>
										<pre style="font-size: medium;">${complainDetail.content}</pre>
									</div>
								</div>
								
								<div class="row py-3 px-5"
									style="border-bottom: 1px solid black;" align="justify">
									<div class="mb-3">
									댓글
									</div>

									<div class="row py-3 px-5" align="left">
									<div id="comment">
										<c:forEach var="complainComment" items="${complainComment}">
											<div class="row mt-4 mb-4">
												<div class="row">
													<div class="col" style="font-size: small;">
														<b style="font-size: medium;">${complainComment.hoId}</b>&nbsp;&nbsp;&nbsp;&nbsp;${complainComment.commentRegdate}
													</div>
												</div>
												<div class="row mt-3">
													<div class="col-10">${complainComment.commentContent}</div>
													<div class="col-2" style="cursor: pointer;" align="right" onclick="complainCommentDelete(${complainComment.commentSeq},${complainDetail.seq})"><i class="bi bi-trash"></i></div>
												</div>
											</div>
											<hr>
										</c:forEach>
									</div>
									</div>

									<div class="row py-3 px-5">
										<textarea id="content" style="resize: none; width: 100%; height: 200px;"></textarea>
									</div>
									<div class="row">
										<div align="right">
										<button class="btn btn-primary"
											onclick="complainCommentInsert('${complainDetail.seq}')">
											댓글입력
										</button>
										</div>
									</div>
									
								</div>
								<div class="row mt-4 px-3">
									<div class="col-6" align="left">
										<button class="btn btn-outline-primary" style="width: 100px;"
											onclick="javascript:location.href='complainBoardf'">목록</button>
									</div>
									<div class="col-6" align="right">
										<button class="btn btn-outline-primary" style="width: 100px;"
											onclick="complainComplete('${complainDetail.seq}')">
											완료처리
										</button>
									</div>
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