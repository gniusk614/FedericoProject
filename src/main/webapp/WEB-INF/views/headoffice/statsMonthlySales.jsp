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
//월별selectbox 만들기 - 지정일부터 당월까지 생성.
	var now = new Date();
	var date = new Date('2021-01-28');		
	
	

	while (true) {
		var monthString = (date.getMonth() + 1) < 10 ? '0' + (date.getMonth() + 1) : (date.getMonth() + 1);
		if (date.getTime() >= now.getTime()) {
			$('#selectFcStatsMonthlySales').append($('<option>', {
				value : '' + date.getFullYear() + monthString + '01',
				text : date.getFullYear() + '년 ' + monthString + '월',
				selected : true
			})// jquery
			) //append
			break;
		}
		$('#selectFcStatsMonthlySales').append($('<option>', {
			value : '' + date.getFullYear() + monthString + '01',
			text : date.getFullYear() + '년 ' + monthString + '월'
		})) //append
		
		date.setMonth(date.getMonth() + 1);
		
	}//월별selectbox 만들기

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
		
		
		
		
	selectFcStatsMonthlySales(); 
		
	}) //ready
	// 월별매출조회 select 바뀔시 차트바꿔줌.
	function selectFcStatsMonthlySales() {
		resetCanvas();
		$.ajax({
			type : 'get',
			url : 'statsmonthlysales',
			data : {
				baseDay : $('#selectFcStatsMonthlySales').val(),
				fcId: $('#selectFcId').val()
			},
			success : function(data) {
				statsSuccessChart(data, 'monthly')
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
			<select id="selectFcStatsMonthlySales" class="form-select" onchange="selectFcStatsMonthlySales()"></select>
		</div>
		<div class=col-3>
			<!-- 스크립트처리 -->
			<select id="selectFcId" class="form-select" onchange="selectFcStatsMonthlySales()"></select>
		</div>
	</div>



</body>
</html>