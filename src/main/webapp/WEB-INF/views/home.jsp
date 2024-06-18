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

<title>트래블 투게더</title>
<style>
.container2 {
	height: 100vh;
	width: 75vw;
	font-family: "Do Hyeon", sans-serif;
	font-weight: 400;
	font-style: normal;
	font-size: 40px;
	display: flex;
	justify-content: center;
	position: relative;
	text-align: center;
	margin: 0 auto;
	margin-top: 5px;
}

.main_img {
	opacity: 0.5;
	width: 93%;
	height: 57%;
}

.my_div {
	width: 50%;
	height: auto;
	padding: 20px;
	border: 3px solid #5242F2;
	border-radius: 100px;
	color: #5242F2;
	background-color: rgba(255, 255, 255, 0.8);
	/* optional: to make text more readable */
	text-align: center;
	display: flex;
	align-items: center;
	justify-content: center;
	font-family: "Do Hyeon", sans-serif;
	font-weight: 400;
	font-style: normal;
	font-size: 40px;
	position: absolute;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -200%);
}
</style>

</head>

<body>
	<div class="container2">
		<img src="${path}/resources/images/main.jpg" alt="메인이미지"
			class="main_img">
		<div class="my_div">여행가고 싶은데 혼자 가기는 싫을 때.. 같이 갈래?</div>
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
