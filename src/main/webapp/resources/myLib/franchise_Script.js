/**
 * 
 */








// ============================= 가맹점 홈화면 (현구) =======================================

// 상세주문조회 닫힐시 모달 clear
$(function() {
	$('#orderDetailModal').on('hidden.bs.modal', function() {
		$('#orderDetailBody').html('');
	})
})


//콤마찍기
function comma(str) {
	str = String(str);
	return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
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
function showOrderDetail(orderNumber){
	
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












// ============================= 가맹점 홈화면 (현구) =======================================







