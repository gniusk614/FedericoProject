<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="/federico/resources/myLib/franchise_Script.js"></script>
<script>
$(function(){
	 // 화면 로딩시 차트그리기
	selectFcStatsTimeSales();
}) //ready

//시간대별 매출조회(날짜지정))
function selectFcStatsTimeSales() {
	resetCanvas();
	$.ajax({
		type : 'get',
		url : 'statstimesales',
		data : {
			selectDate : $('#selectDate').val()
		},
		success : function(data) {
			statsSuccessChart(data, 'time')
		},
		error : function() {
			alert('통신장애가 발생했습니다.\n다시 시도해주세요.');
		}
	})//ajax	 
}

</script>

</head>
<body>

<div class="row">	
	<div class="col-3" id="datePicker">
		<div class="input-group date col" id="datetimepicker2" data-target-input="nearest"> 
			<input id="selectDate" type="text" class="form-control datetimepicker-input" data-target="#datetimepicker2" value="${selectDate}" > 
			<div class="input-group-append" data-target="#datetimepicker2" data-toggle="datetimepicker"> 
				<div class="input-group-text">
					<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16">
					  <path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/>
					  <path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/>
					</svg>	
				</div> 
			</div> 
		</div>
	</div>
	<div class="col-sm-2">
		<button id="searchBtn" class="btn btn-outline-primary" onclick="selectFcStatsTimeSales()">검색</button>
	</div>
</div>
										






</body>
</html>