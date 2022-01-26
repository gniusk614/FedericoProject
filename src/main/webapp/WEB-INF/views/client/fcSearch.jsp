<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>페데리꼬 피자</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
	
<script src="/federico/resources/js/scripts.js"></script>
<script src="/federico/resources/myLib/client_Script.js"></script>	
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<!-- KAKAO API 라이브러리는 추가로 불러서 사용해야 합니다. 아래와 같이 파라메터에 추가하여 로드합니다. -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
<!-- services 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>

<style>

</style>

</head>
<body>
	<!-- Navigation-->
	<%@include file="nav.jsp"%>	
	<!-- Section--> 
	<section  class="comntainer" style="width: 100%; min-height: 100%; background-color: light; padding-bottom: 168px; padding-right:40px; padding-left:40px">
	
	<div class="row">
		<div class="col"></div>
			<div class="col-10 d-flex justify-content-center m-5">
				<h1 class="display-6">
				<a href="fcSearch">매장찾기</a></h1>
			</div>
		<div class="col"></div>
	</div>
	<div class="row justify-content-md-center" style="height: 50px;">
				<div id="franchiselocation" class="col-sm-3 checked" align="center"
					style="font-size: large; color: black; border-bottom: 2px solid black; cursor: pointer;"
					onclick="clickEffect('franchiselocation'); showdiv('franchiselocation');">
					지역명</div>
				<div id="franchiseName" class="col-sm-3 checked" align="center"
					style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
					onclick="clickEffect('franchiseName'); showdiv('franchiseName');">
					가맹점명</div>
				<div id="clientCurrnetLocation" class="col-sm-3 checked" align="center"
					style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
					onclick="clickEffect('clientCurrnetLocation'); showdiv('clientCurrnetLocation');">
					현위치</div>
			</div>
	
	<!-- 지역명선택시 -->
	<div class="row " id="outer_1" style=" margin-top:50px;">
	    <!-- 지역명 OO시 -->
		<div class="col">
			<select class="form-select" aria-label="Default select example">
			  <option selected>서울특별시</option>
			  <option value="ggd">경기도</option>
			  <option value="ccbd">충청북도</option>
			  <option value="ccnd">충청남도</option>
			  <option value="gwd">강원도</option>
			  <option value="gsbd">경상북도</option>
			  <option value="gsnd">경상남도</option>
			  <option value="jjd">제주도</option>			  
			</select>
		</div>
		<div class="col">
			<select class="form-select" aria-label="Default select example">
			  <option selected>서울특별시</option>
			  <option value="ggd">경기도</option>
			  <option value="ccbd">충청북도</option>
			  <option value="ccnd">충청남도</option>
			  <option value="gwd">강원도</option>
			  <option value="gsbd">경상북도</option>
			  <option value="gsnd">경상남도</option>
			  <option value="jjd">제주도</option>			  
			</select>
		</div>	
	</div>
	<!-- 매장명 -->	
	<div class="row" id="outer_2" style="display:none; margin-top:50px;">
		<div class="col " style="background-color: #c8707e; height: 80px; padding-bottom:100px;">
		매장명 선택시 표시</div>		
	</div>	
	<!-- 현위치 -->
	<div class="row" id="outer_3" style="display:none; margin-top:50px;">
		<div class="col" style="background-color: #9900ff; height: 80px; padding-bottom:100px;">
		현위치 선택시 표시</div>		
	</div>	
	<!-- 지도표시 -->
	<div class="row map" style="display:block; margin-top:50px;">
		<div class="col" style="background-color: #ffffdd; height: 800px; padding-bottom:100px;">
		지도표시</div>		
	</div>
	<div class="row fcLocalName">
		<div class="col" style="background-color: green; height: 800px; padding-bottom:50px;">
		가맹점카드 표시구간</div>		
	</div>
	
	
	
	
	
	
	
	
	
	
	
	</section>
	
	<script type="text/javascript">

	
function showdiv(id) {	
	if (id=='franchiselocation'){
		$('#outer_1').css('display','flex');
		$('#outer_2').css('display','none');
		$('#outer_3').css('display','none');
	} else if (id=='franchiseName'){
		$('#outer_1').css('display','none');
		$('#outer_2').css('display','block');
		$('#outer_3').css('display','none');
	}else {
		$('#outer_1').css('display','none');
		$('#outer_2').css('display','none');
		$('#outer_3').css('display','block');
	}
}// function showdiv(id)
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	</script>
	

	<!-- Footer-->
	<%@include file="footer.jsp"%>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=63fe094a0bad5ef07be77c4f00959da2"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	
</body>
</html>

