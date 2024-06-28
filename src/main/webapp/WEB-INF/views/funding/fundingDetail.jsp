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
	<div>${fund.title}</div>
	<div>${fund.funding_content}</div>
	<div>${fund.start_date}</div>
	<div>${fund.end_date}</div>
	<div>${fund.price}</div>
	<c:forEach var="pic" items="${pic}">
		<img alt="${pic}" 
		src="${pic}"
		width="200" height="200">

	</c:forEach>	
	<button id="doPay" onclick="location.href=${path}/payment/pay.do?funding_id=${fund.funding_id}" >신청하기</button>	
</body>
</html>