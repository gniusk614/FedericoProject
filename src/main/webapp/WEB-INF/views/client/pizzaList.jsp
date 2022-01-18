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
<!-- Favicon-->
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="icon" type="image/x-icon"
	href="/federico/resources/Image/LOGO.png" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<style>
@media (min-width: 992px) {
  #carouselExampleIndicators {
   height: 500px;
  }
} 

.menu-card { height: 240px; width: 550px; display: inline-block; margin: 20px; z-index: 500; position: relative;} 

.menu-hidden{ 
			height: 100%; width: 100%; display: none; background-color: rgba(105, 105, 105, 0.5); 
			position: absolute; left: 0; top: 0; z-index: 300;
				}
.menu-button{ margin: auto; display: none; position: absolute; right:20px; top:190px; z-index: 100;}

</style>
<script>

/* $(function(){
	$('#card0').on('mouseover',function(){
		$('#card00').css('display','inline-block')
	})
	$('#card0').on('mouseover',function(){
		$('#card000').css('display','inline-block')
	})
	
	$('#card0').on('mouseleave',function(){
		$('#card00').css('display','none')
	})
	$('#card0').on('mouseleave',function(){
		$('#card000').css('display','none')
	})	
})
	 */
	
	
function btnShow(index){
	console.log('up'+index)
	$('#hidden'+index).css('display','inline-block');
	$('#hiddenbtn'+index).css('display','inline-block');
}
		
function btnHide(index){
	console.log('down'+index)

	$('#hidden'+index).css('display','none');
	$('#hiddenbtn'+index).css('display','none');
}



</script>

</head>
<body>
	<!-- Navigation-->
	<%@include file="nav.jsp"%>
	
	<!-- Section-->
	<section class="container">
		<div class="container">
		<!-- 메뉴조회 카드 시작 -->		
			<c:forEach var="vo" items="${list}" varStatus="vs">
				<div class="card menu-card" id="card${vs.index}" onmouseover="btnShow(${vs.index})" onmouseleave="btnHide(${vs.index})">
					<div class="row no-gutters">
						<!-- 이미지 들어가는 부분 -->
						<div class="col-5">
							<img src="${vo.menuImage }" height="240px"/>
						</div><!-- 이미지 들어가는 부분 -->
						<!-- 내용 들어가는 부분 -->
						<div class="col-7">
							<div class="card-body">
								<span class="fw-bold fs-2">${vo.menuName }</span>
								<p class="card-text">${vo.menuIntro}</p>
							</div><!-- 내용 들어가는 부분 -->
						</div>
					</div>
					<div class="menu-hidden" id="hidden${vs.index}">
						<button type="button" class="btn btn-success menu-button" id="hiddenbtn${vs.index}"">
							장바구니
						</button>
					</div>	
				</div>
			</c:forEach>
		</div>
	</section>

	
	<!-- Footer-->
	<%@include file="footer.jsp"%>
	

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script src="/federico/resources/js/scripts.js"></script>
</body>
</html>

