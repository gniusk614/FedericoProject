









// ============================= 주문페이지 관련 (현구) =======================================

$(function(){
	// 가맹점 선택해야 주문결제클릭 가능하도록.
	$('#selectFranchise').change(function(){
		if($('#selectFranchise').val() != "null" && $('#selectFranchise').val() != "default"){
			$('#payBtn').attr('disabled',false);
		} else {
			$('#payBtn').attr('disabled',true);
		}
	})//kakaoPayBtn change
	
	// 카드결제,카카페이 라디오버튼에 따라 onclick 메서드 바꿔주기
	$('#radioCard').click(function(){
		$('#payBtn').attr('onclick','iamPort()')
		
	})
	$('#radioKakao').click(function(){
		$('#payBtn').attr('onclick','kakaoPay()')
	})
	
}) //ready


// iamPort 결제 
function iamPort(){
	var today =  new Date();
	var hour = today.getHours();
	var minute = today.getMinutes();
		
	
	$('#iamfcId').val($('#selectFranchise').val());
	$('#iamMemo').val($('#clientMemo').val());	
	
	console.log("fcid => "+$('#iamfcId').val());
	console.log("memo => "+$('#iamMemo').val());
	
	var itemQty = $('#save').attr('data-totalQty');
	var menuName = $('#menuName0').html();
	if($('#menuName1').html() != null){
		menuName = $('#menuName0').html() + ' 외';
	} 			
	
	IMP.init('imp15641198'); 	
	IMP.request_pay({ 
	    pg: "inicis",
	    pay_method: "card",
	    merchant_uid: $('#client_Name').html()+hour+minute,
	    name: menuName,
	    amount: 100,
	    buyer_name: $('#client_Name').html(),
	    buyer_tel: $('#client_Phone').html(),
	    buyer_addr: $('#client_address').html(),
	    buyer_postcode: "01181"
	}, function (rsp) { 
	    if (rsp.success) {
	        $('#iamForm').submit();
	    } else {
	    	alert('결제가 실패되었습니다.\n다시 시도해주세요.')
	    }
	});
}



// 카카오페이 결제
function kakaoPay(){
	
	var menuName = $('#menuName0').html();
	var itemQty = $('#save').attr('data-totalQty');
	if($('#menuName1').html() != null){
		menuName = $('#menuName0').html() + ' 외';
	} 
	$.ajax({
		url: 'kakaoPay',
		data:{
			memo: $('#clientMemo').val(),
			fcId: $('#fcId').html(), 
			partner_order_id: '0000000',
			partner_user_id: $('#client_Name').html(),
			item_name: menuName,
			quantity: itemQty,
			total_amount: $('#save').attr('data-totalPrice')
		},
		dataType: 'json',
		success: function(data){
			alert("카카오페이로 결제가 진행됩니다.");
			var url = data.next_redirect_pc_url;
			window.open(url
			); /*'width=500px, height=700px '*/
		},
		error: function(error){
			alert('에러' + error);
		}
	})//ajax
}





// 주문페이지 지역 선택시 가맹점option 바뀌도록
function selectArea(){
	var area = $('#selectarea').val();
	if  (area == 'default'){
		$('#selectFranchise').html(
							'<option value="default">- - -</option>'
							)	
	} else {
		$.ajax({
			type: 'get',
			url : 'selectarea',
			data : {area : area},
			success: function(data){
				if(data.success == 'success'){
					$('#selectFranchise').html(
						'<option value="null">선택하세요</option>'
					);
					var list = data.list;
					$.each(list, function(FranchiseVO, index){
						$('#selectFranchise').append(
						'<option value="'+index.fcId+'" data-address="' + index.fcAddress 
						+ '" data-phone=' + index.fcPhone + '    >'+index.fcId+'</option>'
						)	
					})
				} else{
					$('#selectFranchise').html('');
					alert('죄송합니다.\n가맹점이 없는 지역입니다.')
				}
			},
			error: function(){
				alert('통신 장애입니다.\n다시 시도해주세요.')	
				location.reload();				
			}
		})//ajax
		$('#fcId').html('');
		$('#fcPhone').html('');
		$('#fcAddress').html('');
	}
}//selectDistrict


// 가맹점 선택하면 가맹점 정보 나오도록.
function selectFc(){
	$selected = $('#selectFranchise option:selected');
	if($selected.attr('data-phone') != null){
		var fcPhone = $selected.attr('data-phone');
		fcPhone = fcPhone.substring(0,3)+'-'+fcPhone.substring(3,7)+'-'+fcPhone.substring(7);
	}
	if ($selected.val() == 'default' || $selected.val() == 'null'){
		$('#fcId').html('');
		$('#fcPhone').html('');
		$('#fcAddress').html('');
	} else{
		$('#fcId').html($selected.val());
		$('#fcPhone').html('( '+fcPhone+' )');
		$('#fcAddress').html($selected.attr('data-address'));	
	}
	
}



// ============================= 주문페이지 관련 (현구) =======================================

// ============================= 메뉴조회, 비회원 장바구니 관련 (현구) =======================================

$(function(){
	
	// 모달닫힐떄 장바구니 수량 1로 리셋
	$('#addCartModal').on('hidden.bs.modal', function(){
		$('#addCartQty').html(1);
	})
	
}) //ready


// 콤마찍기 함수
function comma(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}


// 비회원 장바구니모달 열기
function showAddCartModal(menuIndex){
	$('#addCartModal').modal('show');
	$('#btn-addCart').attr('onclick','addCartNoneMember('+menuIndex+')');
}


// 장바구니 수량조절 함수
function arrowUp(inputId){
	$('#'+inputId).html(Number($('#'+inputId).html())+1);
		arrowAction(inputId);
	
}

function arrowDown(inputId){
	if(Number($('#'+inputId).html())>1){
		$('#'+inputId).html(Number($('#'+inputId).html())-1);
		if($('#cartSize').val()>0){
			arrowAction(inputId);
		}	
	}
}

// 장바구니 수량조절 누를시 실행할 함수 묶음
function arrowAction(inputId){
	saveChangeOn($('#'+inputId).attr('data-index'));
	priceChange($('#'+inputId).attr('data-index'));
	calTotalPrice();
}


// 장바구니 메뉴수량조절시 변경저장 버튼 바뀜
function saveChangeOn(index){
	$('#saveChangeNM'+index).attr({
		onclick : 'updateCartQtyNM('+index+')',
		class : 'btn badge bg-danger text-wrap'
	})
	$('#saveChangeM'+index).attr({
		onclick : 'updateCartQtyM('+index+')',
		class : 'btn badge bg-danger text-wrap'
	})
}

function saveChangeOff(index){
	$('#saveChangeNM'+index).attr({
		onclick : '',
		class : 'badge bg-secondary text-wrap'
	})
	$('#saveChangeM'+index).attr({
		onclick : '',
		class : 'badge bg-secondary text-wrap'
	})
}

// 장바구니 수량 변동시 합계 변경
function calTotalPrice(){
	var cartSize = $('#cartSize').val();
	var totalPrice = 0;
	var rowPrice; 
	for(var i = 0; i<cartSize; i++){
		rowPrice = $('#cartQty'+i).html() * $('#cartQty'+i).attr('data-price');
		totalPrice = totalPrice + rowPrice;
	}
	$('#totalPrice').html(comma(totalPrice));
}
// 장바구니 수량변경 시 금액 변경
function priceChange(index){
	var price = $('#cartQty'+index).attr('data-price');
	var qty =  $('#cartQty'+index).html();
	price = comma(price*qty);
	$('#menuPrice'+index).html(price+'원')
}


// 메뉴화면 장바구니 버튼 보였다 안보였다
function btnShow(index){
	$('#hidden'+index).css('display','inline-block');
	$('#hiddenbtn'+index).css('display','inline-block');
}
		
function btnHide(index){

	$('#hidden'+index).css('display','none');
	$('#hiddenbtn'+index).css('display','none');
}


//비회원 장바구니에 메뉴 추가
function addCartNoneMember(menuIndex){
	
	$.ajax({
		type: 'get',
		url: 'addCartNM',
		data: {
			menuIndex: menuIndex,
			menuQty: $('#addCartQty').html()			
		},
		success: function(data){
			if(data.success == 'success'){
				alert('장바구니에 담았습니다.');
				$('#addCartModal').modal('hide');
				$('#listSize').html(Number($('#listSize').html())+1);
			} else{
				alert('통신장애로 실패했습니다.<br>다시 시도해주세요.');
			}
		},
		error: function(){
			alert('통신장애로 실패했습니다.<br>다시 시도해주세요.');
		}
	})//ajax
}//addCart

// 비회원 장바구니 수량변경 저장
function updateCartQtyNM(index){
	$.ajax({
		type: 'get',
		url: 'updateCartNM',
		data: {
			menuQty : $('#cartQty'+index).html(),
			index : index
			},
		success: function(data){
			if(data.success == 'success'){
				saveChangeOff(index);
			} else{
				alert('통신 장애입니다.<br>다시 시도해주세요.')
			}
		},
		error: function(){
			
		}
	})//ajax
}

//비회원 장바구니 항목 삭제
function deleteCartMenuNM(index){
	if(confirm('정말 삭제하시겠습니까?')){
		$.ajax({
			type: 'get',
			url: 'deleteCartNM',
			data: {index : index},
			success: function(){
				$('#divdiv').load('cart?m=n #divdiv');
				$('#listSize').html(Number($('#listSize').html())-1);
			},
			error: function(){
				alert('통신 장애입니다.<br>다시 시도해주세요.')
			}	
		})//ajax
	}
}


// ============================= 메뉴조회, 비회원 장바구니 관련 (현구) =======================================



// ============================= 메뉴조회, 회원 장바구니 관련 (현구) =======================================


// 회원 장바구니모달 열기
function showAddCartModalMember(menuIndex){
	$('#addCartModal').modal('show');
	$('#btn-addCart').attr('onclick','addCartMember('+menuIndex+')');
}

// 회원 장바구니에 메뉴 추가
function addCartMember(menuIndex){
	$.ajax({
		type: 'get',
		url: 'addCartM',
		data: {
			menuIndex: menuIndex,
			clientId: $('#clientloginId').attr('data-clientloginid'),
			menuQty: $('#addCartQty').html()			
		},
		success: function(data){
			if(data.success == 'success'){
				alert('장바구니에 담았습니다.');
				$('#addCartModal').modal('hide');
				$('#listSize').html(Number($('#listSize').html())+1);
			} else{
				alert('통신장애로 실패했습니다.<br>다시 시도해주세요.');
			}
		},
		error: function(){
			alert('통신장애로 실패했습니다.<br>다시 시도해주세요.');
		}
	})//ajax
}//addCart


// 회원 장바구니 수량변경 저장
function updateCartQtyM(index){
	$.ajax({
		type: 'get',
		url: 'updateCartM',
		data: {
			menuQty : $('#cartQty'+index).html(),
			cartSeq : $('#cartQty'+index).attr('data-seq'),
			clientId : $('#clientloginId').attr('data-clientloginid')
			},
		success: function(data){
			if(data.success == 'success'){
				saveChangeOff(index);
			} else{
				alert('통신 장애입니다.<br>다시 시도해주세요.')
			}
		},
		error: function(){
			
		}
	})//ajax
}

// 회원 장바구니 항목 삭제
function deleteCartMenuM(index){
	if(confirm('정말 삭제하시겠습니까?')){
		$.ajax({
			type: 'get',
			url: 'deleteCartM',
			data: {
				cartSeq : $('#cartQty'+index).attr('data-seq')		
				},
			success: function(){
				$('#divdiv').load('cart?m=y #divdiv');
				$('#listSize').html(Number($('#listSize').html())-1);				
			},
			error: function(){
				alert('통신 장애입니다.<br>다시 시도해주세요.')
			}	
		})//ajax
	}		
}






// ============================= 메뉴조회, 회원 장바구니 관련 (현구) =======================================


// ============================= 로그인 회원관련 (광훈) =======================================
var nameChecked = false




var cidCheck=false; //아이디
var cidDubCheck=false;//중복확인
var cpCheck=false;//비밀번호확인
var cprCheck=false;//비밀번호중복
var cadCheck=false;//주소입력 확인
var cemCheck=false;//이메일입력 확인
var cemserverCheck=false;//이메일입력 확인
$(function(){
	//이름 체크
	$('#nonClientName').focusout(function(){
		if($(this).val().length<1){
			$(this).removeClass('is-valid')
			$(this).addClass('is-invalid')
			$('#failMessage').html('이름을 입력해주세요')
			nameChecked = false;
		}else{
			$(this).removeClass('is-invalid')
			$(this).addClass('is-valid')
			nameChecked = true;
		}
	})//focusout

	
	//주소창 닫힐시
	$('#addressModal').on('hidden.bs.modal', function() {
		$('#address').val('');
		$('#addressDetail').val('');
	})
	
	//가입시 핸드폰인증창 닫힐시
	$('#phoneCheckModal').on('hidden.bs.modal', function() {
		$('input[name=clientName]').val($('#nonClientName').val());
		$('input[name=clientPhone]').val($('#inputPhoneNumber').val());
		
		$('#nonClientName').val('');
		$('#inputPhoneNumber').val('');
		$('#inputCertifiedNumber').val('');
		
		$('#nonClientName').removeClass('is-invalid');
		$('#inputPhoneNumber').removeClass('is-invalid');
	    $('#inputCertifiedNumber').removeClass('is-invalid');
	    
	    $('#nonClientName').removeClass('is-valid');
	    $('#inputPhoneNumber').removeClass('is-valid');
	    $('#inputCertifiedNumber').removeClass('is-valid');
	})
	
	
	//Email 직접입력
	$("#selectServer").on("change", function(){
	    if ($(this).val() == "etc") {
	        $('#emailServer').val('');
	        $('#emailServer').prop("readonly",false);

	    } else {
	    	 $('#emailServer').val($(this).val());
	    	 $('#emailServer').prop("readonly",true);
	    }
	});
	
	

	// 회원가입ID
	$('#clientId').focusout(function() {
		cidCheck = clientIdCheck();
		if (cidCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
		}
	});// id_focusout

	// 비밀번호
	$('#clientPassword').focusout(function() {
		cpCheck = clientPwCheck();
		if (cpCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
			$('#clientPasswordRepeat').attr("disabled", true)
		} else {
			// $(this).removeClass('is-invalid');
			// $(this).addClass('is-valid');
			$('#clientPasswordRepeat').attr("disabled", false)
		}
		$('#clientPasswordRepeat').focus();
	});// password_focusout

	// 비밀번호확인
	$('#clientPasswordRepeat').focusout(function() {
		cprCheck = clientPwrpCheck();
		if (cprCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
			$('#clientPassword').removeClass('is-valid');
			$('#clientPassword').addClass('is-invalid');
		} else {
			$('#clientPassword').removeClass('is-invalid');
			$('#clientPassword').addClass('is-valid');
			$(this).removeClass('is-invalid');
			$(this).addClass('is-valid');
		}
	})
	//이메일확인
	$('#inputEmail').focusout(function() {
		cemCheck = clientEmailCheck();
		cemserverCheck = clientEmailServerCheck();
		if (cemCheck == false || cemserverCheck==false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
			$('#emailServer').removeClass('is-valid');
			$('#emailServer').addClass('is-invalid');
			
		} else {
			$('#emailServer').removeClass('is-invalid');
			$('#emailServer').addClass('is-valid');
			$(this).removeClass('is-invalid');
			$(this).addClass('is-valid');
			email = $(this).val()+"@"+$('#emailServer').val();
			$('#clientEmail').val(email)
		}
		
	});// id_focusout
	//email서버 포커스아웃시
	$('#emailServer').focusout(function() {
		cemCheck = clientEmailCheck();
		cemserverCheck = clientEmailServerCheck();
		if (cemCheck == false || cemserverCheck==false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
			$('#inputEmail').removeClass('is-valid');
			$('#inputEmail').addClass('is-invalid');
			
		} else {
			$('#inputEmail').removeClass('is-invalid');
			$('#inputEmail').addClass('is-valid');
			$(this).removeClass('is-invalid');
			$(this).addClass('is-valid');
			email = $('#inputEmail').val()+"@"+$(this).val();
			$('#clientEmail').val(email)
		}
	});// id_focusout
	//주소창 포커스아웃시
	$('#addressDetail').focusout(function() {
		cadCheck = clientAddressCheck();
		if (cadCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
			$('#address').removeClass('is-valid');
			$('#address').addClass('is-invalid');
			
		} else {
			$('#address').removeClass('is-invalid');
			$('#address').addClass('is-valid');
			$(this).removeClass('is-invalid');
			$(this).addClass('is-valid');
			address = $('#address').val()+" "+$(this).val();
			$('#clientAddress').val(address)
		}
	});// id_focusout
	
	
	
	

})//ready

//클릭이펙트
function clickEffect(id){
	$('.checked').css({
		"color" : 'gray',
		"border-bottom" : "1px solid lightgray"
		
	});
	$('#'+id).css({
		"color" : 'black',
		"border-bottom" : "2px solid black"
	});
}//clickEffect

//개인정보수집동의 체크상태
var checkboxChecked = false 
//로그인,비회원주문,주문조회 화면 변경시켜주는
function showdiv(id) {
	checkboxChecked = false;
	$('.checkbox_yes').css('display','none');
	$('.checkbox_no').css('display','inline');
	if (id == 'clientLogin') {
		$('#outer_1').css('display', 'block');
		$('#outer_2').css('display', 'none');
		$('#innerTitle').css('display','block');
		$('#inner_1').css('display', 'block');
		$('#inner_2').css('display', 'none');

	} else if (id == 'nonOrder') {
		$('#outer_1').css('display', 'block');
		$('#outer_2').css('display', 'none');
		$('#innerTitle').css('display','none');
		$('#inner_1').css('display', 'none');
		$('#inner_2').css('display', 'block');
		
	} else {
		$('#outer_1').css('display', 'none');
		$('#outer_2').css('display', 'block');
	}

}


//아이콘변경
function checkboxCheck() {
	if(checkboxChecked == false){
		$('.checkbox_no').css('display','none');
		$('.checkbox_yes').css('display','inline');
		checkboxChecked = true;
	}else{
		$('.checkbox_yes').css('display','none');
		$('.checkbox_no').css('display','inline');
		checkboxChecked = false;
	}
}//checkboxCheck

//핸드폰 인증 객체
var phoneChecked = false
//인증메시지 전송
function sendSms(){
	if($('#inputPhoneNumber').val().length<1){
		$('#inputPhoneNumber').addClass('is-invalid');
		alert('휴대폰번호를 입력해주세요');
	}else{
		$('#inputPhoneNumber').removeClass('is-invalid');
    var phoneNumber = $('#inputPhoneNumber').val();
    $.ajax({
        type: "GET",
        url: "sendSms",
        data: {
            clientPhone : phoneNumber
        },
        success: function(resultData){
        	if(resultData.selectOne!=null){
        		alert('이미 가입된 정보가 있습니다. 로그인 후 이용해주세요.');
        		location.reload();
        	}else{
        	  alert('인증번호 발송 완료!');
        	  $('#inputCertifiedNumber').attr('readonly',false);
        	  $('#checkBtn').click(function(){
                if($.trim(resultData.numStr)==$('#inputCertifiedNumber').val()){
                    alert('휴대폰 인증이 정상적으로 완료되었습니다.')
                    $('#inputPhoneNumber').removeClass('is-invalid');
                    $('#inputCertifiedNumber').removeClass('is-invalid');
                    $('#inputPhoneNumber').attr('readonly',true).addClass('is-valid');
                    $('#inputCertifiedNumber').attr('readonly',true).addClass('is-valid');
                    $('#nonOrderBtn').attr('disabled',false);
                    $('#phoneCheckModal').modal('hide');
                    $('#button-addon2').attr('disabled',true)
                    $('#checkBtn').attr('disabled',true)
                    $('#joinPhoneCheckBtn').attr('onClick',false).css({
                    	cursor: 'default'
                    });
                    $('#checkText').html('인증을 완료하였습니다.')
                    phoneChecked=true;
                }else{
                   alert('휴대폰 인증에 실패하였습니다. 인증번호를 확인해주세요.')
                   $('#inputPhoneNumber').removeClass('is-valid');
                   $('#inputCertifiedNumber').removeClass('is-valid');
                   $('#inputPhoneNumber').addClass('is-invalid');
                   $('#inputCertifiedNumber').addClass('is-invalid');
                   phoneChecked=false;
                }
            })
        }},//success
        error: function(){
			alert('서버오류입니다.')
		}	
    })
	}
}


//개인정보동의 내용 모달
function showAgreeModal(){
	$('#agreeModal').modal('show');
}


//비회원주문 클릭시 조건 다 채웠는지 확인
function nonOrder(){
	if(phoneChecked==true && checkboxChecked==true && nameChecked==true){
		if (confirm('주문페이지로 이동하시겠습니까?')) {
			return true;
		} else {
			return false;
		}
	}
	if(nameChecked==false){
		$('#nonClientName').addClass('is-invalid');
		$('#failMessage').html('이름을 입력해주세요.');
		return false;
	}
	if(phoneChecked==false){
		$('#inputPhoneNumber').addClass('is-invalid');
		alert('휴대폰인증을 진행해주세요.');
		return false;
	}
	if(checkboxChecked==false){
		alert('개인정보 수집/이용을 동의해야만 주문이 가능합니다.')
		return false;
	}
	else{
		return false
	}
}//nonOrder

//주소검색 완료 후 주소 자동입력
function inputAddress(){
	$('#nonAddress').html($('#address').val());
	$('#nonAddressDetail').html($('#addressDetail').val());
	$('input[name=nonAddress]').val($('#address').val()+" "+$('#addressDetail').val());
	$('#addressModal').modal('hide');
}

//장바구니 유무에 따른 경로 다르게 주기
function moveOrder(flag){
	if (flag=='1'){
		$('#jumun').attr('action', 'orderInfo');
	}else{
		$('#jumun').attr('action','menuList?menuFlag=pizza');
	}
	$('#jumun').submit();
}

//주문페이지 조건에따른 동작제어
function joinCheck(){
	if(phoneChecked==true && checkboxChecked==true && nameChecked==true){
		if (confirm('주문페이지로 이동하시겠습니까?')) {
			return true;
		} else {
			return false;
		}
	}
	if(nameChecked==false){
		$('#nonClientName').addClass('is-invalid');
		$('#failMessage').html('이름을 입력해주세요.');
		return false;
	}
	if(phoneChecked==false){
		$('#inputPhoneNumber').addClass('is-invalid');
		alert('휴대폰인증을 진행해주세요.');
		return false;
	}
	if(checkboxChecked==false){
		alert('개인정보 수집/이용을 동의해야만 주문이 가능합니다.')
		return false;
	}
	else{
		return false
	}
}//nonOrder
var AllCheckboxChecked = false;
var serviceCheckboxChecked = false;
var gpsCheckboxChecked = false;
var smsCheckboxChecked = false;
var emailCheckboxChecked = false;
//가입약관 체크박스 동작제어
function joinCheckboxCheck(flag) {
	if(flag=='0'){
		if(AllCheckboxChecked == false){
			$('.bi-check-circle-fill').css('display','inline');
			$('.bi-check-circle').css('display','none');
			$('#smsCheck').val('Y');
			$('#emailCheck').val('Y');
			AllCheckboxChecked = true;
			checkboxChecked = true;
			serviceCheckboxChecked = true;
			gpsCheckboxChecked = true;
			smsCheckboxChecked = true;
			emailCheckboxChecked = true;
		}else{
			$('.bi-check-circle').css('display','inline');
			$('.bi-check-circle-fill').css('display','none');
			$('#smsCheck').val('N');
			$('#emailCheck').val('N');
			AllCheckboxChecked = false;
			checkboxChecked = false;
			serviceCheckboxChecked = false;
			gpsCheckboxChecked = false;
			smsCheckboxChecked = false;
			emailCheckboxChecked = false;
		}
	}// 모든약관에 동의
	else if(flag=='1'){
		if(serviceCheckboxChecked == false){
			$('#checkbox_yes_1').css('display','inline');
			$('#checkbox_no_1').css('display','none');
			serviceCheckboxChecked = true
		}else{
			$('#checkbox_yes_1').css('display','none');
			$('#checkbox_no_1').css('display','inline');
			serviceCheckboxChecked = false;
		}
	}//서비스 이용약관 동의
	else if(flag=='2'){
		if(checkboxChecked == false){
			$('#checkbox_yes_2').css('display','inline');
			$('#checkbox_no_2').css('display','none');
			checkboxChecked = true
		}else{
			$('#checkbox_yes_2').css('display','none');
			$('#checkbox_no_2').css('display','inline');
			checkboxChecked = false;
		}
	}//개인정보 수집/이용동의
	else if(flag=='3'){
		if(gpsCheckboxChecked == false){
			$('#checkbox_yes_3').css('display','inline');
			$('#checkbox_no_3').css('display','none');
			gpsCheckboxChecked = true
		}else{
			$('#checkbox_yes_3').css('display','none');
			$('#checkbox_no_3').css('display','inline');
			gpsCheckboxChecked = false;
		}
	}//위치기반서비스 이용동의
	else if(flag=='sms'){
		if(smsCheckboxChecked == false){
			$('#smsCheckbox_yes').css('display','inline');
			$('#smsCheckbox_no').css('display','none');
			$('#smsCheck').val('Y');
			smsCheckboxChecked = true
		}else{
			$('#smsCheckbox_yes').css('display','none');
			$('#smsCheckbox_no').css('display','inline');
			$('#smsCheck').val('N');
			smsCheckboxChecked = false;
		}
	}//문자서비스 이용동의
	else if(flag=='email'){
		if(emailCheckboxChecked == false){
			$('#emailCheckbox_yes').css('display','inline');
			$('#emailCheckbox_no').css('display','none');
			$('#emailCheck').val('Y');
			emailCheckboxChecked = true
		}else{
			$('#emailCheckbox_yes').css('display','none');
			$('#emailCheckbox_no').css('display','inline');
			$('#emailCheck').val('N');
			emailCheckboxChecked = false;
		}
	}//이메일서비스 이용동의
}//checkboxCheck

//회원가입 약관 동의 후 버튼
function joinAgreeBtn(){
	if (serviceCheckboxChecked == true && checkboxChecked == true && 
			gpsCheckboxChecked == true && phoneChecked == true){
		if (confirm('회원가입 페이지로 이동하시겠습니까?')) {
			return true;
		} else {
			return false;
		}
	}if (phoneChecked==false){
		alert('휴대폰인증을 완료해주세요.');
		return false;
	}else{
		alert('필수 약관에 모두 동의하셔야합니다.')
		return false;
	}
}

// 고객ID 중복체크
function clientIdDubCheck(){
		cidCheck = clientIdCheck();
		if (cidCheck == true) {
			$.ajax({
				type : "post",
				url : "clientSelectOne?clientId=" + $('#clientId').val(),
				success : function(resultData) {
					if (resultData.message != null) {
						console.log(resultData.message)
						$('#clientId').removeClass('is-invalid');
						$('#clientId').addClass('is-valid');
						$('#cidsuccessMessage').html('사용가능한 ID입니다.');
						cidDubCheck = true;
					} else {
						$('#clientId').removeClass('is-valid');
						$('#clientId').addClass('is-invalid');
						$('#cidMessage').html('이미 등록된 ID입니다.');
						cidDubCheck = false;
					}
				},
				error : function() {
					alert("Ajax 오류");
					cidDubCheck = false;
				}
			});// ajax
		}// if
	}
	






//가입 입력조건확인
function clientIncheck() {
	if (cidCheck == false || cidDubCheck == false) {
		$('#clientId').addClass('is-invalid');
		$('#cidMessage').html('아이디를 확인하세요');
	}
	if (cpCheck == false) {
		$('#clientPassword').addClass('is-invalid');
		$('#cpMessage').html('password를 확인하세요');
	}
	if (cprCheck == false) {
		$('#clientPasswordRepeat').addClass('is-invalid');
		$('#cprMessage').html('password를 확인하세요');
	}
	if (cadCheck == false) {
		$('#address').addClass('is-invalid');
		$('#cadMessage').html('주소를 입력해주세요');
	}
	if (cemCheck == false || cemserverCheck==false) {
		$('#inputEmail').addClass('is-invalid');
		$('#emailServer').addClass('is-invalid');
		$('#cemMessage').html('Email을 확인하세요');
	}
	if (cidCheck == true && cpCheck == true && cprCheck == true 
			&& cadCheck == true && cemCheck == true && cemserverCheck==true) {
		if(confirm('가입을 진행하시겠습니까?')==true) {
			return true;
		} else {
			return false;
		}
	} else
		return false;
}// inCheck

//비회원주문조회 조건체크
function nonOrderInfoCheck(){
	if($('#orderNonName').val()<1){
		$('#orderNonName').addClass('is-invalid');
		alert('고객명을 입력해주세요');
		return false
	}
	if($('#orderNonPhone').val()<1){
		$('#orderNonPhone').addClass('is-invalid');
		alert('핸드폰번호를 입력해주세요');
		return false
	}
	if(checkboxChecked==false){
		alert('개인정보 수집/이용에 동의하셔야합니다.');
		return false
	}else{
		return true
	}
}

function orderCancel(num){
	$.ajax({
		type: "get",
		url: "orderCancel",
		data:{
			orderNumber : num
		},
		success: function(res){
			if(res.success!=null){
				alert('주문취소가 완료되었습니다. \n 결제취소는 카드사 사정으로 1~2시간 소요됩니다.');
				location.reload();
			}else{
				alert('주문취소에 실패했습니다. 매장에 문의해주세요.');
			}
		},error : function(){
			alret('통신장애입니다. 잠시후 다시 시도해주세요.')
		}
	})
	
}






// ============================= 매장찾기 (민석) =======================================




























