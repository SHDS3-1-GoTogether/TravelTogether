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
<title>Insert title here</title>
<style>
.button-group {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 30px;
	width: 100%;
}

.input-group {
	flex: 1;
	display: flex;
	justify-content: center;
	align-items: center;
	margin-bottom: 20px;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="content_wrapper_fix">
		<h1>랜덤 펀딩</h1>
		<div class="progress progress-container">
			<div class="progress-step active">일정 선택</div>
			<div class="arrow">→</div>
			<div class="progress-step">금액 선택</div>
			<div class="arrow">→</div>
			<div class="progress-step">테마 선택</div>
		</div>

		<hr class="top_hr">

		<form action="${path}/randomFunding/amount.do" method="get">
			<div class="container_date">
				<h3>여행 가능한 기간을 선택해주세요 (시작일, 마감일)</h3>
				<div class="input-group">
					<div class="input-group-inner">
						<label for="departure">출발일</label> <input type="date"
							id="departure" name="departure">
					</div>
				</div>
				<div class="input-group">
					<div class="input-group-inner">
						<label for="arrival">도착일</label> <input type="date" id="arrival"
							name="arrival">
					</div>
				</div>
				<div class="button-group">
					<button type="button" class="button prev-button"
						onclick="history.back()">이전으로</button>
					<button type="submit" class="button next-button">다음으로</button>
				</div>
			</div>
		</form>

		<div>
			<h6>PLAN YOUR TRIP</h6>
			<h2>Where to next?</h2>

			<div class="slider-container">
				<div class="slides">
					<img src="${path}/resources/images/randomfunding-1.JPG"
						alt="Image 1" class="center"> <img
						src="${path}/resources/images/randomfunding-2.jpg" alt="Image 2">
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
	<script>
		document.addEventListener('DOMContentLoaded', function() {
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
			
			const form = document.querySelector('form');
			form.addEventListener('submit', function(event) {
				
				event.preventDefault(); // 폼 제출 막기@@@@@@
				
				const departure = document.getElementById('departure').value;
				const arrival = document.getElementById('arrival').value;
				
				if (!departure || !arrival) {
					event.preventDefault(); // 폼 제출 막기
					alert('출발일과 도착일을 모두 선택해주세요.');
					return;
				}
				
				$.ajax({
					url:`${path}/randomFunding/amount.do`,
					type:'POST',
					contentType:'application/json',
					data: JSON.stringify({ departure: departure, arrival:arrival}),
					success: function(response){
						if(response.status == 'fail'){
							alert(response.data);
						}else{
							window.location.href=`${path}/randomFunding/` + response.data +
												`?departure=` + departure + `&arrival=` + arrival;
						}
					},
					error: function(xhr, status, error){
						console.error('Error:', error);
		                console.log('서버 오류가 발생하였습니다.')
					}
				});
			});
		});
	</script>
</body>
</html>