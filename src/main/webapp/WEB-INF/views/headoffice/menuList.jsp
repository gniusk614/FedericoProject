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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
   <style type="text/css">
   	
    
   </style>
 
      </head>
<body bgcolor="">
				<div class="container">
				<h1 align="center">메뉴 목록</h1>
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
				<button type="button" class="btn btn-primary me-md-2" data-bs-toggle="modal" data-bs-target="#staticBackdrop" onclick="menuRegistrationf">메뉴등록</button>
  				</div> <!-- d-grid end -->
				</div> <!-- container end -->
				
				<!-- CARD start -->
			<div class="row row-cols-1 row-cols-md-3 g-4">
			<c:forEach var="list" items="${menuList}">
  <div class="col">
    <div class="card">
      <img src="/federico/resources/Image/Tomato-basil_pizza.png" class="card-img-top" alt="...">
      <div class="card-body">
        <h5 class="card-title">${menuName}</h5>
        <p class="card-text">${menuIntro}</p>
	      <div class="d-grid gap-2 d-md-flex justify-content-md-end">
		  <button class="btn btn-primary md-2" type="button" id="menuUpdate" onclick="menuRegistrationf">수정</button>
		  <button class="btn btn-danger" type="button" id="menuDelete">삭제</button>
		</div>
      </div>
    </div>
  </div>
  </c:forEach>
</div> <!--  CARD class="row row-cols-1 row-cols-md-3 g-4" End -->

<!-- Button trigger modal start -->

	
	<!-- Modal start -->
	<div class="container" id="menuRegistration" >
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">MENU REGISTRATION</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="취소"></button>
      </div>
      <div class="modal-body">
      <!-- content start -->
      <select class="form-select form-select-lg mb-3" aria-label="Default select example">
  <option selected>분류(피자 세트 사이드)</option>
  <option value="PIZZA">피자(PIZZA)</option>
  <option value="SET">세트(SET)</option>
  <option value="SIDE">사이드(SIDE)</option>
	</select>
      
 <div class="input-group mb-3">
  <span class="input-group-text" id="menuName">메뉴</span>
  <input type="text" class="form-control" placeholder="메뉴이름을 입력하세요" aria-label="menuName" aria-describedby="basic-addon1">
</div>

<div class="input-group mb-3">
  <span class="input-group-text">가격</span>
  <input type="text" class="form-control" aria-label="Amount (to the nearest won)">
  <span class="input-group-text">￦(원)</span>
</div>

<div class="input-group mb-4">
  <span class="input-group-text" id="basic-addon3">메뉴소개<br>(200자내)</span> <!-- 200자내 글씨크기 작게 -->
  <textarea class="form-control" aria-label="With textarea" aria-describedby="basic-addon3"></textarea> 
</div>

<div class="input-group mb-3">
  <input type="file" class="form-control" id="inputGroupFile02">
  <!-- <label class="input-group-text" for="inputGroupFile02">Upload</label> -->
</div>

<!-- content finish -->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" id="menuReg">등록</button>
      </div>
    </div>
  </div>
</div>
</div> <!-- container class finish -->

</body>
</html>

