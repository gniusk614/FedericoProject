/**
 * 
 */








// ============================= 가맹점 홈화면 (현구) =======================================

$(function() {
// 상세주문조회 닫힐시 모달 clear
	$('#orderDetailModal').on('hidden.bs.modal', function() {
		$('#orderDetailBody').html('');
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
		$('#divPlace').css('class','col-sm-3');
	} else {
		$('#searchInput').css('display','block');
		$('#datePicker').css('display','none');
		$('#divPlace').css('class','col-sm-6');
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
function showOrderDetail(orderNumber, clientAdrress){
	
	$.ajax({
		type: 'get',
		url: 'selectDetail',
		data: {
			orderNumber: orderNumber
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
			sumCol = comma(sumCol);
			$('#clientAdrress').html(clientAdrress);
			$('#detailNumber').html(orderNumber);
			$('#orderCompleteBtn').attr('onclick','orderComplete(' + orderNumber + ')');
			$('#orderDetailFooter').html('합계 : ' + sumCol);
				
			$('#orderDetailModal').modal('show');
			} else{
				console.log('실패');
			}
		},
		error: function(){
			console.log('ajax실패');
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

// ============================= 가맹점 홈화면 (현구) =======================================




// ============================= 가맹점 자재발주 (현구) =======================================

	
	




// 행번호
var si=1;


// 자재발주 등록
function fcItemOrder(){
	
	var sendData = [];
	for (var i = 0; i < si-1; i++) {
		
		
		
		
		var iname = i;
		var iname = {
			itemIndex: $('#selectItemName' + (i+1)).attr('data-itemIndex'),
			itemQty: $('#itemQty' + (i+1)).val()
		}//for
		sendData[i] = iname;
		}
	console.log(sendData)	
		
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
				'<td><select class="form-select" id="selectItemFlag' + si + '" onchange="selectItemFlag(' + si + '); calSumCol();">'+
					'<option value="">- - -</option>'+
						'<option value="식자재">식자재</option>'+
						'<option value="부자재">부자재</option>'+
					'</select></td>'+
				'<td><select class="form-select" id="selectItemName' + si + '" onchange="changeItemInfo(' + si + '); calSumCol();">'+
						'<option value="">- - -</option></select></td>'+	
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







