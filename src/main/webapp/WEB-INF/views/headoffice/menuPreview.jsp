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
<body bgcolor="">
<h1 align="center">메뉴등록</h1>
<div class="continer" id="menuPart">
	<div class="col-xs-1" align="center">
		<div class="col-lg-6 col-md-4 col-sm-5">
			<div class="input-group mb-3">
			  <label class="input-group-text" for="inputGroupSelect01">분류</label>
			  <select class="form-select" id="menuPart"> <!-- inputGroupSelect01 -->
			    <option selected>선택</option>
			    <option value="pizza">피자</option>
			    <option value="setMenu">세트메뉴</option>
			    <option value="sideMenu">사이드메뉴</option>
			  </select>
			</div>
		</div>
	</div>
</div>

<div class="continer" id="menuName">
	<div class="col-xs-1" align="center">
		<div class="col-lg-6 col-md-4 col-sm-5">
			<div class="input-group mb-3">
			  <span class="input-group-text">메뉴이름</span>
			  <input type="text" class="form-control" placeholder="MenuName" aria-label="MenuName" aria-describedby="basic-addon1">
			</div>
		</div>
	</div>
</div>
<div class="continer" id="menuIntro">
	<div class="col-xs-1" align="center">
		<div class="col-lg-6 col-md-4 col-sm-5">
			<div class="input-group mb-3">
			  <span class="input-group-text" id="menuIntro">메뉴소개</span>
			  <input type="text" class="form-control" placeholder="MenuIntro" aria-label="MenuIntro" aria-describedby="basic-addon1">
			</div>
		</div>
	</div>
</div>
<div class="continer" id="menuPrice">
	<div class="col-xs-1" align="center">
		<div class="col-lg-6 col-md-4 col-sm-5">
			<div class="input-group mb-3">
				  <span class="input-group-text">가  격</span>
					  <input type="text" class="form-control" aria-label="Amount">
					  <span class="input-group-text">원</span>
			</div>
		</div>
	</div>
</div>
<div class="continer" id="fileUpload">
	<div class="col-xs-1" align="center">
		<div class="col-lg-6 col-md-4 col-sm-5">
			<div class="input-group mb-3">
			  <label class="input-group-text" for="inputGroupFile01">사진</label>
			  <input type="file" class="form-control" id="inputGroupFile01">
			</div>
		</div>
	</div>
</div>
<div class="continer" id="menuText">
	<div class="col-xs-1" align="center">
		<div class="col-lg-6 col-md-4 col-sm-5">
			<div class="input-group mb-3">
			  <span class="input-group-text">알레르기성분 기재</span>
			  <textarea class="form-control" placeholder="allergy List" aria-label="With textarea"></textarea>
			</div>
		</div>
	</div>
</div>
<div class="continer" id="menuButtons">
	<div class="col-xs-1" align="center">
		<button type="button" oneclick="location.href=" id="menuPreView" class="btn btn-outline-secondary">미리보기</button>&nbsp;&nbsp;&nbsp;
		<button type="button" id="menuRegCompletion" class="btn btn-outline-primary">완료</button>
	</div>
</div>

</body>
</html>

