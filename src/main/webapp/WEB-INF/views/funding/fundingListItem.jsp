<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/css/fundingList.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
		<c:forEach var="fund" items="${fundlist}">
			<div class="item">
				<div class="item_img_div">
					<img class="item_img" alt="잘못된 경로" src="${path}/resources/images/exImg.png"></>
				</div>
				<div class="item_content">
					<span>${fund.title}</span>
					<span>${fund.area}</span>
					<span>${fund.price}원</span>
					<span>${fund.people_num}</span>
					<span>${fund.start_date}- ${fund.end_date}</span>
				</div>
			</div>
		</c:forEach>
</body>
</html>