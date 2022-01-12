$(function() {

// ===============< 사원리스트 스크립트(광훈) >============================

// **페이지이동
	$('#staffList').click(function() {
		$.ajax({
			type : "Get",
			url : "staffList",
			success : function(resultPage) {
				$('#resultPage').html(resultPage)
			},
			error : function() {
				alert("Ajax 오류")
			}
		});// ajax
	});// click

	// ** 검색기능
	// SearchType 이 '---' 면 keyword 클리어
	$('#searchType').change(function() {
		// if ($(this).val()=='n')
		$('#keyword').val('');
	}); // change
	// 검색후 요청
	$('#searchBtn').on(
			"click",
			function() {
				self.location = "mcplist" + "${pageMaker.makeQuery(1)}"
						+ "&searchType=" + $('#searchType').val() + '&keyword='
						+ $('#keyword').val()
			}); // on_click

	
	
	// ** 돋보기 눌렀을때 모달창 띄우기
	$('.modalbtn').click(function() {
		var staffCode = $(this).attr('id');
		$.ajax({
			type : "Get",
			url : "staffDetail?staffCode=" + staffCode,
			success : function(resultData) {
				$('#staffName').html(resultData.staffDetail.staffName);
				$('#staffCode').html(resultData.staffDetail.staffCode);
				$('#staffPosition').html(resultData.staffDetail.staffPosition);
				$('#staffPhone').html(resultData.staffDetail.staffPhone);
				$('#staffEmail').html(resultData.staffDetail.staffEmail);
				$('#modal').modal('show');
			},
			error : function() {
				alert("Ajax 오류");
			}
		});// ajax
	});
	
// ====================================================================

// ===============< 사원계정생성 스크립트(광훈) >============================

	$('#staffJoinf').click(function() {
		$.ajax({
			type : "Get",
			url : "staffJoinf",
			success : function(resultPage) {
				$('#resultPage').html(resultPage)
			},
			error : function() {
				alert("Ajax 오류")
			}
		});// ajax
	});// click

// ====================================================================

}); // ready

