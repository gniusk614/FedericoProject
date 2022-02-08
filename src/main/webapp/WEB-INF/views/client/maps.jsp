<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>페데리꼬 피자</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"
	crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/inCheck.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.10.19/js/dataTables.bootstrap.min.js"></script>
<style>
/* ** info Design ** */
.label {margin-bottom: 96px;}
.label * {display:inline-block; vertical-align:middle;}
.label .left {background: url("http://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png") no-repeat;display: inline-block;height: 20px;overflow: hidden;vertical-align:middle;width: 7px;}
.label .center {background: url(http://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png) repeat-x;display: inline-block;height: 20px;font-size: 12px;font-weight:bold;line-height: 12px;}
.label .right {background: url("http://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png") -1px 0  no-repeat;display: inline-block;height: 20px;overflow: hidden;width: 6px;}


.checked {
	border-bottom: 2px solid black;
	color: black;
}

.checked .a {
	font-size: large;
	color: gray;
}

.my.pagination > .active > a, 
.my.pagination > .active > span, 
.my.pagination > .active > a:hover, 
.my.pagination > .active > span:hover, 
.my.pagination > .active > a:focus, 
.my.pagination > .active > span:focus {
  background: crimson;
  border-color: crimson;
}
tbody tr {
    cursor: pointer;
}


</style>
</head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<body>
	<!-- Navigation-->
	<%@include file="nav.jsp"%>
	<!-- 본문 시작 -->
	<section class="container py-5"
		style="height: auto; min-height: 100%; padding-bottom: 168px;">

		<div class="container-fluid">
			<div class="row mb-5">
				<div class="col-md-3"></div>
				<div class="col-md-6" align="center">
					<h1 class="display-6">마이페이지</h1>
				</div>
				<div class="col-md-3"></div>
			</div>
			<div class="row justify-content-md-center" style="height: 50px;">
				<div id="orderList" class="col-sm-4 checked" align="center"
					style="font-size: large; color: black; border-bottom: 2px solid black; cursor: pointer;"
					onclick="clickEffect('orderList'); showinfoDiv('myOrderList')">
					주문내역</div>
				<div id="infoUp" class="col-sm-4 checked" align="center"
					style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
					onclick="clickEffect('infoUp');  showinfoDiv('myInfoUp')">정보수정</div>
				<div id="deleteClient" class="col-sm-4 checked" align="center"
					style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
					onclick="clickEffect('deleteClient'); showinfoDiv('deleteMyInfo')">회원탈퇴</div>
			</div>
			<!-- 컨텐츠 -->
			<div id="content">
			<div id="map" style="left:50%; margin-left:-250px; width:500px;height:400px;"></div>
			<script type="text/javascript" 
				src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd110a227c3d8de36931003064d64525&libraries=services">
			</script>
			</div>
		</div>
	</section>
	<!-- footer include -->
	<%--  <%@ include file="footer.jsp"%> --%>

	<script>
	var gps_use = null; //gps의 사용가능 여부
	var gps_lat = null; // 위도
	var gps_lng = null; // 경도
	var gps_position; // gps 위치 객체

	gps_check();
	// gps가 이용가능한지 체크하는 함수이며, 이용가능하다면 show location 함수를 불러온다.
	// 만약 작동되지 않는다면 경고창을 띄우고, 에러가 있다면 errorHandler 함수를 불러온다.
	// timeout을 통해 시간제한을 둔다.
	function gps_check(){
	    if (navigator.geolocation) {
	        var options = {timeout:8000};
	        navigator.geolocation.getCurrentPosition(showLocation, errorHandler, options);
	    } else {
	        alert("GPS_추적이 불가합니다.");
	        gps_use = false;
	    }
	}


	// gps 이용 가능 시, 위도와 경도를 반환하는 showlocation함수.
	function showLocation(position) {
	    gps_use = true;
	    gps_lat = position.coords.latitude;
	    gps_lng = position.coords.longitude;
	    console.log(gps_lat)
		console.log(gps_lng)
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(gps_lat, gps_lng), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		var marker = new daum.maps.Marker({ map: map, position: mapOption.center }); 
	}
	
	
	// error발생 시 에러의 종류를 알려주는 함수.
	function errorHandler(error) {
	    if(error.code == 1) {
	        alert("접근차단");
	    } else if( err.code == 2) {
	        alert("위치를 반환할 수 없습니다.");
	    }
	    gps_use = false;
	}
	
	function gps_tracking(){
	    if (gps_use) {
	        map.panTo(new kakao.maps.LatLng(gps_lat,gps_lng));
	        var gps_content = '<div><img class="pulse" draggable="false" unselectable="on" src="https://ssl.pstatic.net/static/maps/m/pin_rd.png" alt=""></div>';
	        var currentOverlay = new kakao.maps.CustomOverlay({
	            position: new kakao.maps.LatLng(gps_lat,gps_lng),
	            content: gps_content,
	            map: map
	        });
	        currentOverlay.setMap(map);
	    } else {
	      alert("접근차단하신 경우 새로고침, 아닌 경우 잠시만 기다려주세요.");
	      gps_check();
	    }
	}
	
	
	
	
	
	
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="/federico/resources/js/scripts.js"></script>
	<script src="/federico/resources/myLib/client_Script.js"></script>
</body>
</html>