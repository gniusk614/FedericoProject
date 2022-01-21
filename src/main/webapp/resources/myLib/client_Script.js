









// ============================= 주문페이지 관련 (현구) =======================================

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
	var fcPhone = $selected.attr('data-phone');
	fcPhone = fcPhone.substring(0,3)+'-'+fcPhone.substring(3,7)+'-'+fcPhone.substring(7);
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


// 장바구니모달 열기
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

$(function(){
	
	
	
	
	
	
})//

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


function showdiv(id) {
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







