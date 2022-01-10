<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>
<c:if test="${not empty message}">
	<br>=> ${message}<br><br>
</c:if>
<P>  The time on the server is ${serverTime}. </P>

<a href="test/tindexf">testindex</a>
<a href="headoffice/loginf">login</a>


</body>
</html>
