<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<div>fund.title</div>
	<c:forEach var="pic" items="${pic}">
		<img alt="${pic}" 
		src="${pic}"
		width="200" height="200">

	</c:forEach>		
</body>
</html>