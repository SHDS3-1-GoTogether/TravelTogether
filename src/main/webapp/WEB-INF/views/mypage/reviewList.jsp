<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 후기</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${path}/resources/css/mypageReviewList.css" rel="stylesheet">
<link href="${path}/resources/css/mypageMenu.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="mypage-header">
		<h2>마이페이지</h2>
	</div>
	<div class="container">
		<%@ include file="./mypageMenu.jsp"%>
		<div class="mypage-review-content">
			<h3>
				<i class="fas fa-pencil-alt"></i> 나의 후기
			</h3>
			<div class="review-content-wrap">
				<!-- 탭 버튼 영역 -->
				<div class="tab">
					<div class="tab__item active">
						<a href="#tab1">작성가능한 후기</a>
						<div class=""></div>
					</div>
					<div class="tab__item">
						<a href="#tab2">작성한 후기</a>
						<div class=""></div>
					</div>
				</div>
			
			<!-- 탭 내용 영역 -->
			<div class="tab__content-wrapper">
				<div id="tab1" class="tab__content active">
					<div class="review-content-wrap">
						<div class="header">
							<p clsss="funding-name">펀딩 이름</p>
							<p clsss="funding-departure">펀딩 장소</p>
							<p clsss="funding-price">펀딩 가격</p>
							<p clsss="funding-people-num">펀딩참여 수</p>
							
							<p class="funding-date">펀딩 참여 날짜</p>
							<p class="review-create">리뷰 작성</p>
						</div>
						<div class="data">
							<c:forEach var="review2" items="${reviewlist2}">
								<p clsss="funding-name">${review2.title}</p>
								<p class="funding-date">${review2.start_date} - ${review2.end_date}</p>
								<p class="review-create"><button onclick="location.href = '${path}/mypage/reviewInsert.do?funding_id='+${review2.funding_id} ">리뷰작성하기</button></p>					
							</c:forEach>
						</div>
					</div>
				</div>
					<div id="tab2" class="tab__content">
						<div class="header">
							<p>펀딩 이름</p>
							<!-- <p>펀딩 날짜</p> -->
							<p>리뷰 쓴 날짜</p>
							<p>좋아요 수</p>
							<p>조회수</p>
							<p>보러가기</p>
						</div>
						<div class="data">
							<c:forEach var="review" items="${reviewlist}">
								<p>${review.title}</p>
								<p>${review.create_date}</p>
								<p>${review.like_count}</p>
								<p>${review.views}</p>
								<p><button onclick="">상세보기</button></p>
							</c:forEach>
						</div>
					</div>
				</div>
				</div>
			</div>
		</div>
	<%@ include file="../common/footer.jsp"%>
	<script>
		// 1. 탭 버튼과 탭 내용 부분들을 querySelectorAll을 사용해 변수에 담는다.
		const tabItem = document.querySelectorAll(".tab__item");
		const tabContent = document.querySelectorAll(".tab__content");
	
		// 2. 탭 버튼들을 forEach 문을 통해 한번씩 순회한다.
		// 이때 index도 같이 가져온다.
		tabItem.forEach((item, index) => {
	  	// 3. 탭 버튼에 클릭 이벤트를 준다.
	  	item.addEventListener("click", (e) => {
		    // 4. 버튼을 a 태그에 만들었기 때문에, 
		    // 태그의 기본 동작(링크 연결) 방지를 위해 preventDefault를 추가한다.
		    e.preventDefault(); // a 
		    
		    // 5. 탭 내용 부분들을 forEach 문을 통해 한번씩 순회한다.
		    tabContent.forEach((content) => {
		      // 6. 탭 내용 부분들 전부 active 클래스를 제거한다.
		      content.classList.remove("active");
		    });

		    // 7. 탭 버튼들을 forEach 문을 통해 한번씩 순회한다.
		    tabItem.forEach((content) => {
		      // 8. 탭 버튼들 전부 active 클래스를 제거한다.
		      content.classList.remove("active");
		    });
			
		    // 9. 탭 버튼과 탭 내용 영역의 index에 해당하는 부분에 active 클래스를 추가한다.
		    // ex) 만약 첫번째 탭(index 0)을 클릭했다면, 같은 인덱스에 있는 첫번째 탭 내용 영역에
		    // active 클래스가 추가된다.
		    tabItem[index].classList.add("active");
		    tabContent[index].classList.add("active");
		  });
		});
	</script>
</body>
</html>