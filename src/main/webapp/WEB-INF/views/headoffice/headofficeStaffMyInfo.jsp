<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Federico Company</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/headOffice_Script.js"></script>
<script src="/federico/resources/myLib/inCheck.js"></script>
</head>
<body>
	<!-- navtop inlcud -->
	<%@ include file="navtop.jsp"%>

	<!-- layoutSidenav 시작 -->
	<div id="layoutSidenav">
		<%@ include file="navside.jsp"%>
		<div id="layoutSidenav_content">
			<!-- 본문 시작 -->
			<div class="container-fluid px-4" style="margin-top: 20px;">
				<div class="row">
					<div class="col-lg-3"></div>
					<div class="col-lg-6">
						<div class="card">
							<div class="card-header">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-person-square"
									viewBox="0 0 16 16">
  								<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
  								<path
										d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1v-1c0-1-1-4-6-4s-6 3-6 4v1a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12z" />
								</svg>
								나의 상세 정보 </a>
							</div>
							<div class="card-body">
								<c:if test="${not empty staffMyInfo}">
									<table class="table table-striped">
										<thead>
											<tr>
												<th scope="col" colspan="2">사원 번호</th>
												<th scope="col" colspan="2">이 름</th>
											</tr>
										</thead>
										<tbody>
											<tr>
												<th scope="row" colspan="2"><div id="staffCode">${staffMyInfo.staffVo.staffCode}</div></th>
												<td colspan="2"><div id="staffName">${staffMyInfo.staffVo.staffName}</div></td>
											</tr>
											<tr>
												<td colspan="4">
													<table class="table mb-0">
														<tr id="passUp" hidden="true">
															<th scope="col">비밀번호</th>
															<td colspan="3">
																<div>
																	<input class="btn btn-primary" type="button"
																		id="staffPwChange" value="비밀번호 변경">
																</div>
															</td>
														</tr>
														<tr>
															<th scope="col">직 급</th>
															<td colspan="3"><div id="staffPosition">${staffMyInfo.staffVo.staffPosition}</div></td>
														</tr>
														<tr>
															<th scope="col">연 락 처</th>
															<td colspan="3"><div id="staffPhone">${staffMyInfo.staffVo.staffPhone}</div></td>
														</tr>
														<tr>
															<th scope="col">E-mail</th>
															<td colspan="3"><div id="staffEmail">${staffMyInfo.staffVo.staffEmail}</div></td>
														</tr>
													</table>
												</td>
											</tr>
										</tbody>
									</table>
								</c:if>
							</div>
							<div class="card-footer">
								<input class="btn btn-primary" type="button" id="infoUp"
									value="정보수정">
							</div>
						</div>
					</div>
				</div>
			</div>
			
			
			
			
			<div class="modal fade" id="staffPwChangeModal" role="dialog">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
									fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
	  								<path
										d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z" />
								</svg>
								&nbsp;비밀번호 수정
							</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div id="modal-body" class="modal-body">
							<div class="container-fluid px-4">
								<form>
									<div class="form-group gy-5">
										<label class="form-label">현재 비밀번호</label>
										<div class="input-group mb-2 ">
											 <input
												type="password" class="form-control" id="loginPassword"
												placeholder="현재 비밀번호를 확인합니다.">
											<button class="btn btn-outline-secondary" type="button"
												id="pwCheck">확인</button>
											<div class="invalid-feedback" id="lpMessage"></div>
										</div>
										<!-- 맞으면 스크립트에서 ${password}.addclass('is-valid')addclass -->
										<div class="form-group has-success mb-2">
											<label class="form-label">비밀번호</label> <input type="password"
												class="form-control" id="hoPassword"
												placeholder="길이4이상, 영문자, 숫자와 특수문자는 1개 이상 포함"
												disabled="disabled">
											<div class="invalid-feedback" id="pMessage"></div>
										</div>
										<!-- 맞으면 스크립트에서 ${passwordRepeat}.addclass('is-valid')addclass -->
										<!-- 틀리면 스크립트에서 ${passwordRepeat}.addclass('is-invalid')addclass -->
										<div class="form-group has-danger mb-2">
											<label class="form-label">비밀번호 확인</label> <input
												type="password" class="form-control" id="passwordRepeat"
												disabled="disabled">
											<div class="invalid-feedback" id="prMessage"></div>
										</div>
										<div>
											<br>
										</div>
										<div>
											<input class="btn btn-primary" type="button" id="staffPwUpBtn"
												value="수정"> <button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">Close</button>
										</div>
									</div>
								</form>
							</div>
						</div>
						<div class="modal-footer"></div>
					</div>
				</div>
			</div>
			<!-- footer inlcud -->
			<div><%@ include file="footer.jsp"%></div>
		</div>
		<!-- 본문 끝 -->
	</div>
	<!-- layoutSidenav 끝 -->



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>