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
//selectbox 만들기 - 지정일부터 당월까지 생성.
	var now = new Date();
	var date = new Date('2020-01-01');		
	


	while (true) {
			date.setFullYear(date.getFullYear()+1);

			if (date.getFullYear() >= now.getFullYear()) {
				$('#selectFcStatsAnnualSales').append($('<option>', {
					value : date.getFullYear() + "0101",
					text : date.getFullYear() + '년',
					selected : true
				})// jquery
				) //append
				break;
			}
			$('#selectFcStatsAnnualSales').append($('<option>', {
				value : date.getFullYear() + "0101",
				text : date.getFullYear() + '년'
			})) //append
		}//selectbox 만들기

 	selectFcStatsAnnualSales();  
		
	}) //ready
	// 월별매출조회 select 바뀔시 차트바꿔줌.
	function selectFcStatsAnnualSales() {
		resetCanvas();
		$.ajax({
			type : 'get',
			url : 'statsannualsales',
			data : {
				baseDay : $('#selectFcStatsAnnualSales').val()
			},
			success : function(data) {
				statsSuccessChart(data, 'annual')
			},
			error : function() {
				alert('통신장애가 발생했습니다.\n다시 시도해주세요.');
			}
		})//ajax	 
	}
</script>

</head>
<body>

	<div class=col-2>
		<!-- 스크립트처리 -->
		<select id="selectFcStatsAnnualSales" class="form-select" onchange="selectFcStatsAnnualSales()"></select>
	</div>





</body>
</html>