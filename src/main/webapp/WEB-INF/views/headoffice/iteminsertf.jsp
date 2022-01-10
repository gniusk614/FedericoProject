<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/federico/resources/css/styles.css" rel="stylesheet" />
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- 임시사용, 추후 js파일로 -->
<script>

$(function(){
    // 숫자입력시 콤마찍기
    $("#itemprice").bind('keyup keydown',function(){
        inputNumberFormat(this);
    });
    //입력한 문자열 전달
    function inputNumberFormat(obj) {
        obj.value = comma(uncomma(obj.value));
    }
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
	
	
	
/* 서브밋 조건 추가해야할듯, name,pirce 빈칸 ㄴㄴ, price 숫자만. */
function iteminsert() {
	
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
			if(data.success=='success'){
			alert(data.message);
			$('.iteminput').val('');
			$(".itemselect").val("식자재").prop("selected",true);
			}
		},
		error:function(){
			alert("메뉴이름은 중복될 수 없습니다.")
		}
	})//ajax 
}//iteminsert


	
	
</script>
</head>
<body>

	<div class="container col-lg-6">
		<span class="h1">자재 등록</span>
		<!-- 입력, inputform -->
		<div><c:if test="${! empty message }">
		${message }
		</c:if></div>
		
			<div>
				<!-- 분류 -->	
				<div class="input-group mb-3">
				  <label class="input-group-text" for="inputGroupSelect01">분류</label>
				  <select class="form-select itemselect" id="itemflag">
				    <option selected value="식자재">식자재</option>
				    <option value="부자재">부자재</option>
				  </select>
				</div>			
				<!-- 품명 -->		
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">품명</span>
				  <input type="text" class="form-control w-50 iteminput" aria-describedby="basic-addon1" id="itemname">
				</div>
				<!-- 단위 -->		
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">단위</span>
				  <input type="text" class="form-control iteminput" aria-describedby="basic-addon1" id="itemunit">
				</div>
				<!-- 단가 -->
				<div class="input-group mb-3">
				  <span class="input-group-text" id="basic-addon1">가격</span>
				  <input type="text" class="form-control iteminput" aria-describedby="basic-addon1" id="itemprice" onchange="addComma(this.value)">
				</div>		
			</div>	
			<div align="right"><button class="btn btn-primary" onclick="iteminsert()">등록</button></div>
		<!-- 입력, inputform -->
	</div>





<script src="/federico/resources/js/scripts.js"></script>
</body>
</html>