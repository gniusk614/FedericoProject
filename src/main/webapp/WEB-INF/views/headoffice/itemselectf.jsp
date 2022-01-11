<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/headOffice_Script.js"></script>
</head>
<body>
<!-- navtop inlcud -->
<%@ include file="navtop.jsp" %>

<!-- layoutSidenav 시작 -->
<div id="layoutSidenav">
	<%@ include file="navside.jsp" %>
	<!-- 본문 시작 -->
	<div id="layoutSidenav_content">
		<div class="container-fluid px-4" style="margin-top: 20px;">
			<div class="card">
				<div class="card-header">
				<svg class="svg-inline--fa fa-table fa-w-16 me-1" aria-hidden="true"
					focusable="false" data-prefix="fas" data-icon="table" role="img"
					xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
					data-fa-i2svg="">
					<path fill="currentColor"
						d="M464 32H48C21.49 32 0 53.49 0 80v352c0 26.51 21.49 48 48 48h416c26.51 0 48-21.49 48-48V80c0-26.51-21.49-48-48-48zM224 416H64v-96h160v96zm0-160H64v-96h160v96zm224 160H288v-96h160v96zm0-160H288v-96h160v96z"></path></svg>
				자재조회 및 등록
				</div>
				<div class="card-body">
					<div class="dataTable-wrapper dataTable-loading no-footer sortable searchable fixed-columns">
						<div class="dataTable-top">
							<div class="container-fluid">
								<div class="row">
									<div class="col-sm-1">
										<select id="" class="form-select" aria-label="Default select example">
											<option value="none" <c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/>> - - </option>
											<option value="" <c:out value="${pageMaker.cri.searchType=='code' ? 'selected':''}"/>>품 명</option>
											<option value="" <c:out value="${pageMaker.cri.searchType=='name' ? 'selected':''}"/>>분 류<option>
										</select>
									</div>
									<div class="col-sm-2">
											<input class="form-control me-2" type="search"
												placeholder="Search" value="${pageMaker.cri.keyword}" aria-label="Search">
									</div>
									<div class="col-sm-1">
										<button id="itemsearch" class="btn btn-outline-primary">검색</button>
									</div>
									<div class="col-sm-6"></div>
									<div class="col-sm-2" align="right">
										<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#itemInsertModal">
  										자재등록
										</button>
									</div>
								</div>
							</div>
						</div>
					<div class="dataTable-container">
						<table class="table table-striped table-hover">
							<thead>
								<tr>
									<th scope="col">품 번</th>
									<th scope="col">품 명</th>
									<th scope="col">분 류</th>
									<th scope="col">단 위</th>
									<th scope="col">단 가</th>
									<th scope="col">수 정</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="vo" items="${list}" varStatus="status">
									<tr>
										<th scope="row">${vo.itemIndex}</th>
										<td>${vo.itemName}</td>
										<td>${vo.itemFlag}</td>
										<td>${vo.itemUnit}</td>
										<td><fmt:formatNumber value="${vo.itemPrice}"/></td>
										<!--모달창에 수정폼 띄우기  -->
										<!-- data-bs-toggle="modal" data-bs-target="#itemUpdateModal" -->
										<td><span id="itemEditButton" class="btn"  onclick="itemUpdateForm(${vo.itemIndex})">  
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-wrench" viewBox="0 0 16 16">
											  <path d="M.102 2.223A3.004 3.004 0 0 0 3.78 5.897l6.341 6.252A3.003 3.003 0 0 0 13 16a3 3 0 1 0-.851-5.878L5.897 3.781A3.004 3.004 0 0 0 2.223.1l2.141 2.142L4 4l-1.757.364L.102 2.223zm13.37 9.019.528.026.287.445.445.287.026.529L15 13l-.242.471-.026.529-.445.287-.287.445-.529.026L13 15l-.471-.242-.529-.026-.287-.445-.445-.287-.026-.529L11 13l.242-.471.026-.529.445-.287.287-.445.529-.026L13 11l.471.242z"/>
											</svg>										
										</span></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
			<!-- tabel bottom -->				
					<div class="dataTable-bottom">
						<nav class="dataTable-pagination">
							<ul class="pagination">
								<li class="page-item"><a class="page-link" href="#"
									aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
								</a></li>
								<li class="page-item"><a class="page-link" href="#">1</a></li>
								<li class="page-item"><a class="page-link" href="#">2</a></li>
								<li class="page-item"><a class="page-link" href="#">3</a></li>
								<li class="page-item"><a class="page-link" href="#"
									aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</ul>
						</nav>
					</div>
					</div>
				</div>
			</div> 
		</div> 
		<!-- footer inlcud -->
		<div><%@ include file="footer.jsp" %></div>
	</div> <!-- 본문 끝 -->
</div> <!-- layoutSidenav 끝 -->			


<!-- 자재등록 modal -->
<div class="modal fade" id="itemInsertModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="itemInsertModalLable">자재 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<!-- 입력, inputform -->
		<div class="container">
				<!-- 분류 -->	
				<div class="input-group mb-3">
				  <label class="input-group-text" for="inputGroupSelect01">분류</label>
				  <select class="form-select itemselect" id="itemflag">
				    <option selected value="식자재">식자재</option>
				    <option value="부자재">부자재</option>
				  </select>
				</div>			
				<!-- 품명 -->		
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">품명</span>
				  <input type="text" class="form-control w-50"  id="itemname">
				</div>
				<!-- 단위 -->		
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">단위</span>
				  <input type="text" class="form-control"  id="itemunit">
				</div>
				<!-- 단가 -->
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">가격</span>
				  <input type="text" class="form-control"  id="itemprice">
				</div>		
    			<span id="m_iteminput"></span><br>
		</div> <!-- 입력, inputform -->		
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onclick="itemInsertCheck()">등록</button>
      </div>
    </div>
  </div>
</div><!-- 자재등록 modal -->


<!-- 자재 수정 modal -->
<div class="modal fade" id="itemUpdateModal" tabindex="-1" aria-labelledby="itemUpdateModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="itemUpdateModalLable">자재정보 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<!-- 수정폼 -->
		<div class="container">
				<!-- 분류 -->	
				<div class="input-group mb-3">
				  <label class="input-group-text" for="inputGroupSelect01">분류</label>
				  <select class="form-select itemselect" id="upitemflag">
				    <option value="식자재" >식자재</option>
				    <option value="부자재" >부자재</option>
				  </select>
				</div>			
				<!-- 품명 -->			
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">품명</span>
				  <input type="text" class="form-control w-50" id="upitemname" value="${data.vo.itemName}">
				</div>
				<!-- 단위 -->		
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">단위</span>
				  <input type="text" class="form-control"  id="upitemunit" value="${data.vo.itemUnit}">
				</div>
				<!-- 단가 -->
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">가격</span>
				  <input type="text" class="form-control"  id="upitemprice" value="${data.vo.itemPirce}">
				</div>		
    			<span id="m_itemupdate"></span><br>
    			<input type="hidden" id="upitemindex">
		</div> <!-- 수정폼 -->	
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onclick="itemUpdateCheck()">수정</button>
      </div>
    </div>
  </div>
</div><!-- 자재등록 modal -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>