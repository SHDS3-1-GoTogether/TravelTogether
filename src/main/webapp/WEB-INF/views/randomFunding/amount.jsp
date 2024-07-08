<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/fundingBase.css">
<link rel="stylesheet" href="${path}/resources/css/randomFunding.css" />
<title>choice price</title>
<style>
.button-group {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	grid-template-rows: repeat(2, 1fr);
	gap: 40px;
	width: 100%;
	max-width: 950px;
	margin: 0 auto;
}

.price-button {
	width: 100%;
	height: 100%;
	padding: 10px 40px;
	border: 2px solid #ccc;
	background-color: #fff;
	border-radius: 8px;
	font-size: 20px;
	cursor: pointer;
	transition: all 0.3s ease; 
	box-sizing: border-box; 
}

.price-button.active, .price-button:hover {
	background-color: #007bff;
	color: #fff;
	border-color: #0056b3;
	transform: scale(1.1);
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
}
</style>
<script>
		var selectedPrice;

		function selectPrice(price) {
			let index = 0;
	        const slides = document.querySelector('.slides');
	        const images = document.querySelectorAll('.slides img');
	        const totalSlides = images.length;
	        const indicators = document.querySelectorAll('.indicator');

	        function updateIndicators() {
	            indicators.forEach((indicator, i) => {
	                indicator.classList.toggle('active', i === index);
	            });
	        }

	        function updateImages() {
	            images.forEach((img, i) => {
	                img.classList.toggle('center', i === index);
	            });
	        }

	        function showSlides() {
	            index = (index + 1) % totalSlides;
	            slides.style.transform = `translateX(-${index * (100 / totalSlides)}%)`;
	            updateImages();
	            updateIndicators();
	        }

	        indicators.forEach(indicator => {
	            indicator.addEventListener('click', function () {
	                index = parseInt(this.getAttribute('data-slide'));
	                slides.style.transform = `translateX(-${index * (100 / totalSlides)}%)`;
	                updateImages();
	                updateIndicators();
	            });
	        });

	        setInterval(showSlides, 3000);
			
			selectedPrice = price;  // 사용자가 선택한 가격 저장
	        // 모든 버튼의 active 클래스를 제거하고, 선택된 버튼만 active 클래스 추가
	        document.querySelectorAll('.price-button').forEach(button => {
	            button.classList.remove('active');
	        });
	        event.currentTarget.classList.add('active');
	    }

	    function submitPrice() {
	        if (selectedPrice) {
	            window.location.href = '${path}/randomFunding/themes.do?amount=' + encodeURIComponent(selectedPrice);
	        } else {
	            alert('가격을 선택해주세요.');
	        }
	    }
	</script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="content_wrapper_fix">
		<h1>랜덤 펀딩</h1>
		<div class="progress progress-container">
			<div class="progress-step">일정 선택</div>
			<div class="arrow">→</div>
			<div class="progress-step active">금액 선택</div>
			<div class="arrow">→</div>
			<div class="progress-step">테마 선택</div>
		</div>

		<hr class="top_hr">

		<div class="container_date">
			<h3>원하시는 금액대를 선택해주세요.</h3>
			<!-- 동적으로 선택가능한 태그 만들어 놓기 -->
			<form action="${path}/randomFunding/amount.do" method="get">
				<div class="button-group">
					<c:forEach var="priceRange" items="${amount}">
						<button type="button" class="price-button" id="${priceRange}"
							onclick="selectPrice('${priceRange}')" name="priceRange"
							value="${priceRange}">${priceRange}</button>
					</c:forEach>
				</div>
			</form>
			<div class="button-group-send">
				<button type="button" class="button prev-button"
					onclick="history.back()">이전으로</button>
				<button type="submit" class="button next-button"
					onclick="submitPrice()">다음으로</button>
			</div>
		</div>

		<div>
			<h6>PLAN YOUR TRIP</h6>
			<h2>Where to next?</h2>

			<div class="slider-container">
				<div class="slides">
					<img src="${path}/resources/images/randomfunding-1.JPG"
						alt="Image 1" class="center"> <img
						src="${path}/resources/images/randomfunding-4.JPG" alt="Image 2">
					<img src="${path}/resources/images/randomfunding-3.JPG"
						alt="Image 3">
				</div>
				<div class="slider-indicators">
					<div class="indicator active" data-slide="0"></div>
					<div class="indicator" data-slide="1"></div>
					<div class="indicator" data-slide="2"></div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>