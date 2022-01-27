
$(function() {
	$('.fcmodalbtn').click(function() {
		var fcId = $(this).attr('id');
		$.ajax({
			type : "Get",
			url : "fcdetail?fcId=" + fcId,
			success : function(resultData) {
				$('#fcId').html(resultData.fcDetail.fcId);
				$('#fcName').html(resultData.fcDetail.fcName);
				$('#fcAddress').html(resultData.fcDetail.fcAddress);
				$('#fcPhone').html(resultData.fcDetail.fcPhone);
				$('#hoid').html(resultData.fcDetail.hoId);
				$('#fcmodal').modal('show');
			},
			error : function() {
				alert("Ajax 오류");
			}
		});// ajax
	});
	var click_fcCheck = 0;
	$('#fcinfoUp').click(function() {

					var fcId = $('#fcId').html();
					var fcAddress = $('#fcAddress').html();
					var fcPhone = $('#fcPhone').html();
					var hoId = $('#hoid').html();
					var fcName = $('#fcName').html();
						if (click_fcCheck == 0) {
						$('#fcName').html('<input type="text" id="nameUp" value="'
												+ fcName
												+ '" class="form-control" size="7">');
						$('#fcAddress').html('<input type="text" id="addressUp" value="'
												+ fcAddress
												+ '" class="form-control" size="7">');
						$('#fcPhone').html('<input type="text" id="phoneUp" value="'
												+ fcPhone
												+ '" class="form-control" size="7">');
						$('#hoid').html('<input type="text" id="hoidUp" value="'
												+ hoId
												+ '" class="form-control" size="7">');
						$('#passUp').attr("hidden", false);
						click_fcCheck = 1;
					} else if (click_fcCheck == 1) {
						if (confirm('정보를 수정하시겠습니까?')) {
							$.ajax({
								type : "post",
								url : "fcupdate",
								data : {
									fcId : fcId,
									fcName : $('#nameUp').val(),
									fcAddress : $('#addressUp').val(),
									fcPhone : $('#phoneUp').val(),
									hoId : $('#hoidUp').val()
								},
								success : function(data) {
									if (data.success == 'success') {
										alert('정보수정에 성공했습니다.');
											$('#fcName').html($('#nameUp').val());
											$('#fcAddress').html($('#addressUp').val());
											$('#fcPhone').html($('#phoneUp').val());
											$('#hoid').html($('#hoidUp').val());
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
	
	$('#fcmodal').on('hidden.bs.modal', function() {
		if (click_fcCheck == 1) {
			click_fcCheck = 0;
		} else
			location.reload();
	})
	
	
	
	
	
	$('#fcCloseBtn').click(function() {
		if (confirm('폐점처리 하시겠습니까?')) {
			$.ajax({
				type : "get",
				url : "fcclose",
				data : {
					fcId : $('#fcId').html()
				},
				success : function(data) {
					if (data.success == 'success') {
						alert('폐업신청이 완료되었습니다.');
						location.reload();
					}
					if (data.success == 'fail') {
						alert('폐업신청에 실패했습니다.');
					}
				},
				error : function() {
					alert("서버와 접속에 실패했습니다.")
				}
			})// ajax
		}
	})
})//ready

//=============================(통계)====================================

function showChart(flag) {
			let chartLabels = [];
			let chartData = [];
			let chartColor = [];
			let labelcontent ="차트";
			let chartID ="";
			$.ajax({
				type : 'get',
				url : 'chart?flag='+flag,
				dataType : "json",
				success : function(res) {
					let list = res.list
					for (let i = 0; i < list.length; i++) {
						chartLabels.push(list[i].chartLabel);
						chartData.push(list[i].chartCount);
						var RGB_1 = Math.floor(Math.random() * (255 + 1));
						var RGB_2 = Math.floor(Math.random() * (255 + 1));
						var RGB_3 = Math.floor(Math.random() * (255 + 1));
						var strRGBA = 'rgb(' + RGB_1 + ',' + RGB_2 + ','
								+ RGB_3 + ')'
						chartColor.push(strRGBA);
					}
					
					$('.chartCanvas').attr('hidden',true);
					switch(flag) {
					case "month" : chartID=$('#monthChart'); labelcontent="최근 1년간 월벌 매출현황"; break;
					case "day" :   chartID=$('#dayChart'); labelcontent="요일별 판매현황"; break;
					}
					chartID.attr('hidden',false);
					new Chart(chartID, {
						type : 'bar',
						data : {
							labels : chartLabels,
							datasets : [ {
								data : chartData,
								label : labelcontent,
								backgroundColor : chartColor,
								fill : false
							} ]
						},
						options : {
							titles : {
								responsive: false,
								display : true,
								text : "월별 매출현황",
							},
							scales: {
								yAxes: [{
									ticks: {
										beginAtZero: true,
										callback: function (value) {
		                                    if (0 === value % 1) {
		                                        return value;
		                                    }
										}
									}
								}]
							}
						}
					});//그래프
				},
				error : function() {
					alert('에러')
				}
			})
		}













var fcidCheck = false; // => 사원번호
var fclpCheck = false; // =>로그인비번
var fcpCheck = false; // ->비번
var fcprCheck = false; // ->비번확인
var fcdubCheck = false; // ->사원번호중복

$(function() {
	// ==================<가맹정계정생성 (광훈)>==========================
	//담당자 검색클릭시
	$('#fcSearchStaff').click(function() {
		$('#fcSearchModal').modal('show');
	});
	// ** 계정생성 리셋버튼 클릭시 
	$('#fcInputresetBtn').click(function() {
		$('.form-control').val('');
		$('.form-select').val('서울');
		fcInputClear();
	});
	
	
	
	
	
	// 가맹점 ID
	$('#fcId').focusout(function() {
		fcidCheck = fcIdCheck();
		if (fcidCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
		}
	});// id_focusout

	// 비밀번호
	$('#fcPassword').focusout(function() {
		fcpCheck = fcpwCheck();
		if (fcpCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
			$('#fcPasswordRepeat').attr("disabled", true)
		} else {
			// $(this).removeClass('is-invalid');
			// $(this).addClass('is-valid');
			$('#fcPasswordRepeat').attr("disabled", false)
		}
		$('#fcPasswordRepeat').focus();
	});// password_focusout

	// 비밀번호확인
	$('#fcPasswordRepeat').focusout(function() {
		fcprCheck = fcpwrpCheck();
		if (fcprCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
			$('#fcPassword').removeClass('is-valid');
			$('#fcPassword').addClass('is-invalid');
		} else {
			$('#fcPassword').removeClass('is-invalid');
			$('#fcPassword').addClass('is-valid');
			$(this).removeClass('is-invalid');
			$(this).addClass('is-valid');
		}
	})

	// 가맹점ID 중복체크
	$('#fcidDupcheck').click(function() {
		fcidCheck = fcIdCheck();
		if (fcidCheck == true) {
			$.ajax({
				type : "Get",
				url : "fcdetail?fcId=" + $('#fcId').val(),
				success : function(resultData) {
					if (resultData.message != null) {
						console.log(resultData.message)
						$('#fcId').removeClass('is-invalid');
						$('#fcId').addClass('is-valid');
						$('#fcidsuccessMessage').html('사용가능한 코드입니다.');
						fcdubCheck = true;
					} else {
						$('#fcId').removeClass('is-valid');
						$('#fcId').addClass('is-invalid');
						$('#fcidMessage').html('이미 등록된 가맹점ID입니다.');
						fcdubCheck = false;
					}
				},
				error : function() {
					alert("Ajax 오류");
					fcdubCheck = false;
				}
			});// ajax
		}// if
	})
	
	// ** 계정 생성 확인버튼 클릭시
	$('#fcSubmitBtn').click(function() {
		if (fcincheck() == true) {
			$.ajax({
				type : "post",
				url : "fcinsert",
				data : {
					fcId : $('#fcId').val(),
					fcPassword : $('#fcPassword').val(),
					fcName : $('#fcName').val(),
					fcAddress : $('#address').val()+" "+$('#addressDetail').val(),
					fcArea : $('#fcArea').val(),
					fcPhone : $('#fcPhone').val(),
					hoId : $('#hoId').val(),
					fcClose : "N"
				},
				success : function(data) {
					if (data.success == 'success') {
						alert('계정생성에 성공했습니다.');
						fcInputClear();
						location.reload();
					}
					if (data.success == 'fail') {
						alert('계정생성에 실패했습니다.');
						fcInputClear();
					}
				},
				error : function() {
					alert("서버와 접속에 실패했습니다.");
					fcInputClear();
				}
			})// ajax
		}
	})
})//ready
// ** ID 중복 확인하기

// ** input창 클리어
function fcInputClear() {

	$('#fcId').removeClass('is-valid');
	$('#fcId').removeClass('is-invalid');
	$('#fcPassword').removeClass('is-valid');
	$('#fcPassword').removeClass('is-invalid');
	$('#fcPasswordRepeat').removeClass('is-valid');
	$('#fcPasswordRepeat').removeClass('is-invalid');
	$('#fcPasswordRepeat').attr("disabled", true);
}

function fcincheck() {
	if (fcidCheck == false || fcdubCheck == false) {
		$('#fcId').addClass('is-invalid');
		$('#fcidMessage').html('가맹점ID를 확인하세요');
	}
	if (fcpCheck == false) {
		$('#fcPassword').addClass('is-invalid');
		$('#fcpMessage').html('password를 확인하세요');
	}
	if (fcprCheck == false) {
		$('#fcPasswordRepeat').addClass('is-invalid');
		$('#fcprMessage').html('password를 확인하세요');
	}

	if (fcidCheck == true && fcpCheck == true && fcprCheck == true) {
		if (confirm('계정을 생성하시겠습니까?')==true) {
			return true;
		} else {
			return false;
		}
	} else
		return false;
}// inCheck
// ====================================================================

// ===============< 사원계정생성 스크립트(광훈) >============================
$(function() {
	// ** 계정생성 클릭시 모달창
	$('#joinBtn').click(function() {
		$('#joinfmodal').modal('show');
	});
	// ** 비밀번호수정 클릭시 모달창
	$('#staffPwChange').click(function() {
		$('#staffPwChangeModal').modal('show');
	});
	// ** 비밀번호수정 모달 닫힐시
	$('#staffPwChangeModal').on('hidden.bs.modal', function() {
		$('#loginPassword').val('');
		$('#hoPassword').val('');
		$('#passwordRepeat').val('');
		inputClear();
		$('#hoPassword').attr("disabled", true)
		$('#passwordRepeat').attr("disabled", true)
	});
	// ** 계정생성 리셋버튼 클릭시 모달창
	$('#staffInputresetBtn').click(function() {
		inputClear();
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

	
	
	var click_check = 0;
	// ** 모달 닫는버튼 새로고침 기능 추가
	$('.infoClose').click(function() {
		if (click_check == 1) {
			click_check = 0;
		} else
			location.reload();
	})
	
	
	// ** 계정디테일, 나의정보에서 정보수정 클릭시
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

// ========================< 페이징, 서치 도구 >===============================

function changeSearchStaffOption() {

	$input = $('#changeSearchFinder').children('input');
	$select = $('#changeSearchFinder').children('select');
	if ($('#searchType').val() == 'position') {
		$input.css('display', 'none').attr('id', 'keywordHide');
		$select.css('display', 'block').attr('id', 'keyword');
	} else {
		$select.css('display', 'none').attr('id', 'keywordHide');
		$input.css('display', 'block').attr('id', 'keyword');
	}

}

function changeSearchFranchiseOption() {

	$input = $('#changeSearchFinder').children('input');
	$select = $('#changeSearchFinder').children('select');
	if ($('#searchType').val() == 'area') {
		$input.css('display', 'none').attr('id', 'keywordHide');
		$select.css('display', 'block').attr('id', 'keyword');
	} else {
		$select.css('display', 'none').attr('id', 'keywordHide');
		$input.css('display', 'block').attr('id', 'keyword');
	}

}

// ==========================================================================

// ===============< 가입시 입력제한조건 (광훈) >============================
// 1) 개별적 오류 확인을 위한 switch 변수(전역)
var cCheck = false; // => 사원번호
var lpCheck = false; // =>로그인비번
var pCheck = false; // ->비번
var prCheck = false; // ->비번확인
var dubCheck = false; // ->사원번호중복

// 2) 개별적 오류점검 위한 focusout 이벤트 핸들러 : JQuery
$(function() {
	// 사원번호
	$('#code').focusout(function() {
		cCheck = codeCheck();
		if (cCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
		}
	});// id_focusout

	// 비밀번호
	$('#hoPassword').focusout(function() {
		pCheck = pwCheck();
		if (pCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
			$('#passwordRepeat').attr("disabled", true)
		} else {
			// $(this).removeClass('is-invalid');
			// $(this).addClass('is-valid');
			$('#passwordRepeat').attr("disabled", false)
		}
		$('#passwordRepeat').focus();
	});// password_focusout

	// 비밀번호확인
	$('#passwordRepeat').focusout(function() {
		prCheck = pwrpCheck();
		if (prCheck == false) {
			$(this).removeClass('is-valid');
			$(this).addClass('is-invalid');
			$('#hoPassword').removeClass('is-valid');
			$('#hoPassword').addClass('is-invalid');
		} else {
			$('#hoPassword').removeClass('is-invalid');
			$('#hoPassword').addClass('is-valid');
			$(this).removeClass('is-invalid');
			$(this).addClass('is-valid');
		}
	})

	// 사원번호 중복체크
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
		}// if
	})

	// =======================< 비번 변경 >===============================

	// 비밀번호 변경시 현재 비밀번호 확인
	$('#staffPwUpBtn').click(function() {
		if (confirm('비밀번호를 변경하시겠습니까?')) {
			$.ajax({
				type : "post",
				url : "headOfficePwUpdate",
				data : {
					hoPassword : $('#hoPassword').val(),
				},
				success : function(data) {
					if (data.success == 'success') {
						alert('비밀번호가 변경되었습니다.')
						$('#staffPwChangeModal').modal('hide');
					}
					if (data.success == 'fail') {
						alert('비밀번호 변경에 실패했습니다.')
					}
				},
				error : function() {
					alert("서버와 접속에 실패했습니다.");
				}
			});// ajax
		}
	});// loginPassword_click

	// 비밀번호 변경시 현재 비밀번호 확인
	$('#pwCheck').click(function() {
		var inputPW = $('#loginPassword').val();
		$.ajax({
			type : "post",
			url : "staffloginPwCheck",
			data : {
				hoPassword : inputPW,
			},
			success : function(data) {
				if (data.success == 'success') {
					$('#loginPassword').removeClass('is-invalid');
					$('#loginPassword').addClass('is-valid');
					$('#hoPassword').attr("disabled", false);
					$('#hoPassword').focus();
				}
				if (data.success == 'fail') {
					$('#loginPassword').removeClass('is-valid');
					$('#loginPassword').addClass('is-invalid');
					$('#passwordRepeat').attr("disabled", true)
					$('#lpMessage').html('비밀번호가 틀립니다.');
				}
			},
			error : function() {
				alert("서버와 접속에 실패했습니다.");
			}
		});// ajax

	});// loginPassword_click

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
		$('#pMessage').html('password를 확인하세요');
	}
	if (prCheck == false) {
		$('#passwordRepeat').addClass('is-invalid');
		$('#prMessage').html('password를 확인하세요');
	}

	if (cCheck == true && pCheck == true && prCheck == true) {
		if (confirm('계정을 생성하시겠습니까?')==true) {
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
	$('#loginPassword').removeClass('is-invalid');
	$('#loginPassword').removeClass('is-valid');
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



});// ready

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
function changeSearchItemOption() {

	$input = $('#changeSearchFinder').children('input');
	$select = $('#changeSearchFinder').children('select');
	if ($('#searchType').val() == 'flag') {
		$input.css('display', 'none').attr('id', 'keywordHide');
		$select.css('display', 'block').attr('id', 'keyword');
	} else {
		$select.css('display', 'none').attr('id', 'keywordHide');
		$input.css('display', 'block').attr('id', 'keyword');
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

// ===============< 자재등록(현구) >============================

// ===============< 가맹점발주관련(현구) >============================

$(function() {

	// 자재상세조회 modal 닫힐 시 내용 clear
	$('#fcOrderDetailModal').on('hidden.bs.modal', function() {
		$('#fcOrderDeatilTableBody').html('');
	})

})// ready

// 자재 상세조회 modal 열기
function fcOrderDetailForm(fcOrderSeq) {
	console.log("세션 => " + window.sessionStorage);
	console.log("세션 => " + window.sessionStorage.getItem('loginID'));

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
			$('#fcOrderDetailModal').modal('show');
		},
		error : function() {
		}
	})
}// fcOrderDetailForm

// 가맹점 발주 완료처리

function fcOrderFlagUpdate(flag) {
	var fcOrderSeq = $('#fcOrderNumber').attr('ordernumber');
	$.ajax({
		type : 'get',
		url : 'fcordersequpdate?flag=' + flag,
		data : {
			fcOrderSeq : fcOrderSeq
		},
		success : function(data) {
			if (data.success == 'success') {
				location.reload();
			} else {
				alert("시스템 오류입니다.<br>다시 시도해주세요.")
			}
		},
		error : function() {
			alert("시스템 오류입니다.<br>다시 시도해주세요.")
		}

	})//ajax
}//fcOrderComplete



// ===============< 가맹점발주관련등록(현구) >============================




//===< 메뉴관련(민석) >========!!시작!!====================================




	// menuUpdateFrom()
	
	function menuUpdateForm(menuIndex){
		
		$.ajax({
			type:'get',
			url:'menuDetail?menuIndex='+menuIndex,
			data:{
				menuIndex : menuIndex,
			},
			success:function(data) {
				
				$('#upmenuIndex').val(data.menuvo.menuIndex);
				$('#upmenuName').val(data.menuvo.menuName);				
				$('#upmenuIntro').val(data.menuvo.menuIntro);
				$('#upmenuPrice').val(data.menuvo.menuPrice);
				$('#upbeforemenuImage').attr("src",data.menuvo.menuImage);
				$('#menuImage').val(data.menuvo.menuImage);
				console.log("data throw test");
				console.log("menuIndex =>"+data.menuvo.menuIndex);
				console.log("menuName =>"+data.menuvo.menuName);
				console.log("menuIntro =>"+data.menuvo.menuIntro);
				console.log("menuFlag =>"+data.menuvo.menuFlag);
				console.log("menuImg =>"+data.menuvo.menuImage);			
			
				// when 절로 update 할 것 
				if(data.menuvo.menuFlag == 'pizza'){
					$('#upmenuFlag option:eq(0)').prop('selected',true);
				}if (data.menuvo.menuFlag == 'sets'){
					$('#upmenuFlag option:eq(1)').prop('selected',true);
				}else {
					$('#upmenuFlag option:eq(2)').prop('selected',true);
				}
						
				//$('#menuUpdatef1').load('menuUpdatef.jsp #menuUpdatef');				
				$('#menuUpdatef').modal('show');
				console.log("전송 성공");				
			},error:function(){
				console.log("전송 실패");
				alert("전송에 실패하였습니다.");
			}
			
		})//ajax
	
	}//menuUpdateForm

	
	function menuDie(vsindex,menuIndex) {
		console.log($('#menulife'+vsindex).text());
		console.log($('#menulife'+vsindex).html());
		console.log($('#menulife'+vsindex).val());
		
		console.log(vsindex);
		console.log(menuIndex);
		console.log($('#menulife'+vsindex).text()=='비활성화'); // true false
		console.log($('#menulife'+vsindex).text()=='활성화'); // true false		
		// 반복문 안에 있는 건 어떻게 처리하지? 
		// varstatus => 가 index 값을 가진다.
		// 그 index 로 반복문 내에 있는 것을 수정할 수 있다.
		
		$.ajax({
			url:'menuDie',
			type:'get',
			data:{
				menuIndex: menuIndex,
				menuLive : $('#menulife'+vsindex).text()=='비활성화'? 'die' : 'live'						
			},
			
			success:function(data){ // 성공하면 아래 작업을 실행한다.
				console.log('비활성화 받아오기 성공1');	
				$('.a'+vsindex).val(data.success);
				
				
				if(data.success == 'success'){
					console.log('비활성화 받아오기 성공2');					
					if($('#menulife'+vsindex).text()=='비활성화'){
						
						$('#menulife'+vsindex).text('활성화');
						$('.a'+vsindex).css('text-decoration','line-through');
						//$('#menulife'+vsindex).removeAttr('onclick');
						//$('#menulife'+vsindex).attr('onclick','menuLive(${vs.index},${vo.menuIndex})');
				   }else{
						
						$('#menulife'+vsindex).text('비활성화');
						$('.a'+vsindex).css('text-decoration','none');
					
						 }
				}
			},error:function(){
				
				console.log("비활성화 받아오기 실패");
				alert("비활성화 전송에 실패하였습니다.");
			}
		
		})//ajax
		
	}//.click		
	
	
	
			
	
	
	
	
	