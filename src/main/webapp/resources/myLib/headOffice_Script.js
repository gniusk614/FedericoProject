$(function() {
	
//===============< 사원리스트 스크립트(광훈) >============================

	//**페이지이동
	$('#staffList').click(function(){
		$.ajax({
			type: "Get",
			url : "staffList",
			success: function(resultPage){S
				$('#resultPage').html(resultPage)
			},
			error: function(){
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
	
//====================================================================	

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
	
//====================================================================	
	
}); // ready






//===============< 자재등록(현구) >============================


$(function(){
    // 숫자입력시 콤마찍기
    $("#itemprice").bind('keyup keydown',function(){
        inputNumberFormat(this);
    });
    $("#upitemprice").bind('keyup keydown',function(){
        inputNumberFormat(this);
    });
    //입력한 문자열 전달
    function inputNumberFormat(obj) {
        obj.value = comma(uncomma(obj.value));
    }
    //실행함수 
	//콤마찍기
    function comma(str) {
        str = String(str);
        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
    }
    //콤마풀기
    function uncomma(str) {
        str = String(str);
        return str.replace(/[^\d]+/g, '');
    }

});//ready
	
	
// 자재등록 값체크 및 자재등록 메서드 실행
function itemInsertCheck(){
	var i_name = $('#itemname').val();
	var i_unit = $('#itemunit').val();
	var i_price = $('#itemprice').val();
	
	console.log("inputcheck"+i_name + i_unit + i_price);
	
	if (i_name != '' & i_unit != '' & i_price != ''){
		console.log("성공이여?")
		itemInsert();
	}else{
		$('#m_iteminput').html('빈 값은 입력할 수 없습니다.')
		.css({
			fontSize: '0.8em',
			color:'red',
			fontWeight:'bold'
		})}
	
}//itemInsertCheck
		
	
// 자재등록
function itemInsert() {
	// 가격 콤마빼기
	var itemprice = $('#itemprice').val();
	itemprice = itemprice.replace(/[^\d]+/g, "");
	
 	$.ajax({
		type:"get",
		url:"iteminsert",	
		data:{
			itemFlag: $('#itemflag').val(),
			itemName: $('#itemname').val(),
			itemUnit: $('#itemunit').val(),
			itemPrice: itemprice
		},
		success:function(data){
			if(data.success == 'success'){
				location.reload();
				}
		},
		error:function(){
			alert("품명은 중복될 수 없습니다.")
		}
	})//ajax 
}//iteminsert


// item upadte modal 띄우기
function itemUpdateForm(itemIndex){
	$.ajax({
		type:"get",
		url:"itemdetail",	
		data:{
			itemIndex: itemIndex
		},
		success:function(data){
		$('#upitemname').val(data.vo.itemName);
		$('#upitemunit').val(data.vo.itemUnit);
		$('#upitemprice').val(data.vo.itemPrice);
		$('#upitemindex').val(data.vo.itemIndex);
		if(data.vo.itemFlag=='식자재'){$("#upitemflag option:eq(0)").prop("selected", true);}
		else $("#upitemflag option:eq(1)").prop("selected", true);
		
		$('#itemUpdateModal').modal('show');
		},
		error:function(){
			console.log('실패'+data.vo);
			alert("오류여")
		}
	})
}//itemUpdateForm


// 자재수정 값체크 및 자재수정 메서드 실행
function itemUpdateCheck(){
	
	var up_name = $('#upitemname').val();
	var up_unit = $('#upitemunit').val();
	var up_price = $('#upitemprice').val();
		
	if (up_name != '' && up_unit != '' && up_price != '' ){
		itemUpdate();
	}else{
		$('#m_itemupdate').html('빈 값은 입력할 수 없습니다.')
		.css({
			fontSize: '0.8em',
			color:'red',
			fontWeight:'bold'
		})}
}//itemUpdateCheck


// 자재수정
function itemUpdate(){
	// 가격 콤마빼기
	var upitemprice = $('#upitemprice').val();
	upitemprice = upitemprice.replace(/[^\d]+/g, "");
 	$.ajax({
		type:"get",
		url:"itemupdate",	
		data:{
			itemIndex: $('#upitemindex').val(),
			itemFlag: $('#upitemflag').val(),
			itemName: $('#upitemname').val(),
			itemUnit: $('#upitemunit').val(),
			itemPrice: upitemprice
		},
		success:function(data){
			if(data.success == 'success'){
				location.reload();
				}
			if(data.success=='fail'){
				alert('품명은 중복될 수 없습니다.');
			}
		},
		error:function(){
			alert("업데이트 오류입니다.<br>다시 시도해주세요.")
		}
	})//ajax 
}


// 자재수정
function itemDelete(){
	
	if (confirm('정말 삭제하시겠습니까?')){
		$.ajax({
		type:"get",
		url:"itemdelete",	
		data:{
			itemIndex: $('#upitemindex').val(),
		},
		success:function(data){
			if(data.success == 'success'){
				location.reload();
				}
			if(data.success=='fail'){
				alert('찾을 수 없는 항목입니다.');
			}
		},
		error:function(){
			alert("삭제 오류입니다.<br>다시 시도해주세요.")
		}
		})//ajax 
	}
	
}

//===============< 자재등록(현구) >============================
