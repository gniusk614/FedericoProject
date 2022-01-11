
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
	
	$('#modalButton').click(function(){
		$('#modal').modal('show');
	});
	

}); // ready
