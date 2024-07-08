<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Internal Server Error</title>
<style>
body {
	font-family: Arial, sans-serif;
	text-align: center;
	background-color: #ffffff;
	margin: 0;
	padding: 0;
}

.container {
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	text-align: center;
}

.image-container {
	margin-bottom: 20px;
}

.image-container img {
	max-width: 100%;
	height: auto;
}

h1 {
	font-size: 24px;
	color: #000000;
	margin: 10px 0;
}

p {
	color: #000000;
	margin: 10px 0;
}

.button {
	display: inline-block;
	margin-top: 20px;
	padding: 10px 20px;
	color: white;
	background-color: #007bff;
	text-decoration: none;
	border-radius: 5px;
	font-size: 14px;
}
</style>
</head>
<body>
	<div class="container">
		<div class="image-container">
			<img src="${path}/resources/images/sh_character_05.png"
				alt="Error Image">
		</div>
		<h1>서버 오류가 발생했습니다</h1>
		<p>Internal Server Error</p>
		<p>
			죄송합니다. 현재 서버에서 문제가 발생하여 요청하신 페이지를 표시할 수 없습니다.<br> 문제가 지속될 경우, 고객
			지원팀에 문의해주시기 바랍니다.
		</p>
		<p>Status Code: ${statusCode}</p>
		<p>Message: ${message}</p>

		<a href="${path}/" class="button">홈으로 이동</a>
	</div>
</body>
</html>