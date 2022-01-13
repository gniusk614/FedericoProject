<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Federico Company</title>

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
	<div class="container-fluid px-4" style="margin-top: 20px;">
		<div class="row">
			<div class="card">
				<div class="card-body">
					<form>
						<div class="form-group">
							<label class="form-label mt-4">사원번호(ID)</label> 
								<div class="input-group mb-3">
  									<input type="text" id="staffCode" name="staffCode" class="form-control">
  									<button class="btn btn-outline-secondary" type="button" id="button-addon2">중복확인</button>
								<div class="invalid-feedback">
								<c:if test="${not empty codeMessage}">${codeMessage}</c:if>
								</div>
								</div>
								
						</div>
							<!-- 맞으면 스크립트에서 ${password}.addclass('is-valid')addclass -->
						<div class="form-group has-success">
							<label class="form-label mt-4">비밀번호</label> 
							<input type="password" class="form-control" id="hoPassword">
							<div class="valid-feedback"></div>
						</div>
							<!-- 맞으면 스크립트에서 ${passwordRepeat}.addclass('is-valid')addclass -->
							<!-- 틀리면 스크립트에서 ${passwordRepeat}.addclass('is-invalid')addclass -->
						<div class="form-group has-danger">
							<label class="form-label mt-4">비밀번호 확인</label> 
							<input type="password" class="form-control" id="passwordRepeat">
							<div class="invalid-feedback">
							<c:if test="${not empty pwMessage}">${pwMessage}</c:if>
							</div>
						</div>
						<div class="form-group">
							<label class="form-label mt-4">이름</label> 
							<input type="text" id="staffName"  class="form-control" >
						</div>
						<div class="form-group">
							<label class="form-label mt-4">E-mail</label> 
							<input type="text" id="staffEmail" class="form-control" >
						</div>
						<div class="form-group">
							<label class="form-label mt-4">연락처</label> 
							<input type="text" id="staffPhone"  class="form-control">
						</div>
						<div>
							<br>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>