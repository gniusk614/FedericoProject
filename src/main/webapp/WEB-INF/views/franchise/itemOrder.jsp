<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페데리꼬 피자</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/franchise_Script.js"></script>
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
					</svg> 자재 발주</h4>
				</div>
				<div class="card-body">
					<div class="dataTable-top" style="padding: 0px;">
						<div class="container-fluid" align="right">	
							<a href="javascript:;" style="color: black; text-decoration: none">
								<svg xmlns="http://www.w3.org/2000/svg" onclick="addSelect()" width="30" height="30" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
								  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
								  <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z"/>
								</svg>
							</a> &nbsp;&nbsp;&nbsp;
							<a href="javascript:;" style="color: black; text-decoration: none">
								<svg xmlns="http://www.w3.org/2000/svg" onclick="removeSelect()" width="30" height="30" fill="currentColor" class="bi bi-dash-circle" viewBox="0 0 16 16">
								  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z"/>
								  <path d="M4 8a.5.5 0 0 1 .5-.5h7a.5.5 0 0 1 0 1h-7A.5.5 0 0 1 4 8z"/>
								</svg>
							</a>
						</div>
					</div>
				</div>
				<!-- table -->
				<table class="table table-striped table-hover">
					<colgroup>
						<col style="width: 10%;"> 
						<col style="width: 15%;"> 
						<col style="width: 20%;"> 
						<col style="width: 15%;"> 
						<col style="width: 10%;"> 
						<col style="width: 10%;"> 
						<col style="width: 20%;"> 
					</colgroup>
					<thead align="center">
						<tr>
							<th>No</th>
							<th>분 류</th>
							<th>품 명</th>
							<th>단 위</th>
							<th>단 가</th>
							<th>수 량</th>
							<th>금 액</th>
						</tr>
					</thead>
					<tbody id="tbody" align="center">
						<tr id="notice"><td colspan="7">+ 버튼을 눌러 행을 추가해주세요.</td></tr>
						<!-- 자재발주 select 추가되는 부분 -->
						
					</tbody>
					<tfoot align="right">
						<tr class="px-5">
							<td class="fw-bold fs-5" colspan="6">합계 : <span id="sumCol"></span> 원</td>
							<td><button class="btn btn-success" onclick="fcItemOrder('${fcId}')">전송</button></td>
						</tr>
							
					</tfoot>
				</table>
			</div>
		</div> <!-- 본문 끝 -->
		
		<!-- footer inlcud -->
		<div><%@ include file="footer.jsp" %></div>
	</div> 
</div> <!-- layoutSidenav 끝 -->			



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>