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

<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=63fe094a0bad5ef07be77c4f00959da2&libraries=services,clusterer,drawing"></script>

<style>

#a1{
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
	<section  class="container" style="width: 100%; min-height: 100%; background-color: light; padding-bottom: 168px; padding-right:100px; padding-left:100px">
	
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
			onclick="clickEffect('franchiselocation'); showdiv('franchiselocation');">지역명
		</div>
		<div id="franchiseName" class="col-sm-3 checked" align="center"
			style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
			onclick="clickEffect('franchiseName'); showdiv('franchiseName');">매장명
		</div>
		<div id="clientCurrnetLocation" class="col-sm-3 checked" align="center"
			style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
			onclick="clickEffect('clientCurrnetLocation'); showdiv('clientCurrnetLocation');">현위치
		</div>
	</div>
	<!-- 매장명 시작-->	
	<div class="row" id="outer_2" style="display:none; margin-top:50px;">
		<div class="col " style=" height: 100px; ">
			<div class="search">		
				<input type="text" placeholder="                                              매장명을 입력해주세요."  id="a1" 
				style="border:0;  align-content:center; background-color: #F7F7F7;  width: 100%; height: 80px; font-size: 30px;" 
				onkeyup="if(window.event.keyCode==13){a1enter()}"/>	
				 pending Item : 클릭시 테두리 색상변경(#DC3545), img hover 시 작동, 지도 좌표 연동
			</div>	
		</div>		
	</div>
	<!-- 매장명 종료-->
	
	<!-- 매장명 지도 시작 -->
	<script>	
			function a1enter(){
				$.ajax ({
					
					url :'fcSearchLocation',
					type :'get',
					data : {
						fcAddress_keyword : $('#a1').val()
					},
					success : function(data){
							
							console.log("주소 : "+data.list);
							
									if(data.success != null){
									//이 스크립트는 BODY 영역에 작성 한다	
									
									var list = data.list;
									
									var addrs = [];
									var fcId = [];
									var fcPhone = [];

									for(var i = 0 ; i<list.length;i++){
										addrs.push(list[i].fcAddress);
									}
									 
									// 주소-좌표 변환 객체를 생성합니다				
									var geocoder = new kakao.maps.services.Geocoder();
										  			console.log("geok="+geocoder);
									// 지도의 중심좌표를 표시 위치에 따라 재설정 하기위한 bounds 생성	
									var bounds = new kakao.maps.LatLngBounds();	
												console.log("bounds ="+bounds);

									var total = (addrs.length);
					 				console.log("addrs.length = "+total);
									var counter = 0;
					 				console.log("counter");	  

										// Version02 -> 주소를 좌표로 변환하여 배열에 넣고 처리

										var yLat = new Array(); // y 좌표를 담을 배열
										var xLng = new Array(); // x 좌표를 담을 배열
										console.log("cheker");
										for(var i=0; i<total; i++) {
											var address=addrs[i];
											console.log("address =>" + address);
											geocoder.addressSearch(address, function(result, status) {
												console.log("status =>" + status);
												console.log("result =>" + result);
												
												if(status == 'ZERO_RESULT'){
													alert(address+'의 주소가 올바르지 않습니다.');
													return;
												}
												
												if (status === kakao.maps.services.Status.OK) {
													
													yLat[counter] = result[0].y;
													xLng[counter] = result[0].x;
													console.log("counter=>"+counter+'i='+i+'result[0].y='+result[0].y+'result[0].x='+result[0].x );
													counter++;
													if (total===counter) {
														console.log("** geocoder.addressSearch END **");
														//모든 주소의 좌표가 배열로 옮겨졌으면 지도에 marking 한다. 
														markingMap();
													} // if
												} // if	
											}); // geocoder.addressSearch	
										} // for	
										//========== MARKING MAP START============
										function markingMap() {
											  console.log("yLat=>"+yLat);
											  console.log("xLat=>"+xLng);
											for(var i=0; i<total; i++) {
												
												var coords = new kakao.maps.LatLng(yLat[i], xLng[i]);
												console.log('i='+i+'yLat[i]='+yLat[i]+'xLng[i]='+xLng[i]);
												
												var marker = new kakao.maps.Marker({
													map: map,
													position: coords
												}); // marker
												function hideMarkers() {
												    setMarkers(null);    
												}
												// marking 좌표를 포함하도록 영역 정보를 확장한다.
												bounds.extend(coords);
												

											} // for
											map.setBounds(bounds);
										} // function markingMap		
										//========== MARKING MAP FINISH============
//						 				card 밑에 띄우기
										$('#fcInfo').load('fcSearch?card=card #fcInfo');
									} //if(data.success=='success')
									else {								
									alert('해당 지역에 가맹점이 없습니다.');
										}			
											}// success
												, error : function(){
												alert("통신 오류입니다. 다시 시도하세요.")
											}
										})//ajax
									}// function
	</script>
 <!-- 매장명 지도 종료 -->

	
	<!-- 현위치 시작-->
	<div class="row" id="outer_3" style="display:none; margin-top:50px;">
		<div class="col" style=" height: 100px; padding-bottom:100px;">
			<input id="a2" type="text" readonly="readonly" placeholder="                              페데리코가 가장 가까운 곳에서 고객님을 찾아갑니다."  style="border:0;  align-content:center; background-color: #F78181;  width: 100%; height: 80px; font-size: 30px;" 
			 >	
			pending Item : 클릭시 테두리 색상변경(#DC3545), img 변경=> '현재위치검색', 실시간 현재위치API 연동, 지도연동
		<div class="btn btn-danger" onclick="whereami()" >위치</div>
		</div>		
	</div>
	<!-- 현위치 종료-->
	<!-- "C:/Users/19467/Desktop/2.csv"현위치 지도 시작 -->
	<script type="text/javascript">
	// 현위치 좌표 전역변수
	let clat ;
	let clng ;
	
	function whereami(){
		if(navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function(pos){
				
				clat = 36.48018405476181;
				clng = 127.2893820088641;
// 				clat = pos.coords.latitude;//pos.coords.latitude; // 위도 
// 				clng = pos.coords.longitude;//pos.coords.longitude; // 경도
				
				console.log("latitude = " +clat);
				console.log("longitude = " +clng);
				
				mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				   mapOption = {
				       center: new kakao.maps.LatLng(clat, clng), // 지도의 중심좌표
				       level: 3 // 지도의 확대 레벨		
				};
				map = new kakao.maps.Map(mapContainer, mapOption); // 지도에 표시

				var marker = new kakao.maps.Marker({
				    map: map,
				    position: new kakao.maps.LatLng(clat, clng)
				});
				
				fcAllAddress();
				
			});
		} else {alert("어딨는지 모르겠습니다.");}	
		
	}//whereami()
	
	
	
						var address;

	//전체 매장 주소 가져오기.
	function fcAllAddress(){
		
		$.ajax({
				
			url :'fcAllAddress',
			type:'get',
			
			success : function(data) {
				console.log("성공? "+data.list);
				if(data.list != null){
					
					// test
					let fcLatLon = {};
					var Lat = [36.4832761004619,36.5111682851043];
					var Lon = [127.293255435494,127.251674854118];
					for(var i = 0 ; i < Lat.length ; i++){
					fcLatLon.Lat = Lat[i];
					fcLatLon.Lon = Lon[i];
					}
					console.log("fcLatLon : ",fcLatLon);
// 					var fcLatLonlist = [data.list]; // value 주입
					var fcLatLonlist = [];
					fcLatLonlist.push(fcLatLon);
					console.log("fcLatLonlist : ",fcLatLonlist);
					
					var fcMap = [];
					var total = fcLatLonlist.length;
					
					console.log("total : ",total);
					
					var counter = 0;
					
					for(var i=0; i<total; i++) {
					
						fcLatLon.fcYLat = fcLatLonlist[i].Lat;
						fcLatLon.fcXLon = fcLatLonlist[i].Lon;
						fcMap.push(fcLatLon);
						
						var distance = getDistance(clat, clng,fcMap[i].fcYLat,  fcMap[i].fcXLon, "K");
						fcMap[i].distance = distance;
						
						}//for
					
						let newfcMaps = fcMap.sort(function (a, b) {
								  if (a.distance > b.distance) {
									    return 1;
								  }
								  if (a.distance < b.distance) {
								    return -1;
								  }
								  // a must be equal to b
								  return 0;
								});
						console.log('newfcMaps',newfcMaps);
						//지도 위치이동
						
						
						//있다면 검색 시작.
						
					}//if(data.list != null)

			}, // successs
			error : function() {
			}//error
		})//ajax
	}//fcAllAddress() 
	
	function getDistance(lat1, lon1, lat2, lon2, unit) {
		var radlat1 = Math.PI * lat1/180;
		var radlat2 = Math.PI * lat2/180;
		var radlon1 = Math.PI * lon1/180;
		var radlon2 = Math.PI * lon2/180;
		console.log("radlat1", radlat1);
		console.log("radlat2", radlat2);
		console.log("radlon1", radlon1);
		console.log("radlon2", radlon2);
		var theta = lon1-lon2;
		var radtheta = Math.PI * theta/180;
		var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
	
		if (dist > 1) {
			dist = 1;
		}
		
		dist = Math.acos(dist);
		dist = dist * 180/Math.PI;
		dist = dist * 60 * 1.1515;
		
		console.log("1", dist);
		console.log("2", dist);
		console.log("3", dist);
		console.log("4", dist);
		console.log("5", dist);

		if (unit=="K") { dist = dist * 1.609344 }
		if (unit=="N") { dist = dist * 0.8684 }
		return dist;
		
	}//getDistance
	
	
	
	</script>
	<!-- 현위치 지도 종료 -->	
	<!-- 지역명선택시 -->
	<div class="row " id="outer_1" style=" margin-top:50px;">
	    <!-- 지역명 시도, -->	   
		<div class="col" style="height: 64px;">
			<select class="form-select form-select-lg" id="Sido" name="Sido" 
			 aria-label="Default select example" onchange="depth1_change(value)" >
		   	  <option value='none'>시/도 선택</option>
              <option value="강원">강원</option>
              <option value="경기">경기</option>
              <option value="경남">경남</option>
              <option value="경북">경북</option>
              <option value="광주">광주</option>
              <option value="대구">대구</option>
              <option value="대전">대전</option>
              <option value="부산">부산</option>
              <option value="서울">서울</option>
              <option value="세종">세종</option>
              <option value="울산">울산</option>
              <option value="인천">인천</option>
              <option value="전남">전남</option>
              <option value="전북">전북</option>
              <option value="제주">제주</option>
              <option value="충남">충남</option>
              <option value="충북">충북</option>
			</select>
			<div id ="result"></div>
		</div>
		<!-- 지역명 구군 -->
		<div class="col" style="height: 64px;">
			<select class="form-select form-select-lg" id="Gugun" name="Gugun" aria-label="Default select example" onchange="depth2_change(value)">
				<option value="none">지역을 선택하세요.</option>
			</select>			
		</div>	
	</div>
	<!-- 지역명선택 종료 -->
		
		<!-- 지도표시시작 -->
	<div class="row" id="outer_1_map" style="display:block; margin-top:40px;" >
		<div class="col" style="height: 600px; margin-bottom:50px;overflow: hidden;">
		<!-- 지도본체시작 -->
			<div id="map" style="width:100%; height:100%;"></div>	
		<!-- 지도본체종료 -->
		</div>
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=63fe094a0bad5ef07be77c4f00959da2&libraries=services"></script>
		
				
		<script>
		let mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		   mapOption = {
		       center: new kakao.maps.LatLng(37.359515565737276, 127.10538427434284), // 지도의 중심좌표
		       level: 3 // 지도의 확대 레벨		
		};
		    // 지도를 생성합니다    
   		let map = new kakao.maps.Map(mapContainer, mapOption); 

// Depth1 이 바뀌고 depth2에 defualt값으로 들어가는 것도 실행 돼야 하기 때문에
// depth2에 대한 event도 함께 포함한다.

function depth1_change(e){   	
   	// 서울   	
	const SU = ['강남구','강동구','강북구','강서구','관악구','광진구','구로구',
			  '금천구','노원구','도봉구','동대문구','동작구','마포구','서대문구',
			  '서초구','성동구','성북구','송파구','양천구','영등포구','용산구',
			  '은평구','종로구','중구','중랑구'];
	//경기
	const GG = ['고양시 덕양구','고양시 일산구','과천시','광명시','광주시','구리시','군포시',
			'김포시','남양주시','동두천시','부천시 소사구','부천시 오정구','부천시 원미구','성남시 분당구',
			'성남시 수정구','성남시 중원구','수원시 권선구','수원시 장안구',
			'수원시 팔달구','시흥시','안산시 단원구','안산시 상록구','안성시','안양시 동안구',
			'안양시 만안구','오산시','용인시','의왕시','의정부시','이천시','파주시','평택시',
			'하남시','화성시','가평군','양주군','양평군','여주군','연천군','포천군'];
	//인천
	const IC = [ "계양구", "미추홀구", "남동구", "동구", "부평구", "서구", "연수구", "중구", "강화군", "옹진군" ];
	//강원
	const GW =  [ "춘천시", "원주시", "강릉시", "동해시", "태백시", "속초시", "삼척시", "홍천군", "횡성군", "영월군", "평창군", "정선군", "철원군", "화천군", "양구군", "인제군", "고성군", "양양군" ];
	//충남
	const CN =  [ "천안시 동남구", "천안시 서북구", "공주시", "보령시", "아산시", "서산시", "논산시", "계룡시", "당진시", "금산군", "부여군", "서천군", "청양군", "홍성군", "예산군", "태안군" ];
	//충북
	const CB =  [ "청주시 상당구", "청주시 서원구", "청주시 흥덕구", "청주시 청원구", "충주시", "제천시", "보은군", "옥천군", "영동군", "증평군", "진천군", "괴산군", "음성군", "단양군" ];
	//대전
	const DJ = [ "대덕구", "동구", "서구", "유성구", "중구" ] ;
	//세종
	const SJ =  [ "세종특별자치시" ];
	//광주
	const GJ =  [ "광산구", "남구", "동구", "북구", "서구" ];
	//전북
	const JB =  [ "전주시 완산구", "전주시 덕진구", "군산시", "익산시", "정읍시", "남원시", "김제시", "완주군", "진안군", "무주군", "장수군", "임실군", "순창군", "고창군", "부안군" ];
	//전남
	const JN =  [ "목포시", "여수시", "순천시", "나주시", "광양시", "담양군", "곡성군", "구례군", "고흥군", "보성군", "화순군", "장흥군", "강진군", "해남군", "영암군", "무안군", "함평군", "영광군", "장성군", "완도군", "진도군", "신안군" ];
	//경북
	const GB =  [ "포항시 남구", "포항시 북구", "경주시", "김천시", "안동시", "구미시", "영주시", "영천시", "상주시", "문경시", "경산시", "군위군", "의성군", "청송군", "영양군", "영덕군", "청도군", "고령군", "성주군", "칠곡군", "예천군", "봉화군", "울진군", "울릉군" ];
	//경남
	const GN =  [ "창원시 의창구", "창원시 성산구", "창원시 마산합포구", "창원시 마산회원구", "창원시 진해구", "진주시", "통영시", "사천시", "김해시", "밀양시", "거제시", "양산시", "의령군", "함안군", "창녕군", "고성군", "남해군", "하동군", "산청군", "함양군", "거창군", "합천군" ];
	//부산
	const BS =  [ "강서구", "금정구", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구", "기장군" ];
	//대구
	const DG =  [ "남구", "달서구", "동구", "북구", "서구", "수성구", "중구", "달성군" ];
	//울산
	const US =  [ "남구", "동구", "북구", "중구", "울주군" ];
	//제주
	const JJ =  [ "서귀포시", "제주시" ];
	console.log("ID=Sido => "+$('#Sido').val());

	var target = document.getElementById("Gugun");
	
	target.options.length = 0;
	
	if(e == "경기") var Depth2 = GG;						
   	else if(e == "서울")var Depth2 = SU;
   	else if(e == "경남")var Depth2 = GN;
   	else if(e == "경북")var Depth2 = GB;
   	else if(e == "광주")var Depth2 = GJ;
   	else if(e == "대구")var Depth2 = DG;
   	else if(e == "대전")var Depth2 = DJ;
   	else if(e == "부산")var Depth2 = BS;
   	else if(e == "울산")var Depth2 = US;
   	else if(e == "인천")var Depth2 = IC;
   	else if(e == "전남")var Depth2 = JN;
   	else if(e == "전북")var Depth2 = JB;
   	else if(e == "제주")var Depth2 = JJ;
   	else if(e == "충남")var Depth2 = CN;
   	else if(e == "충북")var Depth2 = CB;
   	else if(e == "강원")var Depth2 = GW;
	else if(e == "세종")var Depth2 = SJ;
	
	for (x in Depth2) {
		var option = document.createElement("option");
		option.value = Depth2[x];
		option.innerHTML = Depth2[x];
		target.appendChild(option);
	} // for
	depth2_change($('#Gugun').val());
}// function


//function depth2
function depth2_change(e){
	
	console.log("ID=Gugun => "+$('#Gugun').val());
	
	var Depth2 = e;
	var Depth1 = $('#Sido').val();
	
	$.ajax ({		
		type : 'get',
		url : 'fcSearchArea',
		headers : {Authorization:'KakaoAK {63fe094a0bad5ef07be77c4f00959da2}'},
		data : {
			Depth1 : Depth1 ,
			Depth2 : Depth2		
		},		
		
		success : function(data){
			
			if(data.success=='success'){				
				console.log("data.list : "+ data.list+" <=controller");
				
				if(data.list.length<1){
					alert ("가맹점이 없습니다. \n다시 검색해주세요.")
					return;
				}	
				
				var addrs = [];
				var contents = [];
				var fcPhone = [];
							
				var list = data.list;
				
				for(var i = 0 ; i <list.length ; i++){
					addrs.push(list[i].fcAddress);
					contents.push(list[i].fcId);
				}
			
				console.log("addrs.length =>" + addrs.length);
				console.log("contents =>" + contents);
				
				// 주소-좌표 변환 객체를 생성합니다				
				var geocoder = new kakao.maps.services.Geocoder();
					  			console.log("geok="+geocoder);
				// 지도의 중심좌표를 표시 위치에 따라 재설정 하기위한 bounds 생성	
				var bounds = new kakao.maps.LatLngBounds();	
							console.log("bounds ="+bounds);

				var total = (addrs.length);
 				console.log("addrs.length = "+total);
				var counter = 0;
 				console.log("counter");	  

					// Version02 -> 주소를 좌표로 변환하여 배열에 넣고 처리

					var yLat = new Array(); // y 좌표를 담을 배열
					var xLng = new Array(); // x 좌표를 담을 배열
					console.log("cheker");
					for(var i=0; i<total; i++) {
						var address=addrs[i];
						console.log("address =>" + address);
						geocoder.addressSearch(address, function(result, status) {
													
							if(status == 'ZERO_RESULT'){
								alert(address+'의 주소가 올바르지 않습니다.');
								return;
							}
							
							if (status === kakao.maps.services.Status.OK) {
								
								yLat[counter] = result[0].y;
								xLng[counter] = result[0].x;
								console.log("counter=>"+counter+'i='+i+'result[0].y='+result[0].y+'result[0].x='+result[0].x );
								counter++;
								if (total===counter) {
									console.log("** geocoder.addressSearch END **");
									//모든 주소의 좌표가 배열로 옮겨졌으면 지도에 marking 한다. 
									//지도에 marking
									markingMap();
								} 
							} // if	
						}); // geocoder.addressSearch	
					} // for	
					function markingMap() {
						for(var i=0; i<total; i++) {
						
						var coords = new kakao.maps.LatLng(yLat[i], xLng[i]);
						console.log('i='+i+'yLat[i]='+yLat[i]+'xLng[i]='+xLng[i]);
				
						var marker = new kakao.maps.Marker({
							map: map,
							position: coords
							}); // marker
					
								// marking 좌표를 포함하도록 영역 정보를 확장한다.
								bounds.extend(coords);
								
							} // for
							map.setBounds(bounds);
						} // function markingMap
//	 				card 밑에 띄우기

					$('#fcInfo').load('fcSearch?card=card #fcInfo');	
				} //if(data.success=='success')
				else {								
					alert('해당 지역에 가맹점이 없습니다.');
					}			
						}, error : function(){
							alert("통신 오류입니다. 다시 시도하세요.");
						}
					})//ajax
				}// function
				/*
				function fcCard(){
					$.ajax({
						url :'fcSearchCard',
						type:'get',
						data:{
							if(data == null){return}
							else {
								if($('#Sido').val() != null ||$('#Gugun').val() != null ){
									var Depth1 : $('#Sido').val(),
									var Depth2 : $('#Gugun').val()

								}else if ($('#a1').val() != null){
									var fcAddress_keyword : $('#a1').val()
								}
							}//else			
							},//data 
						success : function (data){
							$('#fcInfo').load('fcSearchCard #fcInfo');							
						},error : function {
							alert("통신 장애");
						}
					}) // ajax
					
				}// function fcCard()
				*/
		</script>	
	</div>
	<!-- 지도표시종료 -->
<!-- 가맹점 조회 카드 시작 -->
		<div id="fcInfo">
			<div class="container" >
				<div class="row align-items-start" id="fcInfo_select">
					<c:forEach var="vo" items="${list}" varStatus="vs">
							<div class="col-6" style="margin-bottom: 40px;">
								<div class="card">
								  <div class="card-body ">
									    <h5 class="card-title" id="fcId">매장명 : ${vo.fcId}</h5>
								        <h5 class="card-title"id="fcPhone">T :${vo.fcPhone}</h5>
									    <p class="card-text"id="fcAddress">주소: ${vo.fcAddress}</p>
									    <button class='btn btn-danger' style="right: auto;"  onclick="fcDetail()">매장정보보기</button>
								  </div>
								</div>
							</div>
					 </c:forEach>
				 </div>
			 </div>	
		 </div>	
<!-- 가맹점 조회 카드 종료 -->
	<div class="row" style="height: 100px"></div>
	</section>
	<script type="text/javascript">
//1. 지역명/ 가맹점명/ 현위치 나타났다가 사라지는 기능. //기능 충돌생김
function showdiv(id) {	
		
	if (id=='franchiselocation'){
		$('#outer_1').css('display','flex');
		$('#outer_2').css('display','none');
		$('#outer_3').css('display','none');
		$('#fcInfo_location').css('display','block');
		$('#fcInfo_Address').css('display','none');
		$('#fcInfo_Cur').css('display','none');
		InputDataClear();
				
	}else if (id=='franchiseName'){
		$('#outer_1').css('display','none');
		$('#outer_2').css('display','flex');
		$('#outer_3').css('display','none');
		$('#fcInfo_location').css('display','none');
		$('#fcInfo_Address').css('display','block');
		$('#fcInfo_Cur').css('display','none');
		InputDataClear();
				
	}else{
		$('#outer_1').css('display','none');
		$('#outer_2').css('display','none');
		$('#outer_3').css('display','flex');
		$('#fcInfo_location').css('display','none');
		$('#fcInfo_Address').css('display','none');
		$('#fcInfo_Cur').css('display','block');
		InputDataClear();
	
	}
		
}// function showdiv(id)

function clickEffect(id){
	$('.checked').css({
		"color" : 'gray',
		"border-bottom" : "1px solid lightgray"
	});

	$('#'+id).css({
		"color" : 'black',
		"border-bottom" : "2px solid black"
	});
	
		
}//function clickEffect(id)

function InputDataClear(){
	$('#Sido').val('none');
	$('#Gugun').val("NONE");
	$('#a1').val('');
	$('#a2').val('');
	$('#fcInfo_select').empty();
	$('#fcInfo_input').empty();
    map = new kakao.maps.Map(mapContainer, mapOption); 
}


</script>		

	<!-- Footer-->
	<%@include file="footer.jsp"%>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->

</body>
</html>

