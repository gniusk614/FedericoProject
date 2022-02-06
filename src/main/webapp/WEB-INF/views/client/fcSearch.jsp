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
			<select class="form-select form-select-lg" id="Sido" name="Sido" 
			 aria-label="Default select example" onchange="depth1_change(value)" >
			  <option value="서울">서울시</option>
			  <option selected="selected" value="경기">경기도</option>
			</select>
			<div id ="result"></div>
		</div>
		
		
		<div class="col" style="height: 64px;">
			<select class="form-select form-select-lg" id="Gugun"  aria-label="Default select example" onchange="depth2_change(value)">
				<option>지역을 선택하세요.</option>
			</select>			
		</div>	
		<!-- 지도표시 -->
	<div class="row" style="display:block; margin-top:40px;">
		<div class="col" style="height: 600px; margin-bottom:100px; overflow: hidden;">
		<!-- 지도본체 -->
		<div id="map" style="width:100%;height:100%;"></div>	
		
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=63fe094a0bad5ef07be77c4f00959da2&libraries=services"></script>
		<script>
		

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 8 // 지도의 확대 레벨		
		};
	     // 지도를 생성합니다    
	     var map = new kakao.maps.Map(mapContainer, mapOption); 

		
		
// 이 스크립트는 BODY 영역에 작성 한다. 
function depth1_change(e){   	
   	   	
	var seoul = ['강남구','강동구','강북구','강서구','관악구','광진구','구로구',
		  '금천구','노원구','도봉구','동대문구','동작구','마포구','서대문구',
		  '서초구','성동구','성북구','송파구','양천구','영등포구','용산구',
		  '은평구','종로구','중구','중랑구'];
	
	console.log(seoul);
	console.log("ID=Sido => "+$('#Sido').val());
	
	
	var ggd = ['고양시 덕양구','고양시 일산구','과천시','광명시','광주시','구리시','군포시',
		'김포시','남양주시','동두천시','부천시 소사구','부천시 오정구','부천시 원미구','성남시 분당구',
		'성남시 수정구','성남시 중원구','수원시 권선구','수원시 장안구',
		'수원시 팔달구','시흥시','안산시 단원구','안산시 상록구','안성시','안양시 동안구',
		'안양시 만안구','오산시','용인시','의왕시','의정부시','이천시','파주시','평택시',
		'하남시','화성시','가평군','양주군','양평군','여주군','연천군','포천군'];
	
	console.log(ggd);
	console.log("ID=Sido => "+$('#Sido').val());

	
	
	var target = document.getElementById("Gugun");
	
	target.options.length = 0;
	
	if(e == "서울")var Depth2 = seoul;
   	else if(e == "경기") var Depth2 = ggd; 
	
	for (x in Depth2) {
		var option = document.createElement("option");
		option.value = Depth2[x];
		option.innerHTML = Depth2[x];
		target.appendChild(option);
	} // for
	
}// function


//function depth2
function depth2_change(e){
	
	console.log("ID=Gugun => "+$('#Gugun').val());
	
	var Depth2 = e;
	
	$.ajax ({		
		type : 'get',
		url : 'fcSearchArea',
		headers : {Authorization:'KakaoAK {63fe094a0bad5ef07be77c4f00959da2}'},
		data : {
			Depth1 : $('#Sido').val() ,
			Depth2 : Depth2		
		},		
		
		success : function(data){
			
			
			
			if(data.success=='success'){
				
				
				
				var addr = data.fcaddress;
				console.log("addr => " + addr);
				if(data.fcaddress==''){
					alert('해당 위치에 가맹점이 없습니다.')
				}
				
				var addrs = [];
				
				console.log("addr => " + addr);
				console.log(addr);
				
				for(var i = 0; i<addr.length ; i++){				
					console.log("addrs =>" +addrs);
					addrs.push(addr[i].fcAddress);					
					console.log(addrs);
				}
					/*{ content:'성남1_본관',  // 마커 롤오버시 표시할 내용
					  addr:'경기 성남시 분당구 구미동 7-2 (돌마로 46) 5층' },
					{ content:'성남2_별관',   
					  addr:'경기 성남시 분당구 금곡동 167 (돌마로 47) 이코노샤르망 5층' },  
					{ content:'강남1',  
					  addr:'서울시 강남구 역삼동 815-4 (강남대로 428) 만이빌딩 4층, 9층' },
					{ content:'강남2',  
					  addr:'서울시 강남구 역삼동 649-14 (테헤란로 119) 대호빌딩 8층' },
					{ content:'수원1',  
					  addr:'경기도 수원시 팔달구 매산로 1가 55-3 (매산로 12-1) 3~4층' },
					{ content:'수원2',   
					  addr:'경기도 수원시 팔달구 매산로1가 11-12, 아이메카빌딩 5층, 11층' },  
					{ content:'안양',   
					  addr:'경기 안양시 만안구 안양 4동 676 - 91 (안양로 303) 안양메쎄타워 2F' }*/
				// 주소-좌표 변환 객체를 생성합니다				
				var geocoder = new kakao.maps.services.Geocoder();
					  console.log("geo="+geocoder);
				// 지도의 중심좌표를 표시 위치에 따라 재설정 하기위한 bounds 생성	
				var bounds = new kakao.maps.LatLngBounds();	
				console.log("bounds ="+bounds);
				// lat : 위도(latitude) , lng [long] : 경도(longitude)
				// coordinate [coords] :  1.조직, 편성하다  2.(몸의 움직임을) 조정하다 
//				                        3.(옷차림가구 등) 꾸미다[코디하다], 잘 어울리다[조화되다]
//				                        4.수학 에서 좌표
				// 주소를 좌표로 전환하기 
				// => geocoder.addressSearch(...) 는 콜백함수를 사용하기 때문에 
//				    배열 addrs가 addr 하나의 데이터 속성만 있다면 무관 하지만 
//				    위의 경우처럼 content 가 있는경우에는 이 content 값은 마지막 값만 볼수 있게 된다
//				    왜냐하면 반복문이 실행되는 동안 콜백 함수는 자신의 매개변수들을 차곡 차곡 보관해 놓고, 
//				    반복문이 종료되어 더이상 매개변수가 전달되지 않으면 하나씩 실행이 시작되는 구조 이기 때문에
//				    이 상황에서 i 는 마지막 값이고, content 역시 마지막 값이므로... 
				// => 해결은 여러가지가 있겠지만, 데이터의 구조와 특징에 따라 구현하는것이 좋을듯
				// => https://devtalk.kakao.com/t/addresssearch/44163/4

				var total = addrs.length;
 				console.log("addrs.length = "+addrs.length);
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
							
							if (status === kakao.maps.services.Status.OK) {
								
								yLat[counter] = result[0].y;
								xLng[counter] = result[0].x;
								console.log("counter=>"+counter+'i='+i+'result[0].y='+result[0].y+'result[0].x='+result[0].x );
								counter++;
								if (total===counter) {
									console.log("** geocoder.addressSearch END **");
									//모든 주소의 좌표가 배열로 옮겨졌으면 지도에 marking 한다. 
									markingMap(); 
								} 
							} // if	
						}); // geocoder.addressSearch	
					} // for	

					// 지도에 marking
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
							
							// marking 좌표를 포함하도록 영역 정보를 확장한다.
							bounds.extend(coords);
							// 인포윈도우로 장소에 대한 설명을 표시합니다 
							var info = addrs[i].content;
							console.log('i='+i+'info='+info);
							
							//infowindow.setContent(info);
							// => 전역으로 생성된 하나의 객체에 계속 OverWrite 되어 마지막 값만 표시됨
							//    아래처럼 매번 생성해야 한다.
							var infowindow = new kakao.maps.InfoWindow({
						        content: info });
							infowindow.open(map,marker);
						} // for
						map.setBounds(bounds);
					} // function markingMap
				
				
				}else {
								
								alert('해당 지역에 가맹점이 없습니다.')
							}
							
						}, error : function(){
							alert("통신 오류")
						}
						
					})//ajax
				}// function
	
		</script>	
		
		
		<div class="row fcLocalName">
			<div class="col" style="height: 800px; padding-bottom:50px;">			
					<!-- 가맹점 조회 카드 시작 -->
					<c:forEach var="vo" items="${fcaddress}" varStatus="vs">
						<div class="card fc-card" id="card ${vo.fcId}">					
							<div class="row no-gutters">								
								<!-- 내용 들어가는 부분 Start -->
								<div class="col-7">
									<div class="card-body py-3 px-4">
										<div class="fw-bold fs-4" style="text-align: left;">${vo.fcId }</div>
										<p class="card-text fcAddress mt-1" style="color:gray; height: 100px;">위치 : ${vo.fcAddress}</p>								
									</div>
								</div>
								<!-- 내용 들어가는 부분 End -->
							</div>					
						</div>
					</c:forEach>			
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
	
	
	</div>		
	
	<div class="row fcLocalName">
		<div class="col" style="height: 800px; padding-bottom:50px;">
		
		가맹점카드 표시구간
		
		
			<!-- 가맹점 조회 카드 시작 -->
			<c:forEach var="vo" items="${fcaddress}" varStatus="vs">
				<div class="card fc-card" id="card${vs.fcId}">					
					<div class="row no-gutters">
						
						<!-- 내용 들어가는 부분 Start -->
						<div class="col-7">
							<div class="card-body py-3 px-4">
								<div class="fw-bold fs-4" style="text-align: left;">${fcaddress.fcId }</div>
								<p class="card-text menuIntro mt-1" style="color:gray; height: 100px;">${fcaddress.fcAddress}</p>								
							</div>
						</div>
						<!-- 내용 들어가는 부분 End -->
					</div>					
				</div>
			</c:forEach>
	
		</div>
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


//2.1 지도에 마커표시



	
// 지도의 주소를 가져오라는 요청을 지시할 요청자.
// 1. 지역명 


</script>		

	<!-- Footer-->
	<%@include file="footer.jsp"%>
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	
</body>
</html>

