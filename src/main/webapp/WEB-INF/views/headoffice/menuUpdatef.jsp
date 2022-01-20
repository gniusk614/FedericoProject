<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    </head>
<body>
<!-- Button trigger modal start -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
  메뉴등록
</button>
<!-- Modal start -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">Menu Insert</h5>
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
  <span class="input-group-text" id="basic-addon3">메뉴 소개<br>(200자내)</span> <!-- 200자내 글씨크기 작게 -->
  <textarea class="form-control" aria-label="With textarea" aria-describedby="basic-addon3"></textarea> 
</div>

<div class="input-group mb-3">
  <input type="file" class="form-control" id="inputGroupFile02">
  <!-- <label class="input-group-text" for="inputGroupFile02">Upload</label> -->
</div>

<!-- content finish -->
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Understood</button>
      </div>
    </div>
  </div>
</div>
<!-- modal finish -->



 <!-- ===================== table ======================================= -->


</body>
</html>

