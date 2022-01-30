/**
 * 
 */








// ============================= 가맹점 홈화면 (현구) =======================================

$(function() {
	// 상세주문조회 닫힐시 모달 clear
	$('#orderDetailModal').on('hidden.bs.modal', function() {
		$('#orderDetailBody').html('');
		$('#clientPhone').css('color','black');
		$('#insertRegClientMemo').val('');	
		$('#selectRegClientMemo').val('');	
		$('.modal-body').children('input[type=checkbox]').prop('checked',false);
	})
	
	// 단골,블랙 체크박스 이벤트
	$('.modal-body').children('input[type=checkbox]').change(function(){
		if($(this).is(':checked')){
			$('.modal-body').children('input[type=checkbox]').not($(this))
			.prop('checked',false);
		}
	})
	
	
	//달력
	$('#datetimepicker1').datetimepicker({
		format: 'YY/MM/DD'
		}); 
	
	$('#datetimepicker2').datetimepicker({
		format: 'YY/MM/DD', 	
		useCurrent: false
		}); 
	
	$("#datetimepicker1").on("change.datetimepicker", function (e) { 
		$('#datetimepicker2').datetimepicker('minDate', e.date);
	 }); 

	$("#datetimepicker2").on("change.datetimepicker", function (e) {
		$('#datetimepicker1').datetimepicker('maxDate', e.date); 
	});

	
}) //ready


// 콤마찍기
function comma(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}
// 콤마풀기
function uncomma(str) {
	str = String(str);
	return str.replace(/[^\d]+/g, '');
}


//주문완료 검색 select 동적변경
function completeOrderSearchChange(){
	if($('#completeOrderSearchType').val() == 'orderDate'){
		$('#searchInput').css('display','none');
		$('#datePicker').css('display','block');
		$('#flagYN').attr('class','col-sm-3');
	} else {
		$('#searchInput').css('display','block');
		$('#datePicker').css('display','none');
		$('#flagYN').attr('class','col-sm-6');
		if($('#completeOrderSearchType').val() == 'none'){
			$('#keyword').val('');
		}
	}	
}


//발주 검색 select 동적변경
function fcOrderSearchChange(){
	if($('#completeOrderSearchType').val() == 'orderDate'){
		$('#searchInput').css('display','none');
		$('#datePicker').css('display','block');
		$('#blank').attr('class','col-sm-3');
	} else {
		$('#searchInput').css('display','block');
		$('#datePicker').css('display','none');
		$('#blank').attr('class','col-sm-6');
		if($('#completeOrderSearchType').val() == 'none'){
			$('#keyword').val('');
		}
	}	
}

// 배달소요시간 변경
function updateDeliveryTime(){
	
	$.ajax({
		type: 'get',
		url : 'updatedeliverytime',
		data: {
			deliveryTime: $('#deliveryTime').val(),
			fcId: $('#fcId').attr('data-fcid')
		},
		success: function(data){
			if(data.success = 'success'){
				location.reload;
			}
		},
		error: function(){
			alert('통신 에러입니다\n다시 시도해주세요.');
			location.reload;
		}
	}) //ajax
}


// 상세주문정보 모달 열기
function showOrderDetail(orderNumber, clientAdrress, clientPhone, memo){

	$.ajax({
		type: 'get',
		url: 'selectDetail',
		data: {
			orderNumber: orderNumber,
			fcId: $('#fcId').val(),
			clientPhone: clientPhone
		},
		success: function(data){
			if(data.success == 'success'){
				var list = data.detailList;
				var sumCol = 0;
				$.each(list, function(index, vo) {
				var menuPrice = comma(vo.menuVo.menuPrice);
				var sumRow = comma(vo.menuVo.menuPrice * vo.menuQty);
				sumCol = sumCol + (vo.menuVo.menuPrice * vo.menuQty);
				$('#orderDetailBody').append(
						'<tr><th>' + vo.orderDetailNumber + '</th><td>'
								+ vo.menuVo.menuName + '</td><td>'
								+ vo.menuQty + '</td><td>'
								+ menuPrice + '</td><td>'
								+ sumRow + '</td></tr>');// append
				}) // each
				$('#clientPhone').attr('data-clientPhone', clientPhone);
				clientPhone = clientPhone.substring(0,3)+'-'+clientPhone.substring(3,7)+'-'+clientPhone.substring(7,11)
				sumCol = comma(sumCol);
				$('#clientAdrress').html(clientAdrress);
				$('#memo').html(memo);
				$('#detailNumber').html(orderNumber);
				$('#clientPhone').html(clientPhone);
				$('#orderCompleteBtn').attr('onclick','orderComplete(' + orderNumber + ')');
				$('#orderDetailFooter').html('합계 : ' + sumCol);
				
				// 단골고객 관련
				if(data.fcClient == 'T'){
					$('#clientPhone').attr('onclick','javascript: $("#selectRegClientModal").modal("show");')
					.attr('data-memoseq',data.fcClientVo.seq);
					$('#selectRegClientMemo').val(data.fcClientVo.memo);
					if(data.fcClientVo.gbFlag == 'B'){
						$('#clientPhone').css('color','red');
						$('.selectFlagParent').children('input:checkbox').eq(1).prop("checked", true);
					} else{
						$('#clientPhone').css('color','green');
						$('.selectFlagParent').children('input:checkbox:eq(0)').prop("checked", true);
					}
				} else{
					$('#clientPhone').attr('onclick','javascript: $("#insertRegClientModal").modal("show");')
					$('selectRegClientMemo').val('');	
				}
					
				$('#orderDetailModal').modal('show');
			} else{
				alert('통신 장애로 요청이 실패했습니다.\n잠시후 다시 시도해주세요.')
			}
		},
		error: function(){
			alert('통신 장애로 요청이 실패했습니다.\n잠시후 다시 시도해주세요.')
		}
	})//ajax
}


// 주문 완료처리
function orderComplete(orderNumber){
	$.ajax({
		type: 'get',
		url: 'ordercomplete',
		data: {
			orderNumber: orderNumber
		},
		success: function(data){
			if(data.success == 'success'){
				location.reload();
			} else{
				alert('통신 장애로 요청이 실패했습니다.\n다시 시도해주세요.')
				hideOrderDetailModal();
			}
		},
		error: function(){
			
		}	
	}) //ajax
}

//상세주문정보 모달 닫기
function hideOrderDetailModal(){
	$('#orderDetailModal').modal('hide');
}


// 상세주문정보 모달에서 단골고객등록
function insertRegClient(){
	var memo = $('#insertRegClientMemo').val();
	
	if(memo != null && memo.length>0){
		if($('.insertFlag:checked').length == 1){
			var gbFlag = $('.insertFlag:checked').val();
			$.ajax({
				type: 'get',
				url: 'fcclientreg',
				data: {
					fcId: $('#fcId').val(),
					clientPhone: $('#clientPhone').attr('data-clientPhone'),
					memo: memo,
					gbFlag: gbFlag
				},
				success: function(data){
					if(data.success = "success"){
					alert('등록되었습니다.')
					$('#insertRegClientModal').modal('hide');
					if(gbFlag == 'G'){
					$('#clientPhone').css('color','green')
					.attr({
						'onclick': 'javascript: $("#selectRegClientModal").modal("show");',
						'data-memoseq': data.vo.seq
						})
					} else {
					$('#clientPhone').css('color','red')
					.attr({
						'onclick': 'javascript: $("#selectRegClientModal").modal("show");',
						'data-memoseq': data.vo.seq
						})
					}
					$('#selectRegClientMemo').val(memo);
					
					} else{
						alert('통신장애입니다.\n다시 시도해주세요.')		
						$('#insertRegClientModal').modal('hide');		
					}
				},
				error: function(){
					alert('통신장애입니다.\n다시 시도해주세요.')				
				}
			}) //ajax
		} else {
			alert('단골/블랙리스트 여부를 체크해주세요.')
		} 
	} else{
		alert('내용을 입력해주세요.');
	}
	
} 

// 상세주문정보 모달에서 단골고객수정
function updateRegClient(){
	var memo = $('#selectRegClientMemo').val();
	if(memo != null && memo.length>0){	
		if($('.selectFlag:checked').length == 1){
			var gbFlag = $('.selectFlag:checked').val();
	$.ajax({
			type: 'get',
			url: 'fcclientregupdate',
			data: {
				memo: memo,
				seq: $('#clientPhone').attr('data-memoseq'),
				gbFlag: gbFlag
			},
			success: function(data){
				if(data.success = "success"){
				alert('수정이 완료되었습니다.');
				if(gbFlag == 'G'){
				$('#clientPhone').css('color','green')
				} else {
				$('#clientPhone').css('color','red')
				}				
				$('#selectRegClientModal').modal('hide');
				} else{
					alert('통신장애입니다.\n다시 시도해주세요.')		
					$('#selectRegClientModal').modal('hide');	
				}
			},
			error: function(){
				alert('통신장애입니다.\n다시 시도해주세요.')				
			}
		}) //ajax
		} else {
			alert('단골/블랙리스트 여부를 체크해주세요.')
		}
	} else{
		alert('내용을 입력해주세요.');
	}
}

	
// 상세주문정보 모달에서 단골고객삭제
function deleteRegClient(){
	$.ajax({
			type: 'get',
			url: 'fcclientregdelete',
			data: {
				seq: $('#clientPhone').attr('data-memoseq')
			},
			success: function(data){
				if(data.success = "success"){
				alert('삭제가 완료되었습니다.');
				$('#clientPhone').attr('onclick','javascript: $("#insertRegClientModal").modal("show");')
				.css('color','black');
				$('#insertRegClientMemo').val('');	
				$('#selectRegClientModal').modal('hide');
				} else{
					alert('통신장애입니다.\n다시 시도해주세요.')		
					$('#selectRegClientModal').modal('hide');	
				}
			},
			error: function(){
				alert('통신장애입니다.\n다시 시도해주세요.')				
			}
		}) //ajax	
}








// ============================= 가맹점 홈화면 (현구) =======================================




// ============================= 가맹점 자재발주 (현구) =======================================

	
	




// 행번호
var si=1;


// 자재발주 등록
function fcItemOrder(fcId) {

	var sendData = [];
	for (var i = 0; i < si - 1; i++) {
		var itemQty = Number($('#itemQty' + (i + 1)).val());
		if ($.isNumeric(itemQty) && itemQty != 0) {
			var iInfo = {
				itemIndex: $('#selectItemName' + (i + 1)).attr('data-itemIndex'),
				itemQty: $('#itemQty' + (i + 1)).val()
			}
			sendData.push(iInfo);
		} else {
			alert('입력값이 올바르지 않습니다.\n다시 입력하세요.')
			return;
		}
	}//for
	
	sendData = JSON.stringify(sendData);
	
	
	$.ajax({
		type: 'post',
		url: 'insertfcorder',
		traditional : true,
		data: {
			sendData: sendData,
			fcId: fcId
		},
		success: function(){
			alert('발주서가 전송되었습니다.')
			location.reload();
		},
		fail: function(){
			alert('통신 장애입니다.\n다시 시도해주세요.')
			location.reload();
		}
	})
	}//fcItemOrder
	



// 자재발주 행 추가
function addSelect(){
	if(si == 1){
		$('#notice').html('');
	}
	if(si == 21){
		alert('20행을 넘을 수 없습니다.')
	} else{
		$('#tbody').append(
				'<tr><td>' + si + '</td>'+
			'<td><select class="form-select" id="selectItemFlag' + si + '" onchange="selectItemFlag(' + si + '); calSumCol();">' +
			'<option value="">- - -</option>' +
			'<option value="식자재">식자재</option>' +
			'<option value="부자재">부자재</option>' +
			'</select></td>' +
			'<td><select class="form-select" id="selectItemName' + si + '" onchange="changeItemInfo(' + si + '); calSumCol();">' +
			'<option value="">- - -</option></select></td>' +
			'<td id="itemUnit' + si + '"></td>'+
				'<td id="itemPrice' + si + '"></td>'+
				'<td><input type="text" id="itemQty' + si + '" class="form-control inputQty" onchange="itemQtyChange(' + si +'); calSumCol();"></td>'+
				'<td class="itemSumRow" id="itemSumRow' + si +'"></td></tr>'
			)	
		si += 1;
	}
}//addSelect

// 자재발주 행 삭제
function removeSelect(){
	if(si>1){
		$('#tbody > tr:last').remove();
		calSumCol();
		if(si == 2){
			$('#notice').html('<td colspan="7">+ 버튼을 눌러 행을 추가해주세요.</td>');
		}
		si -= 1;
	} 
}

// 자재발주 분류 선택
function selectItemFlag(index){
	erase(index);	
	var itemFlag = $('#selectItemFlag'+index).val();
	if(itemFlag == ''){
		$('#selectItemName'+index).html('<option>- - -</option>');
	} else {
		$.ajax({
			type: 'get',
			url : 'getitemlist',
			data : {
				itemFlag: itemFlag,
			},
			success: function(data){
				if(data.success == 'success'){
					$('#selectItemName'+index).html(
						'<option value="">선택하세요</option>'
					);
					var list = data.itemList;
					$.each(list, function(i, vo){
						$('#selectItemName'+index).append(
						'<option  value="'+vo.itemIndex+'">'+vo.itemName+'</option>'
						)	
					})
				} else{
					alert('통신 장애입니다.\n다시 시도해주세요.')	
					location.reload();	
				}
			},
			error: function(){
				alert('통신 장애입니다.\n다시 시도해주세요.')	
				location.reload();	
			}
		})//ajax
	}//else
}//selectItemFlag

// 자재발주 품명 선택
function changeItemInfo(index){
	itemIndex = $('#selectItemName'+index).val();
	if(itemIndex == ''){
		$('#selectItemName'+index).html('<option value="">- - -</option>');
		erase(index);
	} else{
		$.ajax({
			type: 'get',
			url : 'getiteminfo',
			data : {
				itemIndex: itemIndex,
			},
			success: function(data){
				if(data.success == 'success'){
					 var price = comma(data.vo.itemPrice); 
					$('#itemUnit'+index).html(data.vo.itemUnit);
					$('#itemPrice'+index).html(price);
					$('#selectItemName'+index).attr('data-itemIndex',data.vo.itemIndex);
				} else{
					alert('통신 장애입니다.\n다시 시도해주세요.')	
					location.reload();	
				}
			},
			error: function(){
				alert('통신 장애입니다.\n다시 시도해주세요.')	
				location.reload();	
			}
		})//ajax	
	}
}//changeItemInfo

// 자재발주 수량,금액 변경
function itemQtyChange(index){
	var price = Number(uncomma($('#itemPrice'+index).html())); 
	var qty = Number($('#itemQty'+index).val());
	var sumRow = price * qty;
	sumRow = comma(sumRow); 
	if(price != '' && price != 0){
		$('#itemSumRow'+index).html(sumRow);
	} else{
		$('#itemQty'+index).val('');
	}
}

// 내용지우기
function erase(index){
	$('#itemUnit'+index).html('');
	$('#itemPrice'+index).html('');	
	$('#itemQty'+index).val('');
	$('#itemSumRow'+index).html('');
}


// 발주금액 합계
function calSumCol(){
	console.log('sumCol');
	var sumCol = 0;
	$('.itemSumRow').each(function(){
		sumCol += Number(uncomma($(this).html()));
	})
	console.log('sumcol' + sumCol);
	sumCol = comma(sumCol);
	$('#sumCol').html(sumCol);
}


// ============================= 가맹점 자재발주 (현구) =======================================

// ============================= 가맹점 자재발주조회 (현구) =======================================


$(function() {

	// 자재상세조회 modal 닫힐 시 내용 clear
	$('#fcOrderDetailModal').on('hidden.bs.modal', function() {
		$('#fcOrderDeatilTableBody').html('');
	})

})// ready


// 발주조회 전체,미확인,확인완료
function selectALLYN(imsi){
	if(imsi == 'A'){
		$('#flag').val('');
	} else if(imsi =='N'){
		$('#flag').val('N');
	} else {
		$('#flag').val('Y');
	}
	
	move();
}

// 발주조회 상세보기 모달open
function fcOrderDetailForm(fcOrderSeq) {
	$.ajax({
		type : 'get',
		url : 'fcorderdetail',
		data : {
			fcOrderSeq : fcOrderSeq
		},
		success : function(data) {
			var list = data.list;
			var sumCol = 0;
			$.each(list, function(index, vo) {
				var itemPrice = comma(vo.itemInfoVO.itemPrice);
				var itemQty = comma(vo.itemQty);
				var sumRow = comma(vo.itemInfoVO.itemPrice * vo.itemQty);
				sumCol = sumCol + (vo.itemInfoVO.itemPrice * vo.itemQty);
				$('#fcOrderDeatilTableBody').append(
						'<tr><th>' + vo.fcOrderDetailSeq + '</th><td>'
								+ vo.itemInfoVO.itemFlag + '</td><td>'
								+ vo.itemInfoVO.itemName + '</td><td>'
								+ itemQty + '</td><td>'
								+ vo.itemInfoVO.itemUnit + '</td><td>'
								+ itemPrice + '</td><td>' + sumRow
								+ '</td></tr>');// append
			}) // each

			sumCol = comma(sumCol);
			$('#fcOrderDetailModalSumCol').html('합계 : ' + sumCol);
			$('#fcOrderNumber').attr('ordernumber', fcOrderSeq);
			$('#fcOrderNumber').html('  &nbsp;발주번호 : ' + fcOrderSeq);
			$('#fcOrderCancel').attr('onclick',"fcOrderCancel(" + fcOrderSeq + ")")
			$('#fcOrderDetailModal').modal('show');
		},
		error : function() {
			alert('통신장애입니다.\n다시 시도해주세요.')
		}
	})
}// fcOrderDetailForm

	





// ============================= 가맹점 자재발주조회 (현구) =======================================







