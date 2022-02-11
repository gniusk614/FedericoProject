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

.info-title {
    display: block;
    background: #50627F;
    color: #fff;
    text-align: center;
    height: 24px;
    line-height:22px;
    border-radius:4px;
    padding:0px 10px;
}

.position {
height: 100px; 
padding-bottom:100px;
}

.pos_span{
position :relative;
border: 0.5px solid;
align-content:center;
background-color: #84E0E0;
width: 100%;
height: 80px;
font-size: 30px;
}

#pos_btn {
position: relative;
left: 85%;
top: -15px;    
}

#pos_h3 {
position : relative;
left: 3%;
top: 33px;
}


/* #a1{ */
/* background-image: url(/federico/resources/Image/search_black_48dp.svg); */
/* background-position: 90%; */
/* background-repeat: no-repeat; */
/* } */

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
			style="font-size: large; color: black; border-bottom: 2px solid #DC3545; cursor: pointer;"
			onclick="clickEffect('franchiselocation'); showdiv('franchiselocation');">지역명
		</div>
		<div id="franchiseName" class="col-sm-3 checked" align="center"
			style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
			onclick="clickEffect('franchiseName'); showdiv('franchiseName');">주소명
		</div>
		<div id="clientCurrnetLocation" class="col-sm-3 checked" align="center"
			style="font-size: large; color: gray; border-bottom: 1px solid lightgray; cursor: pointer;"
			onclick="clickEffect('clientCurrnetLocation'); showdiv('clientCurrnetLocation');">현위치
		</div>
	</div>
	<!-- 주소명 시작-->	
	<div class="row" id="outer_2" style="display:none; margin-top:50px;">
		<div class="col " style=" height: 100px; ">
			<div class="search">		
				<input type="text" placeholder="   					지역명을 입력해주세요." id="a1" 
				style="border:0;  align-content:center; background-color: #F7F7F7;  width: 100%; height: 80px; font-size: 30px;" 
				onkeyup="if(window.event.keyCode==13){a1enter()}; $('#fcInfo_all').empty();"/>	
				<img src="/federico/resources/Image/search_black_48dp.svg" style="position: relative; left: 90%; bottom: 65px; cursor: pointer;"
					onclick="a1enter(); $('#fcInfo_all').empty();">
			</div>	
		</div>		
	</div>
	<!-- 주소명 종료-->
	
	<!--  지도 시작 -->
	
	<script>	
	
	let markers= [];
	
	let icon = new kakao.maps.MarkerImage(
		    '/federico/resources/Image/LOGO.png',
		    new kakao.maps.Size(31, 35)// size
		);
	
	let cicon = new kakao.maps.MarkerImage(
		    '/federico/resources/Image/cicon.png',
		    new kakao.maps.Size(35, 40)// size
		);
	
	
			function a1enter(){
				// 입력 안했을 시.
				if($('#a1').val().length < 1 ){
					alert("지역명 또는 주소를 입력해주세요");
					return false;
				}
				else {
			            if($('#a1').val() == " ") // 공백 체크
			            {              
			                alert("해당 항목에는 공백을 사용할 수 없습니다.");
			                return false;
			            }
				} // else
					
				$.ajax ({
					
					url :'fcSearchLocation',
					type :'get',
					data : {
						fcAddress_keyword : $('#a1').val()
					},
					success : function(data){
							
							console.log("주소 : "+data.list);
							console.log("data.success : "+data.list);
							
									if(data.success == 'success'){
									//이 스크립트는 BODY 영역에 작성 한다	
									setMarkers();
									var list = data.list;
									var addrs = [];

										for(var i = 0 ; i<list.length;i++){
											var fc = {};
	
											fc.fcAddress=list[i].fcAddress;
											fc.fcId=list[i].fcId;
											fc.fcPhone=list[i].fcPhone;
											fc.ylat=list[i].lat;
											fc.xlon=list[i].lon;
											
											addrs.push(fc);
											console.log("addrs.length = ",addrs.length);
											
											}
										
									// 지도의 중심좌표를 표시 위치에 따라 재설정 하기위한 bounds 생성	
									var bounds = new kakao.maps.LatLngBounds();	
									var total = (addrs.length);
									console.log("total",total);
									var counter = 0;
									markingMap();
// ========================================== 프랜차이즈 마킹 시작 !! =================================================
										
										function markingMap() {
										
											for(var i=0; i<total; i++) {
												console.log("for_total",total);
												var coords = new kakao.maps.LatLng(addrs[i].ylat, addrs[i].xlon);
												console.log('i='+i+'yLat[i]='+addrs[i].ylat+' xLng[i]='+addrs[i].xlon+' fcId =',addrs[i].fcId);
													// marking 좌표를 포함하도록 영역 정보를 확장한다.
													bounds.extend(coords);
													
													// 마커를 생성합니다
												    	marker = new kakao.maps.Marker({
												        map: map, // 마커를 표시할 지도
												        position: coords,// 마커의 위치
												        image : icon
												    });
													
												    // 마커에 표시할 인포윈도우를 생성합니다 
												    	infowindow = new kakao.maps.InfoWindow({
											    		content: addrs[i].fcId // 인포윈도우에 표시할 내용
												    });

												    // 마커에 이벤트를 등록하는 함수 만들고 즉시 호출하여 클로저를 만듭니다
												    // 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
												    (function(marker, infowindow) {
												        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
												        kakao.maps.event.addListener(marker, 'mouseover', function() {
												            infowindow.open(map, marker);
												        });

												        // 마커에 mouseout 이벤트를 등록하고 마우스 아웃 시 인포윈도우를 닫습니다
												        kakao.maps.event.addListener(marker, 'mouseout', function() {
												            infowindow.close();
												        });
												    })(marker, infowindow);
												    
												    
// ========================================== 카드 시작 !! =========================================================			
											    console.log("현위치 카드 시작 확인")
											    
												$('#fcInfo_all').append(
														'<div class="col-6" style="margin-bottom: 40px;">'+
														'<div class="card" style="border : 1px solid #DC3545; ">'+
														  '<div class="card-body ">'+
															   ' <h5 class="card-title" id="fcId">주소명 :'+ addrs[i].fcId+' 점 </h5>'+
														        '<h5 class="card-title"id="fcPhone">T :'+addrs[i].fcPhone+'</h5>'+
															    '<p class="card-text"id="fcAddress">주소:'+ addrs[i].fcAddress+'</p>'+
// 															   ' <button class="btn btn-danger" style="right: auto;"  onclick="fcDetail()">매장정보보기</button>'+
														  "</div></div></div>")
// ========================================== 카드 종료 !! =========================================================													
												} // for 4 end
											map.setBounds(bounds);
										} // function markingMap
// ========================================== 프랜차이즈 마킹 종료 !! =================================================

									} else alert('검색하신 지역에 가맹점이 없습니다.');
																		
							},// success
										 error : function(){
										alert("통신 오류입니다. 다시 시도하세요.")
						}
					})//ajax
				}// function
	</script>
 <!-- 주소명 지도 종료 -->

	
	<!-- 현위치 시작-->
	<div class="row" id="outer_3" style="display:none; margin-top:50px;">
		<div class="col position" style="background-color: #E8F3F7;">
		<h3 id="pos_h3">가까운 페데리코를 찾아드립니다.</h3>
		<span class="btn btn-danger btn-lg" id="pos_btn" onclick="whereami(); $('#fcInfo_all').empty(); setMarkers();">현재위치</span>
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
				
				clat = pos.coords.latitude; // 위도 
				clng = pos.coords.longitude;// 경도
				
				console.log("현위치 위도 = ",clat);
				console.log("현위치 경도 = " +clng);
				
					mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				   	   mapOption = {
					       center: new kakao.maps.LatLng(clat, clng), // 지도의 중심좌표
					};
					map = new kakao.maps.Map(mapContainer, mapOption); // 지도에 표시

					marker = new kakao.maps.Marker({
				    map: map,
				    position: new kakao.maps.LatLng(clat, clng),
				    image:cicon
				});
					
				// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
				var iwContent = '<div style="padding:5px;">여기에 계신가요?</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
			    iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다	
					
				// 인포윈도우를 생성합니다
					infowindow = new kakao.maps.InfoWindow({
				    content : iwContent,
				    removable : iwRemoveable
				});	
				// 마커에 클릭이벤트를 등록합니다
				kakao.maps.event.addListener(marker, 'click', function() {
				      // 마커 위에 인포윈도우를 표시합니다
				      infowindow.open(map, marker);  
				});
				
					
				fcAllAddress();
				
			});
			
			function error(err) {
				alert("위치를 찾지 못했습니다.");
				}
			
		} else {alert("위치를 찾지 못했습니다.");}	
		
	}//whereami()

	//전체 매장 주소 가져오기.
	function fcAllAddress(){
		
		$.ajax({
				
			url :'fcAllAddress',
			type:'post',
			
			success : function(data) {
				console.log("성공!! ",data.list);
				if(data.list != null){
					
					
					
					var list = data.list;					
					var fcIdList = [];
					var LatLonList = [];					
					var fcId = {};
					
					for(var i = 0; i < list.length ; i++){ // for 1
						
						var LatLon = {};
						
						LatLon.Lat = data.list[i].lat;
						LatLon.Lon = data.list[i].lon;
						LatLon.fcId = data.list[i].fcId;
						LatLon.fcAddress = data.list[i].fcAddress;
						LatLon.fcPhone = data.list[i].fcPhone;
						
						
						LatLonList.push(LatLon);
						
					}// for 1
					
					var counter = 0;
					const searchDistance = 5; // 찾을거리 설정.(km)
					
					for(var i=0; i<LatLonList.length; i++) { // for 2
							console.log("i",i);
							console.log("lengh",LatLonList.length);
							let distance = getDistance(clat, clng, LatLonList[i].Lat, LatLonList[i].Lon, "K");

							if (distance > searchDistance ) {
								LatLonList.splice(i,1);
								i--;
							} else{
								LatLonList[i].distance = distance;
							}
							
					}//for 2
					
							let newLatLonList = LatLonList.sort(function (a, b) {
									  if (a.distance > b.distance) {
										return 1;
									  }
									  if (a.distance < b.distance) {
									    return -1;
									  }
									  // a must be equal to b
									  return 0;
									});
							
							//지도 위치이동
							//있다면 검색 시작.
// ========================================== 프랜차이즈 마킹 시작 !! =================================================
						
						for (var i = 0 ; i < newLatLonList.length;i++ ){ // for 4 start
							
								console.log("가장가까운 거리의 지점 : ",newLatLonList[i].fcId);
							// 마커를 생성합니다
						    	marker = new kakao.maps.Marker({
						        map: map, // 마커를 표시할 지도
						        position: new kakao.maps.LatLng(newLatLonList[i].Lat, newLatLonList[i].Lon), // 마커의 위치
						    	image:icon
						    });
						    // 마커에 표시할 인포윈도우를 생성합니다 
						    	infowindow = new kakao.maps.InfoWindow({
						        content: newLatLonList[i].fcId // 인포윈도우에 표시할 내용
						    });

						    // 마커에 이벤트를 등록하는 함수 만들고 즉시 호출하여 클로저를 만듭니다
						    // 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
						    (function(marker, infowindow) {
						        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
						        kakao.maps.event.addListener(marker, 'mouseover', function() {
						            infowindow.open(map, marker);
						        });

						        // 마커에 mouseout 이벤트를 등록하고 마우스 아웃 시 인포윈도우를 닫습니다
						        kakao.maps.event.addListener(marker, 'mouseout', function() {
						            infowindow.close();
						        });
						    })(marker, infowindow);
 // ========================================== 프랜차이즈 마킹 종료 !! =================================================				
 // ========================================== 현위치 카드 시작 !! =================================================			
						    
							$('#fcInfo_all').append(
									'<div class="col-6" style="margin-bottom: 40px;">'+
									'<div class="card" style="border : 1px solid #DC3545; ">'+
									  '<div class="card-body ">'+
										   ' <h5 class="card-title" id="fcId">주소명 :'+ newLatLonList[i].fcId+' 점 </h5>'+
									        '<h5 class="card-title"id="fcPhone">T :'+newLatLonList[i].fcPhone+'</h5>'+
										    '<p class="card-text"id="fcAddress">주소:'+ newLatLonList[i].fcAddress+'</p>'+
// 										   ' <button class="btn btn-danger" style="right: auto;"  onclick="fcDetail()">매장정보보기</button>'+
									  "</div></div></div>"
 // ========================================== 현위치 카드 종료 !! =================================================	
							);
							
						} // for 4 end
					
				}//if(data.list != null)
					
			}, // successs
			
					error : function() {
				
			}//error
			
		})//ajax
		
	}//fcAllAddress() 
	
// 거리계산기능
	function getDistance(lat1, lon1, lat2, lon2, unit) {
		if ((lat1 == lat2) && (lon1 == lon2)) {
			return 0;
		}// if
		else {
			var radlat1 = Math.PI * lat1/180;
			//console.log("*** start radlat1 =", radlat1);
			
			var radlat2 = Math.PI * lat2/180;
			//console.log("radlat2 =", radlat2);
			
			var theta = lon1-lon2;
			//console.log("theta = lon1-lon2 =", theta = lon1-lon2);
			
			var radtheta = Math.PI * theta/180;
			//console.log("radtheta =", radtheta);
			
			var dist = Math.sin(radlat1) * Math.sin(radlat2) + Math.cos(radlat1) * Math.cos(radlat2) * Math.cos(radtheta);
			//console.log("dist =", dist);
			
			if (dist > 1) {
				dist = 1;
			}
			dist = Math.acos(dist);
			//console.log("dist = Math.acos(dist) =", dist);
			
			dist = dist * 180/Math.PI;
			//console.log("dist * 180/Math.PI =", dist);
			
			dist = dist * 60 * 1.1515;
// 			console.log("*** final dist = dist * 60 * 1.1515 =", dist);
			
			if (unit=="K") { dist = dist * 1.609344 }
			if (unit=="N") { dist = dist * 0.8684 }
			return dist;
		}// else
	}//getDistance
	
	
	
	</script>
	<!-- 현위치 지도 종료 -->	
	<!-- 지역명선택시 -->
	<div class="row " id="outer_1" style=" margin-top:50px;">
	    <!-- 지역명 시도, -->	   
		<div class="col" style="height: 64px;">
			<select class="form-select form-select-lg" id="Sido" name="Sido" 
			 aria-label="Default select example" onchange="depth1_change(value); $('#fcInfo_all').empty();" >
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
			<select class="form-select form-select-lg" id="Gugun" name="Gugun" aria-label="Default select example" onchange="depth2_change(value); $('#fcInfo_all').empty();">
					
				<option value="none">지역을 선택하세요.</option>
			</select>			
		</div>	
	</div>
	<!-- 지역명선택 종료 -->
		
		<!-- 지도표시시작 -->
	<div class="row" id="outer_1_map" style="display:block; margin-top:40px;" >
		<div class="col" style="height: 600px; margin-bottom:50px;overflow: hidden;">
		<!-- 지도본체시작 -->
			<div id="map" style="width:100%; height:100%; border: 1px solid #DC3545;"></div>	
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
				$('#fcInfo_all').empty();
				
				if(data.list.length<1){
					alert ("가맹점이 없습니다. \n다시 검색해주세요.")
					return;
				}	
				setMarkers();
				var addrs = [];
				var contents = [];
				var fcPhone = [];
							
				var list = data.list;
				
				for(var i = 0 ; i<list.length;i++){
					
					var fc = {};

					fc.fcAddress=list[i].fcAddress;
					fc.fcId=list[i].fcId;
					fc.fcPhone=list[i].fcPhone;
					fc.ylat=list[i].lat;
					fc.xlon=list[i].lon;
					
					addrs.push(fc);
					console.log("addrs.length = ",addrs.length);
					
					}// for
				
				// 지도의 중심좌표를 표시 위치에 따라 재설정 하기위한 bounds 생성	
				var bounds = new kakao.maps.LatLngBounds();	
				var total = (addrs.length);
				console.log("total",total);
				var counter = 0;
					
				markingMap();
				
				
// ========================================== 프랜차이즈 마킹 시작 !! =================================================
										
										function markingMap() {
										
											for(var i=0; i<total; i++) {

											var coords = new kakao.maps.LatLng(addrs[i].ylat, addrs[i].xlon);
											console.log('i='+i+'yLat[i]='+addrs[i].ylat+' xLng[i]='+addrs[i].xlon+' fcId =',addrs[i].fcId);
												// marking 좌표를 포함하도록 영역 정보를 확장한다.
												bounds.extend(coords);
												
												// 마커를 생성합니다
											    	marker = new kakao.maps.Marker({
											        map: map, // 마커를 표시할 지도
											        position: coords,// 마커의 위치
											        image:icon
											    }); 
													markers.push(marker);
											    
											    // 마커에 표시할 인포윈도우를 생성합니다 
											    	infowindow = new kakao.maps.InfoWindow({
											        content: addrs[i].fcId // 인포윈도우에 표시할 내용
											    });
										    	
											    // 마커에 이벤트를 등록하는 함수 만들고 즉시 호출하여 클로저를 만듭니다
											    // 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
											    (function(marker, infowindow) {
											        // 마커에 mouseover 이벤트를 등록하고 마우스 오버 시 인포윈도우를 표시합니다 
											        kakao.maps.event.addListener(marker, 'mouseover', function() {
											            infowindow.open(map, marker);
											        });

											        // 마커에 mouseout 이벤트를 등록하고 마우스 아웃 시 인포윈도우를 닫습니다
											        kakao.maps.event.addListener(marker, 'mouseout', function() {
											            infowindow.close();
											        });
											    })(marker, infowindow);		

// ========================================== 프랜차이즈 마킹 종료 !! =================================================				
											} //for
												map.setBounds(bounds);
											} // function markingMap
					
					
// 				card 밑에 띄우기
					
					$('#fcInfo').load('fcSearch?card=card #fcInfo'); // 지역명 카드띄우기 시작.	
					
				} //if(data.success=='success')
					
				else {
					
					alert('해당 지역에 가맹점이 없습니다.');
					
					}			
						}, error : function(){
							alert("통신 오류입니다. 다시 시도하세요.");
						}
					})//ajax
				}// function
		</script>	
	</div>
	<!-- 지도표시종료 -->
<!-- 카드조회 시작 -->
		<div class="container fcInfoClass" id="fcInfo">
			<div class="row align-items-start" id="fcInfo_all">
				<c:forEach var="vo" items="${list}" varStatus="vs">
						<div class="col-6" style="margin-bottom: 40px;">
							<div class="card"
							style="border : 1px solid #DC3545; ">
							  <div class="card-body ">
								    <h5 class="card-title" id="fcId">매장명 : ${vo.fcId} 점</h5>
							        <h5 class="card-title"id="fcPhone">T :${vo.fcPhone}</h5>
								    <p class="card-text"id="fcAddress">주소: ${vo.fcAddress}</p>
<!-- 								    <button class='btn btn-danger' style="right: auto;"  onclick="alert('♡사랑합니다. 고객님♡ \n해당 페이지는 현재 준비중입니다.')">매장정보보기</button> -->
							  </div>
							</div>
						</div>
				 </c:forEach>
			 </div>
		 </div>	
<!-- 카드조회 종료 -->
	<div class="row" style="height: 100px"></div>
	</section>
	<script type="text/javascript">
//1. 지역명/ 가맹점명/ 현위치 나타났다가 사라지는 기능. //기능 충돌생김
function showdiv(id) {	
		
	if (id=='franchiselocation'){
		$('#outer_1').css('display','flex');
		$('#outer_2').css('display','none');
		$('#outer_3').css('display','none');
		InputDataClear();
				
	}else if (id=='franchiseName'){
		$('#outer_1').css('display','none');
		$('#outer_2').css('display','flex');
		$('#outer_3').css('display','none');
		InputDataClear();
				
	}else{
		$('#outer_1').css('display','none');
		$('#outer_2').css('display','none');
		$('#outer_3').css('display','flex');
		InputDataClear();
	
	}
		
}// function showdiv(id)

function clickEffect(id){
	$('.checked').css({
		"color" : 'gray',
		"border-bottom" : "1px solid lightgray"
	});

	$('#'+id).css({
		"color" : '#DC3545',
		"border-bottom" : "2px solid #DC3545"
	});
	
		
}//function clickEffect(id)

function InputDataClear(){
	$('#Sido').val('none');
	$('#Gugun').val("none");
	$('#a1').val('');
	$('#a2').val('');
	$('#fcInfo_all').empty();
    map = new kakao.maps.Map(mapContainer, mapOption); 
}

	function setMarkers() {
	    for (var i = 0; i < markers.length; i++) {
	        markers[i].setMap(null);
	    }
// 	    markers=[];
	}


</script>		

	<!-- Footer-->
	<%@include file="footer.jsp"%>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->

</body>
</html>

