<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${! empty message }">
<h1>${message }</h1>
</c:if>
	
<c:forEach var="vo" items="${list}">
	<pre>
		staffcode : ${vo.staffCode }
		staffposition : ${vo.staffPosition }
		staffphone: ${vo.staffPhone }
		staffname: ${vo.staffName }	
	</pre>

</c:forEach>
	




</body>
</html>