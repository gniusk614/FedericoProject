<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페데리꼬 피자</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<!-- chart js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/franchise_Script.js"></script>
<!-- calendar 관련 cdn -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/css/tempusdominus-bootstrap-4.min.css" />
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.css" />
<script>

//캔버스 리셋
function resetCanvas() {
	$('#fcStatsChartCanvas').remove();
	$('#canvasZone').append($('<canvas>', {
		id : 'fcStatsChartCanvas',
		height: '550px',
		width: '1400px'
	}))
}

// 차트그리기
function statsSuccessChart(data, type) {
	if (data.success == 'success') {
		
		var title = [];
		var label;
		var chartLabel = [];
		var chartData = [];
		var chartColor = [];
		var borderColor = [];
		var chartID = "fcStatsChartCanvas";

		//조건
		switch(type){
			case "monthly":
				title = $('#selectFcStatsMonthlySales').children(':selected').text()+ ' 매출현황';
				label = '매출액';
			break
			case "time":
				title = data.selectDate ==null ? "전체기간 시간대별 매출현황" : data.selectDate + " 시간대별 매출현황"
				label = '매출액';
				$('#selectDate').val(data.selectDate);
			break
			case "menu":
				title = $('#selectFcStatsMenuSales').children(':selected').text()+ ' 메뉴별 판매량';
				label = '매출액';
			break
			case "annual":
				title = $('#selectFcStatsAnnualSales').children(':selected').text()+ ' 월별 판매량';
				label = '매출액';
			break
		}//switch

		var data = data.chartData;
		$.each(data, function(index, element) {
			if(type == "monthly"){
				var imsi = element.chartLabel;
				imsi = imsi.substring(4,6)+'/'+imsi.substring(6);
				chartLabel.push(imsi);
			} else {
				chartLabel.push(element.chartLabel);
			}
			chartData.push(element.chartCount);
			var strRGBA = 'rgba(154, 205, 50, 0.3)';
			var borderRGBA = 'rgb(50, 205, 89)';
			chartColor.push(strRGBA);
			borderColor.push(borderRGBA);

		}) //each

		new Chart(chartID, {
			type : 'bar',
			data : {
				labels : chartLabel,
				datasets : [ {
					label : label,
					data : chartData,
					backgroundColor : chartColor,
					borderColor : borderColor,
					fill : false,
					borderWidth : 1
				} ]
			},
			options : {
				responsive: false,
				legend : {
					labels : {
						fontColor : 'Black'
					}
				},
				title : {
					display : true,
					text : title,
					fontSize : 24,
					fontStyle : 'bold',
					fontColor : 'black'
				},
				scales : {
					yAxes : [ {
						fontColor : 'black',
						ticks: {
								beginAtZero: true,
								callback: function (value) {
                                    if (0 === value % 1) {
                                        return value;
                                    }
								}
						}
					} ],
					xAxes : [ {
						fontColor : 'black',
						barPercentage : 0.4
					} ]
				}
			}
		});//그래프				 
	} else {
		alert('통신장애가 발생했습니다.\n다시 시도해주세요.');

	}
}//차트그리기


</script>
<style>
.parent a{
	text-decoration: none; color: black;
}
.selected{
	color: green; font-weight: bold; font-size: 20px;
}
</style>
</head>
<body>
<!-- navtop inlcud -->
<%@ include file="navtop.jsp" %>

<!-- layoutSidenav 시작 -->
<div id="layoutSidenav">
	<%@ include file="navside.jsp" %>
	<div id="layoutSidenav_content">
		<!-- 본문 시작 -->
		<div class="container-fluid px-4" style="margin-top: 20px; ">
			<div class="card">
				<div class="card-header">
					<h4><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-collection" viewBox="0 0 16 16">
					  <path d="M2.5 3.5a.5.5 0 0 1 0-1h11a.5.5 0 0 1 0 1h-11zm2-2a.5.5 0 0 1 0-1h7a.5.5 0 0 1 0 1h-7zM0 13a1.5 1.5 0 0 0 1.5 1.5h13A1.5 1.5 0 0 0 16 13V6a1.5 1.5 0 0 0-1.5-1.5h-13A1.5 1.5 0 0 0 0 6v7zm1.5.5A.5.5 0 0 1 1 13V6a.5.5 0 0 1 .5-.5h13a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-.5.5h-13z"/>
					</svg>
				매출관리 및 통계</h4>
				</div>
				<div class="card-body" style="min-height: 720px;">
					
					<!-- 조회유형 선택 -->
					<div class="card">
						<div class="card-header parent" style="background-color: #e6e6e6; font-size: 18px;">
					<!-- 	월별매출조회 - default 이번달, 20년01월~ 21년02월(함수) / 시간대별 매출조회(날짜지정)/ 메뉴별 주문건수 조회 월별, default 이번달  / 메뉴별 매출 Top5 , Worst 5 월별 , 전체 / --> 
							<c:if test="${key == null}">
								<a href="stats"><span id="fcStatsAnnualSales" class="selected">연도별 매출 조회</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="stats?key=2"><span id="fcStatsMonthlySales" >월별 매출 조회</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="stats?key=3"><span id="fcStatsDailySales" >시간대별 매출 조회</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="stats?key=4"><span id="fcStatsMenuSales" >메뉴별 판매량 조회</span></a>
							</c:if>	
							<c:if test="${key == 2}">
								<a href="stats"><span id="fcStatsAnnualSales" >연도별 월간 매출 조회</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="stats?key=2"><span id="fcStatsMonthlySales" class="selected">월별 매출 조회</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="stats?key=3"><span id="fcStatsDailySales" >시간대별 매출 조회(일)</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="stats?key=4"><span id="fcStatsMenuSales" >메뉴별 판매량 조회(월)</span></a>
							</c:if>
							<c:if test="${key == '3'}">
								<a href="stats"><span id="fcStatsAnnualSales" >연도별 월간 매출 조회</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="stats?key=2"><span id="fcStatsMonthlySales" >월별 매출 조회</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="stats?key=3"><span id="fcStatsDailySales" class="selected">시간대별 매출 조회</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="stats?key=4"><span id="fcStatsMenuSales" >메뉴별 판매량 조회</span></a>
							</c:if>
							<c:if test="${key == '4'}">
								<a href="stats"><span id="fcStatsAnnualSales" >연도별 월간 매출 조회</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="stats?key=2"><span id="fcStatsMonthlySales" >월별 매출 조회</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="stats?key=3"><span id="fcStatsDailySales" >시간대별 매출 조회</span></a>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="stats?key=4"><span id="fcStatsMenuSales" class="selected">메뉴별 판매량 조회</span></a>
							</c:if>
						
							
						</div>
					</div><!-- 조회유형 선택 -->
					<!-- 통계결과 -->
					<div class="container-fluid">
						<div id="includeZone" class="mt-3">
							<c:if test="${key == null }">
								<%@ include file="statsAnnualSales.jsp" %>
							</c:if>
							<c:if test="${key == 2 }">
								<%@ include file="statsMonthlySales.jsp" %>
							</c:if>
							<c:if test="${key == 3 }">
								<%@ include file="statsTimeSales.jsp" %>
							</c:if>
							<c:if test="${key == 4 }">
								<%@ include file="statsMenuSales.jsp" %>
							</c:if>
							
							
							
							<div id="canvasZone" align="center">
								<canvas id="fcStatsChartCanvas" height="550px" width="1400px"></canvas>
							</div>
					</div>
			
			
				</div>
			</div>
		</div> <!-- 본문 끝 -->
	</div> 
		<!-- footer inlcud -->
		<div><%@ include file="footer.jsp" %></div>
</div> <!-- layoutSidenav 끝 -->			



<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>

</body>
</html>