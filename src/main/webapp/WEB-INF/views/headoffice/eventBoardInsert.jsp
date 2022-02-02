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
	<!-- navtop include -->
	<%@ include file="navtop.jsp"%>

	<!-- layoutSidenav 시작 -->
	<div id="layoutSidenav">
		<%@ include file="navside.jsp"%>
		<div class="container-fluid" style="height: 100%">
			<div class="row mt-5 mb-1">
				<div class="col-md-3"></div>
				<div class="col-md-6" align="center">
					<h1 class="display-6">이벤트 게시판</h1>
				</div>
				<div class="col-md-3"></div>
			</div>
			<!-- 컨텐츠 -->
			<div id="con">
				<!-- 이벤트 게시판 -->
				<div class="card" id="contentCard">
					<div class="card-header">
						<div class="form-group mb-2">
							<input type="text" id="title" placeholder="제목"
								class="form-control">
						</div>
					</div>
					<div class="card-body">
						<div class="row mb-3">
							<div class="col">
								<textarea class="form-control" id="content">
								글자수 600자 제한
								</textarea>
							</div>
						</div>
						<div class="row">							
							<div class="col" align="left">
								<button class="btn btn-primary" onclick="eventUpload()">글 등록</button>
							</div>
						</div>
					</div>
					</div>
				</div>

			<!-- footer include -->
			<div><%@ include file="footer.jsp"%></div>
		</div>
	</div>
	<script>
 var ckeditor_config = {
   removePlugins : 'resize',
   resize_enabled : false,
   height: 500,
   enterMode : CKEDITOR.ENTER_BR,
   shiftEnterMode : CKEDITOR.ENTER_P,
   filebrowserUploadUrl : "boardImageUpload",
   extraPlugins: 'wordcount'
 };
 
 CKEDITOR.replace("content", ckeditor_config);
 var value = "";
 CKEDITOR.instances['content'].on('key', function () {
	value =CKEDITOR.instances['content'].getData();
	 if(CKEDITOR.instances['content'].document.getBody().getText().length>400){
		 alert('400자 이상 작성할 수 없습니다.')
	 }
	});
		
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/headOffice_Script.js"></script>
</body>
</html>