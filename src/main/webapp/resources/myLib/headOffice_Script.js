
$(function() {


	$('#memberList').click(function(){
		$.ajax({
			type: "Get",
			url : "memberList",
			success: function(resultPage){
				$('#layoutSidenav_content').html(resultPage)
			},
			error: function(){
				alert("Ajax 오류")
		
			}
	
		});// ajax

	});// click
	
	
}); // ready
