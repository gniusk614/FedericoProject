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
	
	<section style="width: auto; height: 100%;">
	
	<!-- 지도 표시 -->
		<div id="map" style="width:100%;height:90%;position: relative;overflow: hidden;"></div>
		
		<div class="container">
			<input class="form-control me-2" type="search" id="keyword" placeholder="Search" value="">
		
		</div>
		
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=63fe094a0bad5ef07be77c4f00959da2"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
var map = new kakao.maps.Map(mapContainer, mapOption); 
//일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
var mapTypeControl = new kakao.maps.MapTypeControl();
// 지도 타입 컨트롤을 지도에 표시합니다
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

var ps = new kakao.maps.services.Places();

ps.keywordSearch($('#keyword'),placeSearchCB);

function placesSearchCB(data, status, pagination){
	if(status === kakao.maps.services.Status.OK) {
		//검색된 장소 위치를 기준으로 지도범위를 재설정하기 위해
		// Lat(위도),Lng(경도)Bounds 객체에 좌표를 추가합니다.
		var bounds = new kakao.maps.LatLngBounds();
		
		for (var i=0; i<data.length; i++) {
			displayMarker(data[i]);
			bounds.extend(new kakao.maps.LatLng(data[i].y,data[i].x));
			
		}// for
		
		// 검색된 장소위치를 기준으로 지도 범위를 재설정함.		
		map.setBounds(bounds);
		
	}// if(status === ...)
}// function

//마커표시
function displayMarker(place) {
	
	var marker = new kakao.maps.Marker({
		map: map,
		position : new kakao.maps.LatLng(place.y, place.x)
	
	}) // var marker
	
	// 마커 클릭이벤트
	kakao.maps.addListener(marker,'click', function(){
	// 마커를 클릭하면 장소명이 infoWindow에 표시 됨.
	infowindow.setcontent('<div style="padding:5px; font-size:12px;">'+place.place_name+'</div>');
	infowindow.open(map,marker);
		
	}) // 
	
}// function





function getInfo() {
    // 지도의 현재 중심좌표를 얻어옵니다 
    var center = map.getCenter(); 
    
    // 지도의 현재 레벨을 얻어옵니다
    var level = map.getLevel();
    
    // 지도타입을 얻어옵니다
    var mapTypeId = map.getMapTypeId(); 
    
    // 지도의 현재 영역을 얻어옵니다 
    var bounds = map.getBounds();
    
    // 영역의 남서쪽 좌표를 얻어옵니다 
    var swLatLng = bounds.getSouthWest(); 
    
    // 영역의 북동쪽 좌표를 얻어옵니다 
    var neLatLng = bounds.getNorthEast(); 
    
    // 영역정보를 문자열로 얻어옵니다. ((남,서), (북,동)) 형식입니다
    var boundsStr = bounds.toString();

}

</script>
		
	</section>
	

	<!-- Footer-->
	<%@include file="footer.jsp"%>
	
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	
</body>
</html>

