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
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/myLib/jquery-3.2.1.min.js"></script>
<script src="/federico/resources/myLib/headOffice_Script.js"></script>
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
<!-- nav inlcud -->
<%@ include file="nav.jsp" %>

<div id="layoutSidenav_content">
	<div class="container px-4" style="margin-top: 20px;">
		<div class="card col-5">
			<div class="card-header">
				<!-- 아이콘 --><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-minecart-loaded" viewBox="0 0 16 16">
				  <path d="M4 15a1 1 0 1 1 0-2 1 1 0 0 1 0 2zm0 1a2 2 0 1 0 0-4 2 2 0 0 0 0 4zm8-1a1 1 0 1 1 0-2 1 1 0 0 1 0 2zm0 1a2 2 0 1 0 0-4 2 2 0 0 0 0 4zM.115 3.18A.5.5 0 0 1 .5 3h15a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 14 12H2a.5.5 0 0 1-.491-.408l-1.5-8a.5.5 0 0 1 .106-.411zm.987.82 1.313 7h11.17l1.313-7H1.102z"/>
				  <path fill-rule="evenodd" d="M6 1a2.498 2.498 0 0 1 4 0c.818 0 1.545.394 2 1 .67 0 1.552.57 2 1h-2c-.314 0-.611-.15-.8-.4-.274-.365-.71-.6-1.2-.6-.314 0-.611-.15-.8-.4a1.497 1.497 0 0 0-2.4 0c-.189.25-.486.4-.8.4-.507 0-.955.251-1.228.638-.09.13-.194.25-.308.362H3c.13-.147.401-.432.562-.545a1.63 1.63 0 0 0 .393-.393A2.498 2.498 0 0 1 6 1z"/>
				</svg>	<!-- 아이콘 -->	
				&nbsp;자재 등록
			</div>
			<div class="card-body">
				<!-- 입력, inputform -->
				<div class="container">
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
						<div align="right"><button class="btn btn-primary" onclick="iteminsert()">등록</button></div>
				</div>	
			<!-- 입력, inputform -->
			</div>
		</div>
	</div>
</div>





<!-- footer inlcud -->
<div><%@ include file="footer.jsp" %></div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/federico/resources/js/scripts.js"></script>


</body>
</html>