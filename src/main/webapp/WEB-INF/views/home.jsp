<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>트투</title>
<link rel="stylesheet" href="${path}/resources/css/styles.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
</head>
<body>
	<%@ include file="common/header.jsp"%>
	<div class="container">
	<section class="main-banner">
        <h1>여행가고 싶은데 혼자 가기는 싫을 때.. 같이 갈래?</h1>
        <button>함께하기</button>
    </section>
    
    <section class="recommended-projects">
    	<div class="section-title">
    		<img src="${path}/resources/images/fire.png" alt="불">
        	<h2>인기 펀딩</h2>
    	</div>
        <div class="slider">
        	<div class="funding-box">
        		<c:forEach var="funding" items="${fundinglist}">
	        		<div class="slide">
			        	<div class="project-card"  onclick="location.href='${path}/funding/fundingDetail.do?funding_id=${funding.funding_id}'">
			        		<div class="img-wrap">
				        		<c:forEach var="photo" items="${fundingphotolist}">
		    						<c:if test="${photo.funding_id == funding.funding_id}">
					            		<img src="${photo.photo_name}" alt="${photo.photo_name}">
					            	</c:if>
					            </c:forEach>
				            </div>
				            <h3>${funding.title}</h3>
				            <p>마감일 ${funding.deadline}</p>
				            <div class="progress-content">
				            	<progress value="${funding.consumer_num/funding.people_num*100}" max="100"></progress>
				            	<p><fmt:formatNumber type="percent">${funding.consumer_num/funding.people_num}</fmt:formatNumber></p>
				            </div>
				        </div>
				    </div>
		        </c:forEach>
        	</div>
        </div>
    </section>
    
    <section class="reviews">
    <div class="section-title">
    	<img src="${path}/resources/images/star.png" alt="별">
		<h2>이번달 Best 후기</h2>
    </div>
    <div class="review-list">
    	<c:forEach var="review" items="${reviewlist}" varStatus="index">
    		<div class="review-item">
	    		<div class="review-rank"><i class="fas fa-medal rank${index.count}"></i>${index.count}등</div>
	    		<div class="review" onclick="location.href='${path}/review/reviewDetail.do?review_id=${review.review_id}'">
	    			<div class="img-wrap">
		    			<c:forEach var="photo" items="${reviewphotolist}">
		    				<c:if test="${photo.review_id == review.review_id}">
		    					<img src="${photo.photo_name}" alt="${photo.photo_name}">
		    				</c:if>
		    			</c:forEach>
	    			</div>
		            <p class="review-title">${review.title}</p>
		            <div class="review-info">
		            	<p class="review-nickname">${review.nickname}</p>
		            	<p><i class="far fa-eye"></i><span>${review.views}</span></p>
		            	<p><i class="far fa-thumbs-up"></i><span>${review.like_count}</span></p>
		            </div>
		        </div>
	        </div>
    	</c:forEach>
    </div>
    </section>
    </div>
    <%@ include file="common/footer.jsp"%>
    
    <script>
    document.addEventListener('DOMContentLoaded', function () {
        const sections = document.querySelectorAll('section');
        
        const observerOptions = {
            root: null,
            rootMargin: '0px',
            threshold: 0.5 // 섹션이 뷰포트의 50%에 도달할 때 트리거
        };

        const observerCallback = (entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                } else {
                    entry.target.classList.remove('visible');
                }
            });
        };

        const observer = new IntersectionObserver(observerCallback, observerOptions);

        sections.forEach(section => {
            observer.observe(section);
        });
    });
	 	// 롤링 배너 복제본 생성
	    let roller = document.querySelector('.funding-box');
	    roller.id = 'roller1'; // 아이디 부여
	
	    let clone = roller.cloneNode(true)
	    // cloneNode : 노드 복제. 기본값은 false. 자식 노드까지 복제를 원하면 true 사용
	    clone.id = 'roller2';
	    document.querySelector('.slider').appendChild(clone); // wrap 하위 자식으로 부착
	
	    document.querySelector('#roller1').style.left = '0px';
	    document.querySelector('#roller2').style.left = document.querySelector('.funding-box .slide').offsetWidth + 'px';
	    // offsetWidth : 요소의 크기 확인(margin을 제외한 padding값, border값까지 계산한 값)
	
	    roller.classList.add('original');
	    clone.classList.add('clone');
	    
	    
    </script>
</body>
</html>