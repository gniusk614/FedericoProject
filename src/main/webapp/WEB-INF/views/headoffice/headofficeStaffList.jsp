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
<title>Federico Company</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/headOffice_Script.js"></script>
<script src="/federico/resources/myLib/inCheck.js"></script>
<script src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>
<style>
a:visited {
	text-decoration: none;
	color: black;
}

a:hover {
	text-decoration: none;
	color: black;
}

a {
	color: black;
	text-decoration: none;
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
							self.location = "staffList"
									+ "${pageMaker.makeQuery(1)}"
									+ "&searchType=" + $('#searchType').val()
									+ '&keyword=' + $('#keyword').val()
						}); //on_click 

			}) //ready
</script>
</head>
<body>
	<%@ include file="navtop.jsp"%>
	<!-- layoutSidenav 시작 -->
	<div id="layoutSidenav">
		<%@ include file="navside.jsp"%>
		<div id="layoutSidenav_content">
			<!-- 본문 시작 -->
			<div class="container-fluid px-4" style="margin-top: 20px;">
				<div class="card" id="contentCard">
					<div class="card-header">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-rolodex" viewBox="0 0 16 16">
  						<path d="M8 9.05a2.5 2.5 0 1 0 0-5 2.5 2.5 0 0 0 0 5Z"/>
  						<path d="M1 1a1 1 0 0 0-1 1v11a1 1 0 0 0 1 1h.5a.5.5 0 0 0 .5-.5.5.5 0 0 1 1 0 .5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5.5.5 0 0 1 1 0 .5.5 0 0 0 .5.5h.5a1 1 0 0 0 1-1V3a1 1 0 0 0-1-1H6.707L6 1.293A1 1 0 0 0 5.293 1H1Zm0 1h4.293L6 2.707A1 1 0 0 0 6.707 3H15v10h-.085a1.5 1.5 0 0 0-2.4-.63C11.885 11.223 10.554 10 8 10c-2.555 0-3.886 1.224-4.514 2.37a1.5 1.5 0 0 0-2.4.63H1V2Z"/>
					</svg>
						사원 정보 리스트
					</div>
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<div class="dataTable-top">
								<div class="container-fluid">
									<div class="row">
										<div class="col-sm-2">
											<select name="searchType" id="searchType" class="form-select"
												onchange="changeSearchStaffOption()">
												<option value="none"
													<c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/>>-
													-</option>
												<option value="code"
													<c:out value="${pageMaker.cri.searchType=='code' ? 'selected':''}"/>>사원번호</option>
												<option value="name"
													<c:out value="${pageMaker.cri.searchType=='name' ? 'selected':''}"/>>이름</option>
												<option value="position"
													<c:out value="${pageMaker.cri.searchType=='position' ? 'selected':''}"/>>직급</option>
												<option value="phone"
													<c:out value="${pageMaker.cri.searchType=='phone' ? 'selected':''}"/>>연락처</option>
												<option value="email"
													<c:out value="${pageMaker.cri.searchType=='email' ? 'selected':''}"/>>이메일</option>
											</select>
										</div>





										<div class="col-sm-3" id="changeSearchFinder">
											<c:if test="${pageMaker.cri.searchType!='position'}">
												<input class="form-control mr-1" type="search" id="keyword"
													placeholder="Search" value="${pageMaker.cri.keyword}">
												<select class="form-select" id="keywordHide"
													style="display: none;">
													<option value="">- -</option>
													<option value="주임"
														<c:out value="${pageMaker.cri.keyword=='주임' ? 'selected':''}"/>>주임</option>
													<option value="대리"
														<c:out value="${pageMaker.cri.keyword=='대리' ? 'selected':''}"/>>대리</option>
													<option value="과장"
														<c:out value="${pageMaker.cri.keyword=='과장' ? 'selected':''}"/>>과장</option>
													<option value="차장"
														<c:out value="${pageMaker.cri.keyword=='차장' ? 'selected':''}"/>>차장</option>
													<option value="대표"
														<c:out value="${pageMaker.cri.keyword=='대표' ? 'selected':''}"/>>대표</option>
												</select>
											</c:if>
											<c:if test="${pageMaker.cri.searchType=='position'}">
												<input class="form-control  mr-1" type="search"
													id="keywordHide" placeholder="Search"
													value="${pageMaker.cri.keyword}" style="display: none;">
												<select class="form-select" id="keyword">
													<option value="">- -</option>
													<option value="주임"
														<c:out value="${pageMaker.cri.keyword=='주임' ? 'selected':''}"/>>주임</option>
													<option value="대리"
														<c:out value="${pageMaker.cri.keyword=='대리' ? 'selected':''}"/>>대리</option>
													<option value="과장"
														<c:out value="${pageMaker.cri.keyword=='과장' ? 'selected':''}"/>>과장</option>
													<option value="차장"
														<c:out value="${pageMaker.cri.keyword=='차장' ? 'selected':''}"/>>차장</option>
													<option value="대표"
														<c:out value="${pageMaker.cri.keyword=='대표' ? 'selected':''}"/>>대표</option>
												</select>
											</c:if>

										</div>
										<div class="col-sm-6">
											<button id="searchBtn" class="btn btn-outline-primary">검색</button>
										</div>
									</div>
								</div>
							</div>
							<div class="dataTable-container">
								<table id="table_id" class="table table-striped table-hover">
									<thead>
										<tr>
											<th scope="col">사원번호</th>
											<th scope="col">이 름</th>
											<th scope="col">직 급</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${! empty message }">
											<tr>
												<td colspan="6" class="fw-bold fs-5">${message}</td>
											</tr>
										</c:if>
										<c:forEach var="list" items="${staffList}">
											<tr>
												<td>${list.staffCode}</td>
												<td>${list.staffName}</td>
												<td>${list.staffPosition}</td>
												<td><a id="${list.staffCode}" class="modalbtn"
													href="Javascript:;"> <svg
															xmlns="http://www.w3.org/2000/svg" width="16" height="16"
															fill="currentColor" class="bi bi-zoom-in"
															viewBox="0 0 16 16"> 
															<path fill-rule="evenodd"
																d="M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11zM13 6.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0z" />
											 				<path
																d="M10.344 11.742c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1 6.538 6.538 0 0 1-1.398 1.4z" />
											  				<path fill-rule="evenodd"
																d="M6.5 3a.5.5 0 0 1 .5.5V6h2.5a.5.5 0 0 1 0 1H7v2.5a.5.5 0 0 1-1 0V7H3.5a.5.5 0 0 1 0-1H6V3.5a.5.5 0 0 1 .5-.5z" />
														</svg>
												</a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="dataTable-bottom">
								<c:if test="${loginID == 'admin' }">
									<a id="joinBtn" href="Javascript:;"> &nbsp;<svg
											xmlns="http://www.w3.org/2000/svg" width="16" height="16"
											fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
	  								<path
												d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z" />
									</svg> &nbsp;계정생성
									</a>
								</c:if>
								<nav class="dataTable-pagination">
									<ul class="pagination">
										<c:if test="${pageMaker.prev}">
											<li class="page-item"><a class="page-link"
												href="staffList${pageMaker.searchQuery(pageMaker.spageNo-1)}"
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
												<li class="page-item"><a href="staffList${pageMaker.searchQuery(i)}">${i}</a></li>
											</c:if>
										</c:forEach>
										<c:if test="${pageMaker.next}">
											<li class="page-item"><a class="page-link"
												href="staffList${pageMaker.searchQuery(pageMaker.epageNo+1)}"
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
			<!-- footer inlcud -->
			<div><%@ include file="footer.jsp"%></div>
		</div>
		<!-- 본문 끝 -->
	</div>
	<!-- layoutSidenav 끝 -->



	<!-- 사원상세정보 modal -->
	<div class="modal fade" id="modal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">사원 상세정보</h5>
					<button type="button" class="btn-close infoClose"
						data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="card">
						<div class="card-header">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
								fill="currentColor" class="bi bi-person-square"
								viewBox="0 0 16 16">
  								<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z" />
  								<path
									d="M2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H2zm12 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1v-1c0-1-1-4-6-4s-6 3-6 4v1a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h12z" />
								</svg>
							사원 상세 정보 </a>
						</div>
						<div class="card-body">
							<table class="table table-striped">
								<thead>
									<tr>
										<th scope="col" colspan="2">사원 번호</th>
										<th scope="col" colspan="2">이 름</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th scope="row" colspan="2"><div id="staffCode"></div></th>
										<td colspan="2"><div id="staffName"></div></td>
									</tr>
									<tr>
										<td colspan="4">
											<table class="table mb-0">
												<tr>
													<th scope="col">직 급</th>
													<td colspan="3"><div id="staffPosition"></div></td>
												</tr>
												<tr>
													<th scope="col">연 락 처</th>
													<td colspan="3"><div id="staffPhone"></div></td>
												</tr>
												<tr>
													<th scope="col">E-mail</th>
													<td colspan="3"><div id="staffEmail"></div></td>
												</tr>
											</table>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="modal-footer">
						<div class="container-fluid">
							<div class="row">
								<div class="col-sm-3">
									<button type="button" id="staffDeleteBtn"
										class="btn btn-danger pull-left">삭제</button>
								</div>
								<div class="col-sm-3"></div>
								<div class="col-sm-6" align="right">
									<input class="btn btn-primary" type="button" id="infoUp"
										value="정보수정">
									<button type="button" class="btn btn-secondary infoClose"
										data-bs-dismiss="modal">Close</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<!-- 사원계정생성 modal -->
	<div class="modal fade" id="joinfmodal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
							fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
	  					<path
								d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z" />
					</svg>
						&nbsp;사원 계정생성
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div id="modal-body" class="modal-body">
					<div class="container-fluid px-4">
						<form>
							<div class="form-group gy-5">
								<label class="form-label">사원번호(ID)</label>
								<div class="input-group mb-2 ">
									<input type="text" id="code" class="form-control">
									<button class="btn btn-outline-secondary" type="button"
										id="codeDupcheck">중복확인</button>
									<div class="invalid-feedback" id="codeMessage"></div>
									<div class="valid-feedback" id="codeSuccessMessage"></div>
								</div>
								<!-- 맞으면 스크립트에서 ${password}.addclass('is-valid')addclass -->
								<div class="form-group has-success mb-2">
									<label class="form-label">비밀번호</label> <input type="password"
										class="form-control" id="hoPassword"
										placeholder="길이4이상, 영문자, 숫자와 특수문자는 1개 이상 포함">
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
								<div class="form-group mb-2">
									<label class="form-label">이름</label> <input type="text"
										id="name" class="form-control">
								</div>
								<div class="form-group mb-2">
									<label class="form-label">직 급</label> <select
										class="form-select" id="position">
										<option selected value="주임">주임</option>
										<option value="대리">대리</option>
										<option value="과장">과장</option>
										<option value="차장">차장</option>
									</select>
								</div>
								<div class="form-group mb-2">
									<label class="form-label">E-mail</label> <input type="text"
										id="email" class="form-control">
								</div>
								<div class="form-group mb-2">
									<label class="form-label">연락처</label> <input type="text"
										id="phone" class="form-control">
								</div>
								<div>
									<br>
								</div>
								<div>
									<input class="btn btn-primary" type="button" id="submitBtn"
										value="계정생성"> <input class="btn btn-secondary"
										type="reset" id="staffInputresetBtn" value="입력취소">
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>





	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>