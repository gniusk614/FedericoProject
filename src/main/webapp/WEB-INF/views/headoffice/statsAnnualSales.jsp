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
//년도 selectbox 만들기 - 지정일부터 당월까지 생성.
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
		}//년도 selectbox 만들기

// 가맹점명 selectbox 만들기
	$.ajax({
		type: 'get',
		url : 'selectFcId',
		success: function(data){
			if(data.success == 'success'){
				$('#selectFcId').append($('<option>', {
					value : '',
					text : "전 지점",
					selected : true
				})) //append
			fcList = data.fcList;
				$.each(fcList, function(index, element){
					$('#selectFcId').append($('<option>', {
						value : element.fcId,
						text : element.fcId+'점',
					})) //append
				})
			}else{
				alert('통신 장애입니다.\n다시 시도해주세요.')
			}
		},
		error: function(){
			alert('통신 장애입니다.\n다시 시도해주세요.')
		}
	})// 가맹점명 selectbox 만들기
		
		
 	selectFcStatsAnnualSales();  
		
	}) //ready
	
	// 월별매출조회 select 바뀔시 차트바꿔줌.
	function selectFcStatsAnnualSales() {
		resetCanvas();
		console.log($('#selectFcId').val());
		$.ajax({
			type : 'get',
			url : 'statsannualsales',
			data : {
				baseDay: $('#selectFcStatsAnnualSales').val(),
				fcId: $('#selectFcId').val()
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
	<div class="row">
		<div class=col-2>
			<!-- 스크립트처리 -->
			<select id="selectFcStatsAnnualSales" class="form-select" onchange="selectFcStatsAnnualSales()"></select>
		</div>
		<div class=col-3>
			<!-- 스크립트처리 -->
			<select id="selectFcId" class="form-select" onchange="selectFcStatsAnnualSales()"></select>
		</div>
	</div>




</body>
</html>