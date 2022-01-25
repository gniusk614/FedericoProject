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
<style type="text/css">
.img{
	width : 100px ;
	height : 100px ;
}
</style>

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
								<div class="col-sm-2">
									<select class="form-select" aria-label="Default select example" >
										<option value="none" <c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/>>일  반</option>
										<option value="name" <c:out value="${pageMaker.cri.searchType=='name' ? 'selected':''}"/>>메뉴명</option>
										<option value="flag" <c:out value="${pageMaker.cri.searchType=='flag' ? 'selected':''}"/>>분 류<option>
									</select>
								</div>
								<div class="col-sm-2">
										<input class="form-control me-2" type="search"
											placeholder="Search" value="${pageMaker.cri.keyword}" aria-label="Search">
								</div>
								<div class="col-sm-2">
									<button id="menusearchbtn" class="btn btn-outline-primary">검색</button>
								</div>
								<div class="col-sm-4"></div>
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
								<th scope="col" width="20%">메뉴명</th>
								<th scope="col" width="20%">메뉴소개</th>
								<th scope="col" width="10%">가격</th>
								<th scope="col" width="10%">사진</th>
								<th scope="col" width="10%">분류</th>
								<th scope="col" width="20%">수정/삭제</th>
							</tr>
						</thead>
						<!-- 값 표시 -->
						<tbody align="center">
							<c:forEach var="vo" items="${menuList}" varStatus="status">
								<tr>
									<th scope="row">${vo.menuIndex}</th>
									<td>${vo.menuName}</td>
									<td>${vo.menuIntro}</td>
									<td><fmt:formatNumber value="${vo.menuPrice}"/></td>
									<td><img src="${vo.menuImage}" class="img"></td>
									<td>${vo.menuFlag}</td>
									<!--모달창에 수정폼 띄우기  -->
									<!-- data-bs-toggle="modal" data-bs-target="#menuUpdateModal" -->
									<td>  
										  <div class="d-grid gap-2 col-md-6">
											<button type="button" class="btn btn-warning btn-sm" onclick="menuUpdateForm(${vo.menuIndex})">수정</button>
											<button type="button" class="btn btn-info btn-sm" onclick="alert(' 메뉴카드미리보기 / 작업중입니다.')">미리보기</button>
											<button type="button" class="btn btn-danger btn-sm" onclick="menuDelete(${vo.menuIndex})">삭제</button>
										  </div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- 값 표시 -->
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


<!-- 메뉴등록 modal -->
<form action="menuInsert" name="menuInsert" method="post" enctype="multipart/form-data">
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
										  <select class="form-select itemselect" id="menuFlag" name="menuFlag">
										    <option selected value="pizza">피자</option>
										    <option value="sets">세트메뉴</option>
										    <option value="side">사이드</option>
										  </select>
						        		</div> <!-- menuFlagselect -->
							 
										<!-- 메뉴명 -->		
										<div class="input-group mb-3">
										  <span class="input-group-text" id="basic-addon1">메뉴명</span>
										  <input type="text" class="form-control "  id="menuName" name="menuName" value="${vo.menuName}">
										</div>
										<!-- 메뉴소개 -->		
										<div class="input-group mb-3">
										  <span class="input-group-text" id="basic-addon1">메뉴<br>소개</span>
										  <textarea title="메뉴소개" class="form-control "  id="menuIntro" name="menuIntro" value="${vo.menuIntro}" ></textarea>
										</div>
										<!-- 가격 -->
										<div class="input-group mb-3">
										  <span class="input-group-text" id="basic-addon1">가격</span>
										  <input type="text" class="form-control "  id="menuPrice" name="menuPrice" value="${vo.menuPrice}">
										</div>		
						    			<!-- 이미지등록 -->
						    			<div class="input-group mb-3" >
										  <input type="file" class="form-control" name="menuUploadfilef" value="${vo.menuImage}"  multiple >
										  <span id="m_menuinput"></span><br>
										</div>
								</div>
						</div><!-- modal body -->
				  <div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			        <button type="submit" class="btn btn-primary">등록</button>
			      </div>
		    </div>
	  </div>
	</div>
</form>
<!-- 메뉴등록 modal -->


<!-- 메뉴수정 modal -->
<form action="menuUpdate" name="menuUpdate" method="post" enctype="multipart/form-data" id="menuUpdate" >
<div class="modal fade" id="menuUpdatef" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="menuUpdateModalLable">메뉴 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
		<!-- 입력, inputform -->
		
		<!-- menuIndex -->
		<input type="hidden" id="upmenuIndex" name="menuIndex"></input>
	
		<div class="container" id="modalcontrol">
		
			<!-- menuFlag -->
				<div class="input-group mb-3">
				  <label class="input-group-text" for="inputGroupSelect01">분류</label>
				  <select class="form-select menuselect" id="upmenuFlag" name="menuFlag">
				    <option selected value="pizza">피자</option>
				    <option value="sets">세트메뉴</option>
				    <option value="side">사이드</option>
				  </select>
        		</div> 
        			
		 
<!-- 				메뉴명		 -->
					<div class="input-group mb-3">
					  <span class="input-group-text" id="basic-addon1">메뉴명</span>
					  <input type="text" class="form-control "  id="upmenuName" name="menuName" value="${data.menuvo.menuName}">
					</div>
<!-- 				메뉴소개		 -->
					<div class="input-group mb-3">
					  <span class="input-group-text" id="basic-addon1">메뉴<br>소개</span>
					  <textarea title="메뉴소개" class="form-control "  id="upmenuIntro" name="menuIntro" value="${data.menuvo.menuIntro}"></textarea>
					</div>
<!-- 				가격 -->
					<div class="input-group mb-3">
					  <span class="input-group-text" id="basic-addon1">가격</span>
					  <input type="text" class="form-control "  id="upmenuPrice" name="menuPrice" value="${data.menuvo.menuPrice}">
					</div>		
<!--     			이미지수정 -->
				 	<div class="container">
						<div class="row" >
							<div class="col">
				    			<h5 class="card-title" align="center">기존이미지</h5>
				    			<img class="card-img" id="upbeforemenuImage" width="120" height="200" >
				   				</div>
				   			
				    		<div class="col">	 	 	
				    			<h5 class="card-title" align="center">수정이미지</h5>
				    			<div class="input-group mb-3" >
				    			<input type="hidden" id="menuImage" name="menuImage">
								<input type="file" class="form-control" id="menuUploadfilef" name="menuUploadfilef">
								  <span id="m_menuinput"></span><br>
								</div>
								<script type="text/javascript">
								$('#menuUploadfilef').change(function(){
									if(this.files && this.files[0]) {
										var reader = new FileReader;
								 			reader.onload = function(e) {
							 				$(".card-title").attr("src", e.target.result)
							 					.width(100).height(100); 
							 				} // onload_function
							 				reader.readAsDataURL(this.files[0]);
							 		} // if
								}); // change	
								
								
								
								</script>
								
								
							</div>
						</div>
					</div>			
		</div>
<!-- 		option : pizza -->
    </div>
		<div class="modal-footer">
        <button type="submit" class="btn btn-primary">수정</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
       </div>
  </div>
</div>
</div>
</form>
<!-- 메뉴수정 modal -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>