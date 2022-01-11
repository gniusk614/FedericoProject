
$(function() {

	
//===============< 사원리스트 스크립트(광훈) >============================

	//**페이지이동
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
	
	//** 검색기능
	// SearchType 이 '---' 면 keyword 클리어
	$('#searchType').change(function() {
		//if ($(this).val()=='n') 
			$('#keyword').val('');
	}); //change
	// 검색후 요청
	$('#searchBtn').on("click", function() {
		self.location="mcplist"
			+"${pageMaker.makeQuery(1)}"
			+"&searchType="
			+$('#searchType').val()
			+'&keyword='
			+$('#keyword').val()
	}); //on_click
	
	$('#modalButton').click(function(){
		$('#modal').modal('show');
	});
	
	
//====================================================================	

	
//===============< 사원계정생성 스크립트(광훈) >============================	
	
	
	$('#memberJoinf').click(function(){
		$.ajax({
			type: "Get",
			url : "memberJoinf",
			success: function(resultPage){
				$('#resultPage').html(resultPage)
			},
			error: function(){
				alert("Ajax 오류")
			}
		});// ajax
	});// click
	
//====================================================================	
	
	
	
	

}); // ready
