<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>사원 정보 리스트</title>
<!-- <link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css"
	rel="stylesheet" />
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="/federico/resources/myLib/headOffice_Script.js"></script> -->


<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/headOffice_Script.js"></script>
<style>
<!--
섹션 크기 -->.bg-light {
	height: 1053px;
	padding-top: 55px;
	padding-bottom: 75px;
}

.flex-fill.mx-xl-5.mb-2 {
	margin: 0 auto;
	width: 700px;
	padding-right: 7rem;
	padding-left: 7rem;
}

<!--
입력창 -->.container.py-4 {
	margin: 0 auto;
	width: 503px;
}

<!--
가입하기 -->.d-grid.gap-2 {
	padding-top: 30px;
}

<!--
생년월일 -->.bir_yy, .bir_mm, .bir_dd {
	width: 160px;
	display: table-cell;
}

.bir_mm+.bir_dd, .bir_yy+.bir_mm {
	padding-left: 10px;
}
</style>
</head>
<body>
	<%@ include file="navtop.jsp"%>

	<!-- layoutSidenav 시작 -->
	<div id="layoutSidenav">
		<%@ include file="navside.jsp"%>
		<div id="layoutSidenav_content">
			<!-- 본문 시작 -->
			<div class="container-fluid px-4" style="margin-top: 20px;">
				<div class="row">
					<div class="col-sm-3"></div>
					<div class="col-sm-6">
						<div class="card">
							<div class="card-header">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
	  					<path
										d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z" />
					</svg>
								&nbsp;사원 계정 생성
							</div>
							<div class="card-body">
								<form>
									<div class="form-group">
										<label for="exampleInputEmail1" class="form-label mt-4">아이디</label>
										<input type="text" class="form-control"
											id="exampleInputEmail1" aria-describedby="emailHelp">
									</div>
									<div class="form-group has-success">
										<label class="form-label mt-4" for="inputValid">비밀번호</label> <input
											type="password" class="form-control is-valid" id="inputValid">
										<div class="valid-feedback"></div>
									</div>

									<div class="form-group has-danger">
										<label class="form-label mt-4" for="inputInvalid">비밀번호
											재확인</label> <input type="password" class="form-control is-invalid"
											id="inputInvalid">
										<div class="invalid-feedback">비밀번호가 일치하지 않습니다</div>
									</div>
									<div class="form-group">
										<label for="exampleInputEmail1" class="form-label mt-4">이름</label>
										<input type="text" class="form-control"
											id="exampleInputEmail1" aria-describedby="emailHelp">
									</div>
									<div>
										<br>
									</div>
									<div>
										<input class="btn btn-primary" type="submit" value="Login">
									</div>
								</form>
							</div>
						</div>
					</div>
					<div class="col-sm-3"></div>
				</div>
			</div>
			<!-- footer inlcud -->
			<div><%@ include file="footer.jsp"%></div>
		</div>
		<!-- 본문 끝 -->
	</div>
	<!-- layoutSidenav 끝 -->
	
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>
	
</body>
</html>