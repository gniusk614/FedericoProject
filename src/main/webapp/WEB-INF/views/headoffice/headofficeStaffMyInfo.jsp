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
															<th scope="col">비밀번호 변경</th>
															<td colspan="3">
																<div>
																	<input type="password" class="form-control"
																		id="hoPassword"
																		placeholder="길이4이상, 영문자, 숫자와 특수문자는 1개 이상 포함">
																</div>
															</td>
														</tr>
														<tr id="passUpRepeat" hidden="true">
															<th scope="col">비밀번호 확인</th>
															<td colspan="3">
																<div>
																	<input type="password" class="form-control"
																		id="passwordRepeat" disabled="disabled">
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