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
		
		
	selectStatsAgeGroupMenuSales();  
		
	}) //ready
	
	// 월별매출조회 select 바뀔시 차트바꿔줌.
	function selectStatsAgeGroupMenuSales() {
		resetCanvas();
		$.ajax({
			type : 'get',
			url : 'statsagegroupmenusales',
			data : {
				ageGroup: $('#selectAgeGroup').val(),
				fcId: $('#selectFcId').val()
			},
			success : function(data) {
				statsSuccessChart(data, 'ageGroupMenuSales')
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
			<select id="selectAgeGroup" class="form-select" onchange="selectStatsAgeGroupMenuSales()">
				<option value="10" selected>10대</option>
				<option value="20">20대</option>
				<option value="30">30대</option>
				<option value="40">40대</option>
				<option value="50">50대</option>
				<option value="60">60대</option>
				<option value="70">70대</option>
				<option value="80">80대</option>
				<option value="90">90대</option>
			</select>
		</div>
		<div class=col-3>
			<!-- 스크립트처리 -->
			<select id="selectFcId" class="form-select" onchange="selectStatsAgeGroupMenuSales()"></select>
		</div>
	</div>




</body>
</html>