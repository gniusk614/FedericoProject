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

		
	selectStatsMemberAgeGroup();  
		
	}) //ready
	
	// 월별매출조회 select 바뀔시 차트바꿔줌.
	function selectStatsMemberAgeGroup() {
		resetCanvas();
		$.ajax({
			type : 'get',
			url : 'statsmemberagegroup',
			success : function(data) {
				statsSuccessChart(data, 'memberAgeGroup')
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
		</div>
	</div>




</body>
</html>