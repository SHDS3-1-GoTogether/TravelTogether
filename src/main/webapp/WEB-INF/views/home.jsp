<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">
<html>
<head>
<%@ include file="common/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/home.css">
<title>트래블 투게더</title>
</head>

<body>
	<div class="container2">
		<img src="${path}/resources/images/main.jpg" alt="메인이미지"
			class="main_img">
		<div class="my_div">&nbsp;&nbsp;여행가고 싶은데 혼자 가기는 싫을 때.. 같이
			갈래?&nbsp;&nbsp;</div>
		<a href="#">
			<div class="my_div2">
				<p>Click!</p>
			</div>
		</a>
	</div>


	<img src="${path}/resources/images/fire.png" alt="불">
	<h1>마감 임박! 인기있는 여행 펀딩</h1>
	<img src="${path}/resources/images/random.png" alt="랜덤">
	<h1>랜덤펀딩</h1>
	<img src="${path}/resources/images/star.png" alt="별">
	<h1>이번달 Best 후기</h1>

	<%@ include file="common/footer.jsp"%>
</body>
</html>
