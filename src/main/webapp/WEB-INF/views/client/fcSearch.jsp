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
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<!-- KAKAO API 라이브러리는 추가로 불러서 사용해야 합니다. 아래와 같이 파라메터에 추가하여 로드합니다. -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=LIBRARY"></script>
<!-- services 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services"></script>
<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script>


<style>
input{
background-image: url(/federico/resources/Image/search_black_48dp.svg);
background-position: 95%;
background-repeat: no-repeat;
}
input:placeholder{
align-content: center;
align-items: center;
align-self: center;
}


@font-face {
  font-family: 'Material Icons';
  font-style: normal;
  font-weight: 400;
  src: url(https://example.com/MaterialIcons-Regular.eot); /* For IE6-8 */
  src: local('Material Icons'),
    local('MaterialIcons-Regular'),
    url(https://example.com/MaterialIcons-Regular.woff2) format('woff2'),
    url(https://example.com/MaterialIcons-Regular.woff) format('woff'),
    url(https://example.com/MaterialIcons-Regular.ttf) format('truetype');
}
.material-icons {
  font-family: 'Material Icons';
  font-weight: normal;
  font-style: normal;
  font-size: 24px;  /* Preferred icon size */
  display: inline-block;
  line-height: 1;
  text-transform: none;
  letter-spacing: normal;
  word-wrap: normal;
  white-space: nowrap;
  direction: ltr;

  /* Support for all WebKit browsers. */
  -webkit-font-smoothing: antialiased;
  /* Support for Safari and Chrome. */
  text-rendering: optimizeLegibility;

  /* Support for Firefox. */
  -moz-osx-font-smoothing: grayscale;

  /* Support for IE. */
  font-feature-settings: 'liga';
}
/* Rules for sizing the icon. */
.material-icons.md-18 { font-size: 18px; }
.material-icons.md-24 { font-size: 24px; }
.material-icons.md-36 { font-size: 36px; }
.material-icons.md-48 { font-size: 48px; }

/* Rules for using icons as black on a light background. */
.material-icons.md-dark { color: rgba(0, 0, 0, 0.54); }
.material-icons.md-dark.md-inactive { color: rgba(0, 0, 0, 0.26); }

/* Rules for using icons as white on a dark background. */
.material-icons.md-light { color: rgba(255, 255, 255, 1); }
.material-icons.md-light.md-inactive { color: rgba(255, 255, 255, 0.3); }
.material-icons.md-18 { font-size: 18px; }
.material-icons.md-24 { font-size: 24px; }
.material-icons.md-36 { font-size: 36px; }
.material-icons.md-48 { font-size: 48px; }
.material-icons.md-dark { color: rgba(0, 0, 0, 0.54); }
.material-icons.md-dark.md-inactive { color: rgba(0, 0, 0, 0.26); }

.material-icons.md-light { color: rgba(255, 255, 255, 1); }
.material-icons.md-light.md-inactive { color: rgba(255, 255, 255, 0.3); }

</style>

</head>
<body>
	<!-- Navigation-->
	<%@include file="nav.jsp"%>	
	<!-- Section--> 
	<section  class="comntainer" style="width: 100%; min-height: 100%; background-color: light; padding-bottom: 168px; padding-right:100px; padding-left:100px">
	
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
					매장명</div>
				<div id="clientCurrnetLocation" class="col-sm-3 checked" align="center"
					style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
					onclick="clickEffect('clientCurrnetLocation'); showdiv('clientCurrnetLocation');">
					현위치</div>
			</div>
	
	<!-- 지역명선택시 -->
	<div class="row " id="outer_1" style=" margin-top:50px;">
	    <!-- 지역명 OO시 -->
	   
		<div class="col" style="height: 64px;">
			<select class="form-select form-select-lg" id="majorCity" name="majorCity" aria-label="Default select example">
			  <option selected value="서울">서울시</option>
			  <option value="경기">경기도</option>
			</select>
			pending Item : 좌표찍기
		</div>
		
		<div class="col" style="height: 64px;">
		 <c:if test="${'#majorCity' eq 서울}">
			<select class="form-select form-select-lg" id="minorCity" name="minorCity" onchange="changeMinorCity()" aria-label="Default select example">
			  
			  	  <option value="종로구" selected="selected">종로구</option>
				  <option value="성북구">성북구</option>
				  <option value="동대문구">동대문구</option>
				  <option value="용산구">용산구</option>
				  <option value="강남구">강남구</option>
				  <option value="강동구">강동구</option>
				  <option value="동작구">동작구</option>
				  <option value="영등포구">영등포구</option>
		  	   
			</select>
			</c:if>
			<c:if test="${'#majorCity' eq 경기}">
			<select class="form-select form-select-lg" id="minorCity" name="minorCity" onchange="changeMinorCity()" aria-label="Default select example">
			  
			  	  <option value="성남" selected="selected">성남시</option>
				  <option value="용인">용인시</option>
				  <option value="화성">화성시</option>
				  <option value="수원">수원시</option>
				  <option value="광주">광주시</option>

		  	   
			</select>
			</c:if>
		</div>		
	</div>
	
		
	<!-- 매장명 -->	
	<div class="row" id="outer_2" style="display:none; margin-top:50px;">
		<div class="col " style=" height: 100px; ">
		<div class="search">		
		<input type="text" placeholder="                                              매장명을 입력해주세요."  id="a1" style="border:0;  align-content:center; background-color: #F7F7F7;  width: 100%; height: 80px; font-size: 30px;" 
		>	
		 pending Item : 클릭시 테두리 색상변경(#DC3545), img hover 시 작동, 지도 좌표 연동
		</div>	
		</div>		
	</div>	
	<!-- 현위치 -->
	<div class="row" id="outer_3" style="display:none; margin-top:50px;">
		<div class="col" style=" height: 80px; padding-bottom:100px;">
		<input id="a2" type="text" readonly="readonly" placeholder="                              페데리코가 가장 가까운 곳에서 고객님을 찾아갑니다."  style="border:0;  align-content:center; background-color: #F78181;  width: 100%; height: 80px; font-size: 30px;" 
		>	
		pending Item : 클릭시 테두리 색상변경(#DC3545), img 변경=> '현재위치검색', 실시간 현재위치API 연동, 지도연동
		</div>		
	</div>	
	
	<!-- 지도표시 -->
	<div class="row" style="display:block; margin-top:40px;">
		<div class="col" style="height: 600px; margin-bottom:100px; overflow: hidden;">
		<!-- 지도본체 -->
		<div id="map" style="width:100%;height:100%;"></div>	
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=63fe094a0bad5ef07be77c4f00959da2"></script>
		
		
		</div>		
	</div>
	<div class="row fcLocalName">
		<div class="col" style="background-color: green; height: 800px; padding-bottom:50px;">
		가맹점카드 표시구간</div>		
	</div>	
	
	</section>
		
	<script type="text/javascript">

//1. 지역명/ 가맹점명/ 현위치 나타났다가 사라지는 기능.
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

//2. 지도 표기

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(37.210020, 127.063212), // 지도의 중심좌표 (위도/lnt,경도/lng)
        level: 3 // 지도의 확대 레벨
			    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
	
// 지도의 주소를 가져오라는 요청을 지시할 요청자.
// 1. 지역명 
/*
function changeMinorCity() {
	console.log("minorcity IO Onchange Success");
	var minorCity = $('#minorCity').val();
	var majorCity = $('#majorCity').val();
	console.log($('#majorCity').val());
	console.log($('#minorCity').val());
	
	$.ajax({
		
		url :'fcSearch',
		type:'get',
		data:{ // to clientcontroller
			minorCity:minorCity
			majorCity:majorCity
		},
		success:function(resultData){
			if(resultData.success == 'success'){
				console.log("지도 불러오기 성공!")
			}
			var mnlist = resultData.mnlist;
			$.each(mnlist,function(FranchiseVO, index){
				$('#selectFranchise').append(
						
				)
			})
			
			
			
		},
		error:function(errorData){
			if(resultData.success == 'success'){
				console.log("지도 불러오기 실패")
			}
		}
		
	})// ajax
	
	*/
}// changeMinorCity()
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	</script>
	

	<!-- Footer-->
	<%@include file="footer.jsp"%>
	
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=63fe094a0bad5ef07be77c4f00959da2"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	
</body>
</html>

