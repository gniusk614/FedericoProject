<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Test page</title>
<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function(){
		
	$.ajax({
	
		type:'get',
		url:'datatest',
		success: function(data){
			console.log("!");
			$('#test').html(data);
		},
		error:function(){
			
			
		}
	})//ajax
	
	
	
})//ready
</script>


</head>
<body>
	123123123
	
<div id="test"></div>
	
	
	
	
	
	
</body>
</html>