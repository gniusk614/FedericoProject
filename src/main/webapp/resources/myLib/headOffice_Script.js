
$(function() {


	$('#memberList').click(function(){
		$.ajax({
			type: "Get",
			url : "memberList",
			success: function(resultPage){
				$('#resultPage').html(resultPage)
			},
			error: function(){
				alert("Ajax 오류")
			}
		});// ajax
	});// click
	
	//메인메뉴 자재등록 클릭
	$('#iteminsertf').click(function(){
		$.ajax({
			type: "Get",
			url : "iteminsertf",
			success: function(resultPage){
				$('#resultPage').html(resultPage)
			},
			error: function(){
				alert("Ajax 오류")
			}
		});// ajax
	});// click
	
	$('#modalButton').click(function(){
		$('#modal').modal('show');
	});
	

}); // ready
