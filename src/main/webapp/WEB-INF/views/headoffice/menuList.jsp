<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Federico Company</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="/federico/resources/css/styles.css"/>
   <style type="text/css">
   	
    
   </style>
 
      </head>
<body bgcolor="">
<!-- navtop inlcud -->
<%@ include file="navtop.jsp" %>

<!-- layoutSidenav 시작 -->
<div id="layoutSidenav">
	<%@ include file="navside.jsp" %>
	<!-- 본문 시작 -->
	
		<h1 align="center">메뉴 목록</h1>
			<c:forEach var="list" items="${menuList}">
				<div class="row row-cols-1 row-cols-md-3 g-4">
				  <div class="col">
				    <div class="card">
				      <img src="${menu.uploadfile}" class="card-img-top" alt="...">
				      <div class="card-body">
				        <h5 class="card-title">${menuName}</h5>
				        <p class="card-text">${menuIntro}</p>
				        <c:if test="${loginID=='admin'}">
				        <div href="#" class="btn btn-primary" id="menuUpdate" >수정</div>
				        <div href="#" class="btn btn-primary" id="menuDelete" >삭제</div>
				        </c:if>
				        <div href="#" class="btn btn-primary" id="menuDetail" >menuDetail</div>
				        <div href="#" class="btn btn-primary" id="menuInCart" >카트담기</div>
				      </div>
				    </div>
				  </div>
				</div>
		</c:forEach> 
	<!-- footer inlcud -->
	<div><%@ include file="footer.jsp" %></div>
</div> <!-- layoutSidenav 끝 -->		
		<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>


</body>
</html>

