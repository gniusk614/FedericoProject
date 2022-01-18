/**
 * member input Data 무결성 확인 function
** member 무결성 확인사항
// ID : 길이(4이상), 영문자,숫자 로만 구성
// password : 길이(4이상), 영문,숫자,특수문자로 구성, 특수문자는 반드시 1개 이상 포함할것
// Name : 길이(2이상), 영문 또는 한글로 만 입력
// Level : select 를 이용 (X)
// BirthDay : 입력 여부 확인  ( length == 10 )
// Point : 정수의 범위  ( 숫자이면서, '.'이 없어야함 )
// Weight: 구간 (20 ~ 200)
 
 ** 작성 규칙
   => JavaScript function 으로 정의 하고 
      결과를 true or false 로 return
 */

//==============================< 본사직원계정 인체크(광훈) >=============================
function codeCheck(){
	var code=$('#code').val(); 
	if (code.length<1) {
		$('#codeMessage').html('사원번호를 입력하세요');
		return false;
	}else {
		$('#codeMessage').html('');
		return true;
	}
	
	
}//idCheck


function pwCheck(){
	var password=$('#hoPassword').val()
	//** Password : 길이4이상, 영문자, 숫자와 특수문자는 1개 이상 포함
	if (password.length<4) {
		$('#pMessage').html('password는 4글자 이상 입니다.');
		return false;
	}else if ( password.replace(/[!-*.@]/gi,'').length >= password.length ) {
		$('#pMessage').html('password는 특수문자가 반드시 1개 이상 포함되어야 합니다.');
		return false;
	}else if ( password.replace(/[a-z.0-9.!-*.@]/gi ,'').length > 0 ) {
		$('#pMessage').html('password는 영문자, 숫자, 특수문자로만 입력하세요');
		return false;
	}else {
		$('#pMessage').html('');
		return true;
	}
}//pwCheck


function pwrpCheck(){
	var passwordRepeat=$('#passwordRepeat').val()
	//** Password : 길이4이상, 영문자, 숫자와 특수문자는 반드시 1개 이상 포함할것
	if (passwordRepeat != $('#hoPassword').val()) {
		$('#prMessage').html('비밀번호가 일치하지 않습니다.');
		return false;
	}else {
		$('#prMessage').html('');
		return true;
	}
}//pwCheck

//==============================< 가맹점계정 인체크(광훈) >=============================
function fcIdCheck(){
	var fcid=$('#fcId').val(); 
	if (fcid.length<1) {
		$('#fcidMessage').html('가맹점ID를 입력하세요');
		return false;
	}else {
		$('#fcidMessage').html('');
		return true;
	}
	
	
}//idCheck

function fcpwCheck(){
	var password=$('#fcPassword').val()
	//** Password : 길이4이상, 영문자, 숫자와 특수문자는 1개 이상 포함
	if (password.length<4) {
		$('#fcpMessage').html('password는 4글자 이상 입니다.');
		return false;
	}else if ( password.replace(/[!-*.@]/gi,'').length >= password.length ) {
		$('#fcpMessage').html('password는 특수문자가 반드시 1개 이상 포함되어야 합니다.');
		return false;
	}else if ( password.replace(/[a-z.0-9.!-*.@]/gi ,'').length > 0 ) {
		$('#fcpMessage').html('password는 영문자, 숫자, 특수문자로만 입력하세요');
		return false;
	}else {
		$('#fcpMessage').html('');
		return true;
	}
}//pwCheck


function fcpwrpCheck(){
	var passwordRepeat=$('#fcPasswordRepeat').val()
	//** Password : 길이4이상, 영문자, 숫자와 특수문자는 반드시 1개 이상 포함할것
	if (passwordRepeat != $('#fcPassword').val()) {
		console.log(passwordRepeat)
		console.log($('#fcPassword').val())
		
		$('#fcprMessage').html('비밀번호가 일치하지 않습니다.');
		return false;
	}else {
		$('#fcprMessage').html('');
		return true;
	}
}//pwCheck





		



