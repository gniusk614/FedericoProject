
$(function() {

	// ===============< 사원리스트 스크립트(광훈) >============================
	// 테이블 페이징기능
	// $("#table_id").DataTable();

	// ** 검색기능
	// SearchType 이 '---' 면 keyword 클리어
/*	$('#searchType').change(function() {
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
			}); // on_click*/

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

	// ** 모달 닫는버튼 새로고침 기능 추가
	$('.infoClose').click(function() {
		if (click_check == 1) {
			click_check = 0;
		} else
			location.reload();
	})

	// ====================================================================

	// ===============< 사원계정생성 스크립트(광훈) >============================

	// ** 계정생성 클릭시 모달창
	$('#joinBtn').click(function() {
		$('#joinfmodal').modal('show');
	});
	// ** 계정생성 모달 닫힐시
	$('#joinfmodal').on('hidden.bs.modal', function() {
		$('.form-control').val('');
		inputClear();
	});
	// ** 계정생성 모달 열릴시
	$('#joinfmodal').on('show.bs.modal', function() {
		$('#code').focus();
	});

	var click_check = 0; // 2번 클릭시 구분
	// ** 계정디테일에서 정보수정 클릭시
	$('#infoUp').click(
			function() {

				var staffCode = $('#staffCode').html();
				var staffName = $('#staffName').html();
				var staffPosition = $('#staffPosition').html();
				var staffPhone = $('#staffPhone').html();
				var staffEmail = $('#staffEmail').html();

				if (click_check == 0) {
					$('#staffName').html(
							'<input type="text" id="nameUp" value="'
									+ staffName
									+ '" class="form-control" size="7">');
					$('#staffPosition').html(
							'<input type="text" id="positionUp" value="'
									+ staffPosition
									+ '" class="form-control" size="7">');
					$('#staffPhone').html(
							'<input type="text" id="phoneUp" value="'
									+ staffPhone
									+ '" class="form-control" size="7">');
					$('#staffEmail').html(
							'<input type="text" id="emailUp" value="'
									+ staffEmail
									+ '" class="form-control" size="7">');
					$('#passUp').attr("hidden", false);
					$('#passUpRepeat').attr("hidden", false);
					
					click_check = 1;
				} else if (click_check == 1) {
					if (confirm('정보를 수정하시겠습니까?')) {
						$.ajax({
							type : "post",
							url : "staffUpdate",
							data : {
								staffCode : staffCode,
								staffName : $('#nameUp').val(),
								staffPosition : $('#positionUp').val(),
								staffPhone : $('#phoneUp').val(),
								staffEmail : $('#emailUp').val()
							},
							success : function(data) {
								if (data.success == 'success') {
									alert('정보수정에 성공했습니다.');
									$('#staffName').html($('#nameUp').val());
									$('#staffPosition').html(
											$('#positionUp').val());
									$('#staffPhone').html($('#phoneUp').val());
									$('#staffEmail').html($('#emailUp').val());
									click_check = 0;
								}
								if (data.success == 'fail') {
									alert('정보수정에 실패했습니다.');
								}
							},
							error : function() {
								alert("서버와 접속에 실패했습니다.")
							}
						})// ajax
					}// confirm
				}// if

			});// infoUp

	// ** 계정 삭제 확인버튼 클릭시
	$('#staffDeleteBtn').click(function() {
		if (confirm('계정을 삭제하시겠습니까?')) {
			$.ajax({
				type : "get",
				url : "staffDelete?",
				data : {
					staffCode : $('#staffCode').html()
				},
				success : function(data) {
					if (data.success == 'success') {
						alert('계정이 삭제되었습니다.');
						location.reload();
					}
					if (data.success == 'fail') {
						alert('계정삭제에 실패했습니다.');
					}
				},
				error : function() {
					alert("서버와 접속에 실패했습니다.")
				}
			})// ajax
		}
	})

	// ** 계정 생성 확인버튼 클릭시
	$('#submitBtn').click(function() {

		if (incheck() == true) {

			$.ajax({
				type : "post",
				url : "staffJoin",
				data : {
					staffCode : $('#code').val(),
					hoPassword : $('#hoPassword').val(),
					staffName : $('#name').val(),
					staffPosition : $('#position').val(),
					staffPhone : $('#phone').val(),
					staffEmail : $('#email').val()
				},
				success : function(data) {
					if (data.success == 'success') {
						alert('계정생성에 성공했습니다.');
						inputClear();
						location.reload();
					}
					if (data.success == 'fail') {
						alert('계정생성에 실패했습니다.');
						inputClear();
					}
				},
				error : function() {
					alert("서버와 접속에 실패했습니다.");
					inputClear();
				}
			})// ajax
		}
	})

	// ====================================================================

}); // ready

// ===============< 가입시 입력제한조건 (광훈) >============================
// 1) 개별적 오류 확인을 위한 switch 변수(전역)
var cCheck = false;
var pCheck = false;
var prCheck = false;
var dubCheck = false;

// 2) 개별적 오류점검 위한 focusout 이벤트 핸들러 : JQuery
$(function() {
	$('#code').focusout(function() {
		cCheck = codeCheck();
		if (cCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
		} 
	});// id_focusout

	$('#hoPassword').focusout(function() {
		pCheck = pwCheck();
		if (pCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
			$('#passwordRepeat').attr("disabled", true)
		} else {
			$(this).removeClass('is-invalid');
			$(this).addClass('is-valid');
			$('#passwordRepeat').attr("disabled", false)
		}
		$('#passwordRepeat').focus();
	});// password_focusout

	$('#passwordRepeat').focusout(function() {
		prCheck = pwrpCheck();
		if (prCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
		} else {
			$(this).removeClass('is-invalid');
			$(this).addClass('is-valid');
		}
	})

	$('#codeDupcheck').click(function() {
		cCheck = codeCheck();
		if (cCheck == true) {
			$.ajax({
				type : "Get",
				url : "staffDetail?staffCode=" + $('#code').val(),
				success : function(resultData) {
					if (resultData.message != null) {
						$('#code').removeClass('is-invalid');
						$('#code').addClass('is-valid');
						$('#codeSuccessMessage').html('사용가능한 코드입니다.');
						dubCheck = true;
					} else {
						$('#code').removeClass('is-valid');
						$('#code').addClass('is-invalid');
						$('#codeMessage').html('이미 사원정보가 있습니다.');
						dubCheck = false;
					}
				},
				error : function() {
					alert("Ajax 오류");
					dubCheck = false;
				}
			});// ajax
		}//if
	})

});// ready

// 3) submit 여부를 판단&실행 : JS 의 function
function incheck() {
	// 모든 항목에 오류 없음을 확인 : switch 변수
	if (cCheck == false || dubCheck == false) {
		$('#code').addClass('is-invalid');
		$('#codeMessage').html('사원번호(ID)를 확인하세요');
	}
	if (pCheck == false) {
		$('#hoPassword').addClass('is-invalid');
		$('#pMessage').html('password를  확인하세요');
	}
	if (prCheck == false) {
		$('#passwordRepeat').addClass('is-invalid');
		$('#prMessage').html('password를 확인하세요');
	}

	if (cCheck == true && pCheck == true && prCheck == true) {
		if (confirm('계정을 생성하시겠습니까?')) {
			return true;
		} else {
			return false;
		}
	} else
		return false;
}// inCheck

// ** ID 중복 확인하기
function idDupCheck() {
	// id 의 입력값 무결성 점검 확인
	if (iCheck == false) {
		iCheck = idCheck();
	} else {
		// id 중복확인
		// => 입력한 ID를 서버로 보내 중복확인, 결과 처리
		// => url 요청을 서버로 전달(request) 하고, 그 결과(response)를 Open 해줌
		var url = "idcheck?id=" + $('#id').val();
		window
				.open(url, '_blank',
						'toolbar=no,menubar=yes,scrollbars=yes,resizable=yes,width=500,height=400');
	}
}// idDupCheck





// ** input창 클리어
function inputClear() {

	$('#code').removeClass('is-valid');
	$('#code').removeClass('is-invalid');
	$('#hoPassword').removeClass('is-valid');
	$('#hoPassword').removeClass('is-invalid');
	$('#passwordRepeat').removeClass('is-valid');
	$('#passwordRepeat').removeClass('is-invalid');
	$('#passwordRepeat').attr("disabled", true);
}

// ====================================================================

// ===============< 자재등록(현구) >=================================



$(function() {
	// 숫자입력시 콤마찍기
	$("#itemprice").bind('keyup keydown', function() {
		inputNumberFormat(this);
	});
	$("#upitemprice").bind('keyup keydown', function() {
		inputNumberFormat(this);
	});
	// 입력한 문자열 전달
	function inputNumberFormat(obj) {
		obj.value = comma(uncomma(obj.value));
	}
	// 실행함수
	// 콤마찍기
	

});// ready

function comma(str) {
		str = String(str);
		return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	}
	// 콤마풀기
	function uncomma(str) {
			str = String(str);
		return str.replace(/[^\d]+/g, '');
	}

// 자재등록 값체크 및 자재등록 메서드 실행
function itemInsertCheck() {
	var i_name = $('#itemname').val();
	var i_unit = $('#itemunit').val();
	var i_price = $('#itemprice').val();

	console.log("inputcheck" + i_name + i_unit + i_price);

	if (i_name != '' & i_unit != '' & i_price != '') {
		console.log("성공이여?")
		itemInsert();
	} else {
		$('#m_iteminput').html('빈 값은 입력할 수 없습니다.').css({
			fontSize : '0.8em',
			color : 'red',
			fontWeight : 'bold'
		})
	}

}// itemInsertCheck


// 검색조건에 따라 select, input 동적 변경
function changeSearchItemOption(){
	
	$input = $('#changeSearchFinder').children('input');
	$select = $('#changeSearchFinder').children('select');
	if($('#searchType').val() == 'flag'){
		$input.css('display','none')
		.attr('id','keywordHide');
		$select.css('display','block')
		.attr('id','keyword');
	} else{
		$select.css('display','none')
		.attr('id','keywordHide');
		$input.css('display','block')
		.attr('id','keyword');
	}
	
}



// 자재등록
function itemInsert() {
	// 가격 콤마빼기
	var itemprice = $('#itemprice').val();
	itemprice = itemprice.replace(/[^\d]+/g, "");

	$.ajax({
		type : "get",
		url : "iteminsert",
		data : {
			itemFlag : $('#itemflag').val(),
			itemName : $('#itemname').val(),
			itemUnit : $('#itemunit').val(),
			itemPrice : itemprice
		},
		success : function(data) {
			if (data.success == 'success') {
				location.reload();
			}
		},
		error : function() {
			alert("품명은 중복될 수 없습니다.")
		}
	})// ajax
}// iteminsert

// item upadte modal 띄우기
function itemUpdateForm(itemIndex) {
	$.ajax({
		type : "get",
		url : "itemdetail",
		data : {
			itemIndex : itemIndex
		},
		success : function(data) {
			$('#upitemname').val(data.vo.itemName);
			$('#upitemunit').val(data.vo.itemUnit);
			$('#upitemprice').val(data.vo.itemPrice);
			$('#upitemindex').val(data.vo.itemIndex);
			if (data.vo.itemFlag == '식자재') {
				$("#upitemflag option:eq(0)").prop("selected", true);
			} else
				$("#upitemflag option:eq(1)").prop("selected", true);

			$('#itemUpdateModal').modal('show');
		},
		error : function() {
			console.log('실패' + data.vo);
			alert("오류여")
		}
	})
}// itemUpdateForm

// 자재수정 값체크 및 자재수정 메서드 실행
function itemUpdateCheck() {

	var up_name = $('#upitemname').val();
	var up_unit = $('#upitemunit').val();
	var up_price = $('#upitemprice').val();

	if (up_name != '' && up_unit != '' && up_price != '') {
		itemUpdate();
	} else {
		$('#m_itemupdate').html('빈 값은 입력할 수 없습니다.').css({
			fontSize : '0.8em',
			color : 'red',
			fontWeight : 'bold'
		})
	}
}// itemUpdateCheck

// 자재수정
function itemUpdate() {
	// 가격 콤마빼기
	var upitemprice = $('#upitemprice').val();
	upitemprice = upitemprice.replace(/[^\d]+/g, "");
	$.ajax({
		type : "get",
		url : "itemupdate",
		data : {
			itemIndex : $('#upitemindex').val(),
			itemFlag : $('#upitemflag').val(),
			itemName : $('#upitemname').val(),
			itemUnit : $('#upitemunit').val(),
			itemPrice : upitemprice
		},
		success : function(data) {
			if (data.success == 'success') {
				location.reload();
			}
			if (data.success == 'fail') {
				alert('품명은 중복될 수 없습니다.');
			}
		},
		error : function() {
			alert("업데이트 오류입니다.<br>다시 시도해주세요.")
		}
	})// ajax
}

// 자재수정
function itemDelete() {

	if (confirm('정말 삭제하시겠습니까?')) {
		$.ajax({
			type : "get",
			url : "itemdelete",
			data : {
				itemIndex : $('#upitemindex').val(),
			},
			success : function(data) {
				if (data.success == 'success') {
					location.reload();
				}
				if (data.success == 'fail') {
					alert('찾을 수 없는 항목입니다.');
				}
			},
			error : function() {
				alert("삭제 오류입니다.<br>다시 시도해주세요.")
			}
		})// ajax
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
	console.log("세션 => "+ window.sessionStorage);
	console.log("세션 => "+ window.sessionStorage.getItem('loginID'));
	
	
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
function fcOrderFlagUpdate(flag){
	var fcOrderSeq = $('#fcOrderNumber').attr('ordernumber');
	console.log("ordernumber : "+fcOrderSeq);
	console.log("ordernumber : "+flag);
	$.ajax({
		type: 'get',
		url: 'fcordersequpdate?flag='+flag,
		data: {
			fcOrderSeq : fcOrderSeq
		},
		success: function(data){
			if (data.success == 'success'){
			location.reload();
			}
			else{
				alert("시스템 오류입니다.<br>다시 시도해주세요.")
			}
		},	
		error: function(){
			alert("시스템 오류입니다.<br>다시 시도해주세요.")
		}
	})//ajax
}//fcOrderComplete







//===============< 가맹점발주관련등록(현구) >============================

