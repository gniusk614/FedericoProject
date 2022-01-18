<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Federico Company</title>
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
	<div id="layoutSidenav_content">
	<!-- 본문 시작 -->
		<div class="container-fluid px-4" style="margin-top: 20px;">
			<div class="card">
				<div class="card-header">
					<h4><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-collection" viewBox="0 0 16 16">
					  <path d="M2.5 3.5a.5.5 0 0 1 0-1h11a.5.5 0 0 1 0 1h-11zm2-2a.5.5 0 0 1 0-1h7a.5.5 0 0 1 0 1h-7zM0 13a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 16 13V6a1.5 1.5 0 0 0-1.5-1.5h-13A1.5 1.5 0 0 0 0 6v7zm1.5.5A.5.5 0 0 1 1 13V6a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5h-13z"/>
					</svg>
				메뉴조회 및 등록</h4>
				</div>
				<div class="card-body">
					<div class="dataTable-top">
						<div class="container-fluid">
							<div class="row">
								<div class="col-sm-1">
									<select id="" class="form-select" aria-label="Default select example">
										<option value="none" <c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/>> - - </option>
										<option value="name" <c:out value="${pageMaker.cri.searchType=='name' ? 'selected':''}"/>>메뉴명</option>
										<option value="flag" <c:out value="${pageMaker.cri.searchType=='flag' ? 'selected':''}"/>>분 류<option>
									</select>
								</div>
								<div class="col-sm-2">
										<input class="form-control me-2" type="search"
											placeholder="Search" value="${pageMaker.cri.keyword}" aria-label="Search">
								</div>
								<div class="col-sm-2">
									<button id="menusearch" class="btn btn-outline-primary">검색</button>
								</div>
								<div class="col-sm-5"></div>
								<div class="col-sm-2" align="right">
									<button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#menuInsertModal">
 										메뉴등록
									</button>
								</div>
							</div>
						</div>
					</div>
					<!-- table -->
					<table id="t_menuselect" class="table table-striped table-hover">
						<thead align="center">
							<tr>
								<th scope="col" width="5%">번호</th>
								<th scope="col" width="25%">메뉴명</th>
								<th scope="col" width="25%">메뉴소개</th>
								<th scope="col" width="15%">가격</th>
								<th scope="col" width="20%">사진</th>
								<th scope="col" width="10%">수정/삭제</th>
							</tr>
						</thead>
						<tbody align="center">
							<c:forEach var="vo" items="${list}" varStatus="status">
								<tr>
									<th scope="row">${vo.menuIndex}</th>
									<td>${vo.menuName}</td>
									<td>${vo.menuIntro}</td>
									<td><fmt:formatNumber value="${vo.menumPrice}"/></td>
									<td>${vo.menuImage}</td>
									<td>${vo.menuFlag}</td>
									<!--모달창에 수정폼 띄우기  -->
									<!-- data-bs-toggle="modal" data-bs-target="#menuUpdateModal" -->
									<td><span id="menuEditButton" class="btn"  onclick="menuUpdateForm(${vo.menuIndex})">  
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-wrench" viewBox="0 0 16 16">
										  <path d="M.102 2.223A3.004 3.004 0 0 0 3.78 5.897l6.341 6.252A3.003 3.003 0 0 0 13 16a3 3 0 1 0-.851-5.878L5.897 3.781A3.004 3.004 0 0 0 2.223.1l2.141 2.142L4 4l-1.757.364L.102 2.223zm13.37 9.019.528.026.287.445.445.287.026.529L15 13l-.242.471-.026.529-.445.287-.287.445-.529.026L13 15l-.471-.242-.529-.026-.287-.445-.445-.287-.026-.529L11 13l.242-.471.026-.529.445-.287.287-.445.529-.026L13 11l.471.242z"/>
										</svg>										
									</span></td>
								</tr>
							</c:forEach>	
						</tbody>
					</table>
			<!-- tabel bottom -->				
					<div class="dataTable-bottom">
						<nav class="dataTable-pagination">
							<ul class="pagination">
								<li class="page-item"><a class="page-link" href="#"
									aria-label="Previous"> <span aria-hidden=true>&laquo;</span>
								</a></li>
									<c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
										<c:if test="${i==pageMaker.cri.currPage}">
										<li class="page-item active" aria-current="page"><a class="page-link">${i}</a></li>
										</c:if>
										<c:if test="${i!=pageMaker.cri.currPage}">
										<li class="page-item"><a href="menuselect${pageMaker.searchQuery(i)}">${i}</a></li>
										</c:if>
									</c:forEach>
									<li class="page-item"><a class="page-link" href="#" aria-label="Next"> <span aria-hidden="true">&raquo;</span>
								</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div> 
		</div> 
		<!-- footer inlcud -->
		<div><%@ include file="footer.jsp" %></div>
	</div> <!-- 본문 끝 -->
</div> <!-- layoutSidenav 끝 -->			


<!-- 자재등록 modal -->
<form action="insertMenu" method="post" enctype="multipart/form-data" id="myForm">
<div class="modal fade" id="menuInsertModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="menuInsertModalLable">메뉴 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<!-- 입력, inputform -->
		
		<!-- 분류 -->	
		<div class="container" id="modalcontrol">
				<div class="input-group mb-3">
				  <label class="input-group-text" for="inputGroupSelect01">분류</label>
				  <select class="form-select itemselect" id="menuFlag">
				    <option selected value="pizza">피자</option>
				    <option value="sets">세트메뉴</option>
				    <option value="side">사이드</option>
				  </select>
        		</div> <!-- menuFlagselect -->
		 
				<!-- 메뉴명 -->		
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">메뉴명</span>
				  <input type="text" class="form-control "  id="menuName">
				</div>
				<!-- 메뉴소개 -->		
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">메뉴<br>소개</span>
				  <textarea title="메뉴소개" class="form-control "  id="menuIntro"></textarea>
				</div>
				<!-- 가격 -->
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">가격</span>
				  <input type="text" class="form-control "  id="menuPrice">
				</div>		
    			<!-- 이미지등록 -->
    			<div class="input-group mb-3">
				  <input type="file" class="form-control" name="uploadfilef" id="uploadfilef" aria-describedby="inputGroupFileAddon04" aria-label="Upload" multiple>
				  <button class="btn btn-outline-secondary" type="button" id="inputGroupFileAddon04">전송</button>
				  <span id="m_menuinput"></span><br>
				</div>
				
		</div><!-- option : pizza -->
		
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" onclick="menuInsert()">등록</button>
      </div>
    </div>
  </div>
</div>
</div><!-- 자재등록 modal -->
</form>
<!-- 자재 수정 modal -->
<div class="modal fade" id="menuUpdateModal" tabindex="-1" aria-labelledby="menuUpdateModal" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="menuUpdateModalLable">자재정보 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<!-- 수정폼 -->
		<div class="container">
				<!-- 분류 -->	
				<div class="input-group mb-3">
				  <label class="input-group-text" for="inputGroupSelect01">분류</label>
				  <select class="form-select itemselect" id="upmenuflag">
				    <option value="식자재" >식자재</option>
				    <option value="부자재" >부자재</option>
				  </select>
				</div>			
				<!-- 품명 -->			
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">품명</span>
				  <input type="text" class="form-control w-50" id="upmenuname" value="${data.vo.menuName}">
				</div>
				<!-- 단위 -->		
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">단위</span>
				  <input type="text" class="form-control"  id="upmenuunit" value="${data.vo.menuUnit}">
				</div>
				<!-- 단가 -->
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">가격</span>
				  <input type="text" class="form-control"  id="upmenuprice" value="${data.vo.menuPirce}">
				</div>		
    			<span id="m_menuupdate"></span><br>
    			<input type="hidden" id="upmenuindex">
		</div> <!-- 수정폼 -->	
      </div>
      <div class="modal-footer">
      	<div class="container-fluid">
      		<div class="row">
      			<div class="col-3"><button type="button" class="btn btn-danger pull-left" onclick="menuDelete()">삭제</button></div>
      			<div class="col-5"></div>
      			<div class="col-4"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
    		    <button type="button" class="btn btn-primary" onclick="itemUpdateCheck()">수정</button></div>
			</div>
		</div>
      </div>
    </div>
  </div>
</div><!-- 자재 수정 modal -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>