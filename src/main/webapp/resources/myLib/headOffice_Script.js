$(function() {
	
//===============< 사원리스트 스크립트(광훈) >============================
	//테이블 페이징기능
//	$("#table_id").DataTable();



	
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
	
	// ** 계정생성 클릭시 모달창
	$('#joinBtn').click(function() {
		$('#joinfmodal').modal('show');
	});
	
	// ** 계정 생성 확인버튼 클릭시
	$('#submitBtn').click(function(){
		
		if (confirm('계정을 생성하시겠습니까?')){
			$.ajax({
			type:"post",
			url:"staffJoin",	
			data:{
				staffCode: $('#code').val(),
				hoPassword: $('#hoPassword').val(),
				staffName: $('#name').val(),
				staffPosition: $('#position').val(),
				staffPhone: $('#phone').val(),
				staffEmail: $('#email').val()
			},
			success:function(data){
				if(data.success == 'success'){
					alert('계정생성에 성공했습니다.');
					location.reload();
					}
				if(data.success=='fail'){
					alert('계정생성에 실패했습니다.');
				}
			},
			error:function(){
				alert("서버와 접속에 실패했습니다.")
			}
			})//ajax 
		}
		
		
		
	})
	
	
	
	
	
	
//====================================================================	

// ===============< 사원계정생성 스크립트(광훈) >============================

	
	
	
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


});//ready
	
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



//===============< 가맹점발주관련(현구) >============================

$(function(){
	
	// 자재상세조회 modal 닫힐 시 내용 clear
	$('#fcOrderDetailModal').on('hidden.bs.modal', function(){
		$('#fcOrderDeatilTableBody').html('');
	})

})//ready



//자재 상세조회 modal 열기
function fcOrderDetailForm(fcOrderSeq){
	
	$.ajax({
		type: 'get',
		url: 'fcorderdetail',
		data:{
			fcOrderSeq : fcOrderSeq
		},
		success: function(data){
			var list = data.list;
			var sumCol = 0;
			$.each(list, function(index, vo){
				var	itemPrice = comma(vo.itemInfoVO.itemPrice);
				var itemQty = comma(vo.itemQty);
				var sumRow = comma(vo.itemInfoVO.itemPrice*vo.itemQty);
				sumCol = sumCol + (vo.itemInfoVO.itemPrice*vo.itemQty);
				console.info('합계' + sumCol);
				$('#fcOrderDeatilTableBody').append(
					'<tr><th>'+vo.fcOrderDetailSeq+'</th><td>'+vo.itemInfoVO.itemFlag
					+'</td><td>'+vo.itemInfoVO.itemName+'</td><td>'+itemQty
					+'</td><td>'+vo.itemInfoVO.itemUnit+'</td><td>'+itemPrice
					+'</td><td>'+sumRow+'</td></tr>' 
				);//append
			}) //each
			
			sumCol = comma(sumCol);
			$('#fcOrderDetailModalSumCol').html('합계 : '+sumCol);
			$('#fcOrderNumber').attr('ordernumber',fcOrderSeq);
			$('#fcOrderNumber').html('  &nbsp;발주번호 : '+fcOrderSeq);
			$('#fcOrderDetailModal').modal('show');
		},
		error: function(){
		}
	})
}//fcOrderDetailForm



// 가맹점 발주 완료처리
function fcOrderComplete(){
	var fcOrderSeq = $('#fcOrderNumber').attr('ordernumber');
	console.log("ordernumber : "+fcOrderSeq);
	
}







//===============< 가맹점발주관련등록(현구) >============================