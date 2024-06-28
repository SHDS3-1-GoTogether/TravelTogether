<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="${path}/resources/css/home.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<title>트래블 투게더</title>
</head>

<body>
	<%@ include file="common/header.jsp"%>
	<div class="tt-container">
		<!-- Carousel -->
		<div id="demo" class="carousel slide home-banner" data-bs-ride="carousel">

			<!-- Indicators/dots -->
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#demo" data-bs-slide-to="0"
					class="active"></button>
				<button type="button" data-bs-target="#demo" data-bs-slide-to="1"></button>
				<button type="button" data-bs-target="#demo" data-bs-slide-to="2"></button>
			</div>

			<!-- The slideshow/carousel -->
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="${path}/resources/images/main.jpg" alt="메인이미지" class="d-block main_img">
					<div class="carousel-caption">
						<h3>&nbsp;&nbsp;여행가고 싶은데 혼자 가기는 싫을 때.. 같이 갈래?&nbsp;&nbsp;</h3>
						<p>Click!</p>
					</div>
				</div>
				<div class="carousel-item">
					<img src="${path}/resources/images/jeju.jpg" alt="메인이미지" class="d-block main_img">
					<div class="carousel-caption">
						<h3>&nbsp;&nbsp;혼자옵서예&nbsp;&nbsp;</h3>
						<p>Click!</p>
					</div>
				</div>
			</div>

			<!-- Left and right controls/icons -->
			<button class="carousel-control-prev " type="button"
				data-bs-target="#demo" data-bs-slide="prev">
				<span class="carousel-control-prev-icon"></span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#demo" data-bs-slide="next">
				<span class="carousel-control-next-icon"></span>
			</button>
		</div>


		<img src="${path}/resources/images/fire.png" alt="불">
		<h1>마감 임박! 인기있는 여행 펀딩</h1>
		<img src="${path}/resources/images/random.png" alt="랜덤">
		<h1>랜덤펀딩</h1>
		<img src="${path}/resources/images/star.png" alt="별">
		<h1>이번달 Best 후기</h1>
	</div>
	<%@ include file="common/footer.jsp"%>
</body>
</html>
