<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/fundingBase.css"/>
<link rel="stylesheet" href="${path}/resources/css/randomFunding.css"/>
<title>choice theme</title>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="content_wrapper_fix">
		<h1>랜덤 펀딩</h1>
		<div class="progress progress-container">
			<div class="progress-step">일정 선택</div>
			<div class="arrow">→</div>
			<div class="progress-step">금액 선택</div>
			<div class="arrow">→</div>
			<div class="progress-step active">테마 선택</div>
		</div>

		<hr class="top_hr">

		<div class="container_date">
			<h3>원하시는 여행테마를 선택해주세요.</h3>
			<div class="button-group">
				<c:forEach var="themeRange" items="${theme}">
					<button type="button" class="theme-button" id="${themeRange}"
						onclick="toggleTheme(this, '${themeRange}')" name="${themeRange}"
						value="${themeRange}">${themeRange}</button>
				</c:forEach>
			</div>
			<div class="button-group-send">
				<button type="button" class="button prev-button"
					onclick="history.back()">이전으로</button>
				<button type="submit" class="button next-button"
					onclick="submitTheme()">다음으로</button>
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

	<script>
    document.addEventListener('DOMContentLoaded', function () {
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

        let selectedThemes = [];

        window.toggleTheme = function (button, theme) {
            const index = selectedThemes.indexOf(theme);
            if (index > -1) {
                selectedThemes.splice(index, 1);
            } else {
                selectedThemes.push(theme);
            }
            updateButtons();
        }

        function updateButtons() {
            document.querySelectorAll('.theme-button').forEach(button => {
                if (selectedThemes.includes(button.value)) {
                    button.classList.add('active');
                } else {
                    button.classList.remove('active');
                }
            });
        }

        window.submitTheme = function () {
            if (selectedThemes.length > 0) {
                $.ajax({
                    url: '${path}/randomFunding/assignment.do?themes=' + selectedThemes.map(encodeURIComponent).join(','),
                    type: "GET",
                    success: function (response) {
                        alert(response.status);
                        if (response.funding_id == null) {
                            window.location.href = '${path}/';
                        } else {
                            window.location.href = '${path}/payment/pay.do?funding_id=' + response.funding_id;
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("에러 발생: " + error);
                    }
                });
            } else {
                alert('하나 이상의 테마를 선택해주세요.');
            }
        }
    });
    </script>
</body>
</html>
