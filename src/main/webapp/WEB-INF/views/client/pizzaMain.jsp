<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>페데리꼬 피자</title>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<style>
a:visited {
	text-decoration: none;
	color: black;
}

a:hover {
	text-decoration: none;
	color: black;
}

a {
	color: black;
	text-decoration: none;
}

@media (min-width: 992px) {
  #carouselExampleIndicators {
   height: 500px;
  }
}
@font-face {
    font-family: 'Treegarden';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/naverfont_10@1.0/Treegarden.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
  .divpop {
      position: absolute; z-index:999; top:50px; left:50px;
      width:400px; min-height:612px; border:1px solid black;background-color:white;display:none;
  }
  .title_area {font-weight:bold;text-align:center;width:100%}
  .button_area {position:absolute;bottom:0;} 
</style>
</head>
<body class="bg-danger">
	<!-- Navigation-->
	<%@include file="nav.jsp"%>
	
	
	<!-- Header-->
	<header class="container bg-danger py-4">
		<div class="row justify-content-md-center mb-3">
			<div class="col-12 lead" align="center" style="font-size:x-large; height: 100px; color: white;">
			페데리코가 준비한 <b>깊은 풍미의 피자</b>를 즐겨보세요<br>
			<p style="font-family: Treegarden; font-size: xx-large;">The uglier it is, the tastier it is .<p>
			</div>
		</div>
		<div class="row justify-content-md-center">
			<div class="col-12">
				<div id="carouselExampleIndicators" class="carousel slide"
					data-bs-ride="carousel" style="overflow: hidden;">
					<div class="carousel-inner" style="z-index: 1;">
						<div class="carousel-item active">
							<img src="/federico/resources/Image/top_mv_notxt01.jpeg"
								class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img src="/federico/resources/Image/top_mv_notxt02.jpeg"
								class="d-block w-100" alt="...">
						</div>
						<div class="carousel-item">
							<img src="/federico/resources/Image/top_mv_notxt03.jpeg"
								class="d-block w-100" alt="...">
						</div>
					</div>
					<button class="carousel-control-prev" type="button"
						data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
						<span class="carousel-control-prev-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Previous</span>
					</button>
					<button class="carousel-control-next" type="button"
						data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
						<span class="carousel-control-next-icon" aria-hidden="true"></span>
						<span class="visually-hidden">Next</span>
					</button>
				</div>
			</div>
			<div class="row justify-content-md-center" style="height: 100px;">
				<div class="col-6 bg-light py-4" align="center" 
				style="font-size: x-large; color: crimson; border-top: 1px solid crimson; border-right: 2px solid crimson; border-radius: 5px; cursor: pointer;"
				onclick="javaScript:location.href='menuList?menuFlag=pizza'">
				<img src="/federico/resources/Image/delieveryLogo.png" alt="..." style="width: 50px;">
				&nbsp;&nbsp;&nbsp;주문하기</div>
				<div class="col-6 bg-light py-4" align="center" 
				style="font-size: x-large; color: crimson; border-top: 1px solid crimson; border-radius: 5px; cursor: pointer;" 
				onclick="javaScript: location.href='fcSearch'">
				<img src="/federico/resources/Image/mapLogo.png" alt="..." style="width: 40px;">
				&nbsp;&nbsp;&nbsp;매장찾기</div>
			</div>
		</div>
	</header>
	<!-- Section-->
	<section class="container py-5" style="height: 180px; z-index: 3; position: relative; margin-bottom: 168px;">
		
	</section>
	
	<!-- Footer-->
	<%@include file="footer.jsp"%>
	
	<div id="divpop1" class="divpop">    
          <div class="title_area" style="background-color: lightgray;">페데리코 테스트페이지 안내 팝업</div>
           <div class="row px-2 py-3 mt-2" style="font-size: small;">
           			<p>안녕하세요.</p>
           			<p>
           			페데리코피자 프랜차이즈 통합관리 솔루션 구현팀입니다.<br>
           			현재 보고 계신 이 페이지는 상업적인 용도가 아닌 팀 프로젝트 페이지이며 
           			페데리코피자 브랜드는 실존하지 않는 가상의 브랜드임을 알려드립니다.<br><br>
           			그러므로 내부에서 진행되는 결제는 매일밤 12시에 자동 환불처리 되며<br>
           			실제로 주문한 메뉴를 받아보실 수 없습니다.<br>
           			또한 매장의 위치는 임의로 지정해놓은 허구의 위치이며 메뉴정보는<br> 
           			피자브랜드 'SPONTINI'의 메뉴이미지를 활용했습니다.
           			</p>
           			<p>
           			사이트의 구성은 크게 현재 보고계신 '소비자공간'과 하단에 있는 <br>'가맹점공간', '본사공간'이 있습니다.<br>
           			각각 공간의 역할과 기능이 다르니 천천히 둘러보시길 바랍니다. 
           			</p>
           			</div>
           			<div align="center">
           			<div style="background-color: 	#F5F5F5; width: 50%;">
           				<table style="font-size: small;">
           				<tr align="center">
						<th colspan="2">소비자공간</th>
           				</tr>
           				<tr><th>ID</th> <td>exclient1</td></tr>
           				<tr><th>PW</th> <td>123123123!</td></tr>
           				<tr align="center">
						<th colspan="2">가맹점공간</th>
           				</tr>
           				<tr><th>ID</th> <td>미금1호</td></tr>
           				<tr><th>PW</th> <td>12345!</td></tr>
           				<tr align="center">
						<th colspan="2">본사공간</th>
           				</tr>
           				<tr><td colspan="2">본사공간의 아이디는 개별적으로 허가되신 분들께만 알려드렸습니다. 양해바랍니다.</td></tr>
           				</table>
           			</div>
           			</div>
           			<br><br>
           <div class="button_area" style="width:100%; background-color: lightgray;">
               <input type='checkbox' name='chkbox' id='todaycloseyn' value='Y'>
               <label for="todaycloseyn">&nbsp;오늘 하루 이 창을 열지 않음 </label>
               <div style="float: right;"><a href='#' onclick="javascript:closeWin(1);"><B>[닫기]</B></a></div>
           </div>
      </div>
	
	

<script>
    //쿠키설정    
    function setCookie( name, value, expiredays ) {
    var todayDate = new Date();
    todayDate.setDate( todayDate.getDate() + expiredays );
    document.cookie = name + '=' + escape( value ) + '; path=/; expires=' + todayDate.toGMTString() + ';'
    }

    //쿠키 불러오기
    function getCookie(name) 
    { 
        var obj = name + "="; 
        var x = 0; 
        while ( x <= document.cookie.length ) 
        { 
            var y = (x+obj.length); 
            if ( document.cookie.substring( x, y ) == obj ) 
            { 
                if ((endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                    endOfCookie = document.cookie.length;
                return unescape( document.cookie.substring( y, endOfCookie ) ); 
            } 
            x = document.cookie.indexOf( " ", x ) + 1; 
            
            if ( x == 0 ) break; 
        } 
        return ""; 
    }

    //닫기 버튼 클릭시
    function closeWin(key)
    {
        if($("#todaycloseyn").prop("checked"))
        {
            setCookie('divpop'+key, 'Y' , 1 );
        }
        $("#divpop"+key+"").hide();
    }
  
    $(function(){    
        if(getCookie("divpop1") !="Y"){
            $("#divpop1").show();
        }
    });
</script>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/federico/resources/js/scripts.js"></script>
</body>
</html>

