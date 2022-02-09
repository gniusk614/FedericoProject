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
							self.location = "fclist"
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
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-shop" viewBox="0 0 16 16">
  						<path d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.371 2.371 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976l2.61-3.045zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0zM1.5 8.5A.5.5 0 0 1 2 9v6h1v-5a1 1 0 0 1 1-1h3a1 1 0 0 1 1 1v5h6V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5zM4 15h3v-5H4v5zm5-5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1v-3zm3 0h-2v3h2v-3z"/>
					</svg>
						가맹점 리스트
					</div>
					<div class="card-body">
						<div
							class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
							<div class="dataTable-top">
								<div class="container-fluid">
									<div class="row">
										<div class="col-sm-2">
											<select name="searchType" id="searchType" class="form-select"
												onchange="changeSearchFranchiseOption()">
												<option value="none"
													<c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/>>-
													-</option>
												<option value="fcid"
													<c:out value="${pageMaker.cri.searchType=='fcid' ? 'selected':''}"/>>가맹점ID</option>
												<option value="fcname"
													<c:out value="${pageMaker.cri.searchType=='fcname' ? 'selected':''}"/>>점주명</option>
												<option value="phone"
													<c:out value="${pageMaker.cri.searchType=='phone' ? 'selected':''}"/>>연락처</option>
												<option value="area"
													<c:out value="${pageMaker.cri.searchType=='area' ? 'selected':''}"/>>지역</option>
												<option value="address"
													<c:out value="${pageMaker.cri.searchType=='adress' ? 'selected':''}"/>>주소</option>
												<option value="staff"
													<c:out value="${pageMaker.cri.searchType=='staff' ? 'selected':''}"/>>본사담당자</option>
											</select>
										</div>





										<div class="col-sm-3" id="changeSearchFinder">
											<c:if test="${pageMaker.cri.searchType!='area'}">
												<input class="form-control mr-1" type="search" id="keyword"
													placeholder="Search" value="${pageMaker.cri.keyword}">
												<select class="form-select" id="keywordHide"
													style="display: none;">
													<option value="">- -</option>
													<option value="서울"
														<c:out value="${pageMaker.cri.keyword=='서울' ? 'selected':''}"/>>서울</option>
													<option value="경기"
														<c:out value="${pageMaker.cri.keyword=='경기' ? 'selected':''}"/>>경기</option>
													<option value="강원"
														<c:out value="${pageMaker.cri.keyword=='강원' ? 'selected':''}"/>>강원</option>
													<option value="충청"
														<c:out value="${pageMaker.cri.keyword=='충청' ? 'selected':''}"/>>충청</option>
													<option value="전라"
														<c:out value="${pageMaker.cri.keyword=='전라' ? 'selected':''}"/>>전라</option>
													<option value="경상"
														<c:out value="${pageMaker.cri.keyword=='경상' ? 'selected':''}"/>>경상</option>
													<option value="제주"
														<c:out value="${pageMaker.cri.keyword=='제주' ? 'selected':''}"/>>제주</option>
												</select>
											</c:if>
										
											
											
											<c:if test="${pageMaker.cri.searchType=='area'}">
												<input class="form-control  mr-1" type="search"
													id="keywordHide" placeholder="Search"
													value="${pageMaker.cri.keyword}" style="display: none;">
												<select class="form-select" id="keyword">
													<option value="">- -</option>
													<option value="서울"
														<c:out value="${pageMaker.cri.keyword=='서울' ? 'selected':''}"/>>서울</option>
													<option value="경기"
														<c:out value="${pageMaker.cri.keyword=='경기' ? 'selected':''}"/>>경기</option>
													<option value="강원"
														<c:out value="${pageMaker.cri.keyword=='강원' ? 'selected':''}"/>>강원</option>
													<option value="충청"
														<c:out value="${pageMaker.cri.keyword=='충청' ? 'selected':''}"/>>충청</option>
													<option value="전라"
														<c:out value="${pageMaker.cri.keyword=='전라' ? 'selected':''}"/>>전라</option>
													<option value="경상"
														<c:out value="${pageMaker.cri.keyword=='경상' ? 'selected':''}"/>>경상</option>
													<option value="제주"
														<c:out value="${pageMaker.cri.keyword=='제주' ? 'selected':''}"/>>제주</option>
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
											<th scope="col">가맹점ID</th>
											<th scope="col">점주명</th>
											<th scope="col">지 역</th>
											<th scope="col">연락처</th>
											<th scope="col">담당자</th>
											<th scope="col"></th>
										</tr>
									</thead>
									<tbody>
										<c:if test="${! empty message }">
											<tr>
												<td colspan="6" class="fw-bold fs-5">${message}</td>
											</tr>
										</c:if>
										<c:forEach var="list" items="${fcList}">
											<tr>
												<td>${list.fcId}</td>
												<td>${list.fcName}</td>
												<td>${list.fcArea}</td>
												<td>${list.fcPhone}</td>
												<td>${list.hoId}</td>
												
												<td><c:if test="${loginID == list.hoId || loginID == 'admin'}">
												<a id="${list.fcId}" class="fcmodalbtn"
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
												</a></c:if></td>
												
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
							<div class="dataTable-bottom">
								<nav class="dataTable-pagination">
									<ul class="pagination">
										<c:if test="${pageMaker.prev}">
											<li class="page-item"><a class="page-link"
												href="fclist${pageMaker.searchQuery(pageMaker.spageNo-1)}"
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
												<li class="page-item"><a href="fclist${pageMaker.searchQuery(i)}">${i}</a></li>
											</c:if>
										</c:forEach>
										<c:if test="${pageMaker.next}">
											<li class="page-item"><a class="page-link"
												href="fclist${pageMaker.searchQuery(pageMaker.epageNo+1)}"
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



	<!-- 가맹점상세정보 modal -->
	<div class="modal fade" id="fcmodal" role="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">가맹점 상세정보</h5>
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
							가맹점 상세정보 </a>
						</div>
						<div class="card-body">
							<table class="table table-striped">
								<thead>
									<tr>
										<th scope="col" colspan="2">가맹점 ID</th>
										<th scope="col" colspan="2">가맹점주명</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th scope="row" colspan="2"><div id="fcId"></div></th>
										<td colspan="2"><div id="fcName"></div></td>
									</tr>
									<tr>
										<td colspan="5">
											<table class="table mb-0">
												<tr>
													<th scope="col">비밀번호</th>
													<td colspan="3" style="padding: 0px;" align="center">
														<input class="btn btn-primary mb-1" type="button" id="fcPwChange" value="비밀번호 변경" onclick="$('#fcPwChangeModal').modal('show');">
													</td>
												</tr>
												<tr>
													<th scope="col">주 소</th>
													<td colspan="3"><div id="fcAddress"></div></td>
												</tr>
												<tr>
													<th scope="col">연 락 처</th>
													<td colspan="3"><div id="fcPhone"></div></td>
												</tr>
												<tr>
													<th scope="col">담 당 자</th>
													<td colspan="3"><div id="hoid"></div></td>
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
									<button type="button" id="fcCloseBtn"
										class="btn btn-danger pull-left">폐점처리</button>
								</div>
								<div class="col-sm-3"></div>
								<div class="col-sm-6" align="right">
									<input class="btn btn-primary" type="button" id="fcinfoUp"
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


<!-- 비밀번호 수정 modal -->
	<div class="modal fade" id="fcPwChangeModal" role="dialog">
		<div class="modal-dialog modal-dialog-half-centered">
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
										type="password" class="form-control" id="fcLoginPassword"
										placeholder="현재 비밀번호를 확인합니다.">
									<button class="btn btn-outline-secondary" type="button"
										id="fcPwCheck">확인</button>
									<div class="invalid-feedback" id="fclpMessage"></div>
								</div>
								<!-- 맞으면 스크립트에서 ${password}.addclass('is-valid')addclass -->
								<div class="form-group has-success mb-2">
									<label class="form-label">비밀번호</label> <input type="password"
										class="form-control" id="fcPassword"
										placeholder="길이4이상, 영문자, 숫자와 특수문자는 1개 이상 포함"
										disabled="disabled">
									<div class="invalid-feedback" id="fcpMessage"></div>
								</div>
								<!-- 맞으면 스크립트에서 ${passwordRepeat}.addclass('is-valid')addclass -->
								<!-- 틀리면 스크립트에서 ${passwordRepeat}.addclass('is-invalid')addclass -->
								<div class="form-group has-danger mb-2">
									<label class="form-label">비밀번호 확인</label> <input
										type="password" class="form-control" id="fcPasswordRepeat"
										disabled="disabled">
									<div class="invalid-feedback" id="fcprMessage"></div>
								</div>
								<div>
									<br>
								</div>
								<div>
									<input class="btn btn-primary" type="button" id="fcPwUpBtn"
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
	</div><!-- 비밀번호 수정 modal -->





	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>