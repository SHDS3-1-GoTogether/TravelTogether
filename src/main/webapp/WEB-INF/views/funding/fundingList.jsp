<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>funding List Page</h1>
	<c:forEach var="fund" items="${fundlist}">
		<ul>
			<li>${fund.title}</li>
			<li>${fund.area}</li>
			<li>${fund.price}</li>
			<li>${fund.people_num}</li>
			<li>${fund.start_date} - ${fund.end_date}</li>			
		</ul>
	</c:forEach>
	
</body>
</html>