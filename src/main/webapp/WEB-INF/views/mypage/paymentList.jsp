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
<title>결제 내역</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${path}/resources/css/mypageMenu.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<style>
.container {
	width: 70vw;
	margin: 0 auto;
	display: flex;
	flex-direction: row;
	padding: 20px;
}

.mypage-payment-content {
	width: 70%;
	margin: 0 auto;
	padding-bottom: 20px;
}

.mypage-header {
	width: 70vw;
	margin: 0 auto;
	padding: 20px 20px 10px 20px;
}

.mypage-header h2 {
	font-size: 1.8em;
	padding: 0 20px;
}

.mypage-payment-content>h2 {
	font-size: 24px;
	margin-top: 0;
	margin-bottom: 20px;
	padding-left: 20px;
}

/* ------------------------- */
html, body {
	width: 100%;
}

body, div, ul, li {
	margin: 0;
	padding: 0;
}

ul, li {
	list-style: none;
}

/*tab css*/
a {
	text-decoration: none;
	color: inherit;
}

.tab {
	display: flex;
	align-items: center;
	padding: 1rem;
}

.tab__item {
	padding: 0.6rem 1.3rem;
	margin-right: 1rem;
	border: 1px solid #ddd;
	border-radius: 2rem;
}

.tab__item.active {
	display: inline-block;
	border: 1px solid #68A6F3;
	background-color: #68A6F3;
	color: #fff;
}

/* .tab__content-wrapper {
	padding: 1rem
} */
.tab__content {
	display: none;
}

.tab__content.active {
	display: block;
}
/* ---------정민이 코드 참고--------- */
.list-table {
	width: 100%;
	margin: 0 auto;
	border: 1px solid #C9C9C9;
	border-radius: 8px;
	padding: 10px 0;
}

.list-table .header p {
	display: inline-block;
	color: #99A1B7;
	font-size: 0.9em;
	padding: 0 5px;
	text-align: center;
	width: 8%;
}

.list-table .data p {
	display: inline-block;
	font-size: 0.9em;
	padding: 0 5px;
	text-align: center;
	width: 8%;
}

.header {
	width: 90%;
	margin: 0 auto;
	border-bottom: 1px dashed #DBDFE9;
}

.payment-number {
	width: 10% !important;
}

.payment-title {
	width: 20% !important;
}

.payment-price {
	width: 10% !important;
}

.payment-target {
	width: 20% !important;
}

.payment-status {
	width: 10% !important;
}

.payment-button {
	width: 15% !important;
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(function() {
		// 현재 페이지의 URL 가져오기
		var currentUrl = window.location.href;
		$(".menu-link").removeClass("highlight");

		// URL에 "coupon"이 포함되어 있는지 확인
		if (currentUrl.includes("payment")) {
			// "쿠폰" 링크의 폰트 스타일 변경
			$("#payment-link").addClass("highlight");
		}

		
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
	});
</script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="mypage-header">
		<h2>마이페이지</h2>
	</div>
	<div class="container">
		<%@ include file="./mypageMenu.jsp"%>
		<div class="mypage-payment-content">
			<h2>
				<i class="fas fa-receipt"></i> 결제내역
			</h2>
			<!-- 탭 버튼 영역 -->
			<ul class="tab">
				<li class="tab__item active"><a href="#tab1">Tab 1</a></li>
				<li class="tab__item"><a href="#tab2">Tab 2</a></li>
				<li class="tab__item"><a href="#tab3">Tab 3</a></li>
				<li class="tab__item"><a href="#tab4">Tab 4</a></li>
			</ul>

			<!-- 탭 내용 영역 -->
			<div class="tab__content-wrapper">
				<div class="list-table tab__content active" id="tab1">
					<div class="header">
						<p class="payment-number">결제번호</p>
						<p class="payment-title">내역</p>
						<p class="payment-price">금액</p>
						<p class="payment-target">결제일</p>
						<p class="payment-status">결제상태</p>
						<p class="payment-button">상세</p>
					</div>
					<c:forEach var="payment" items="${paymentDetail}">
						<div class="data">
							<p class="payment-number">${payment.ROW_NUM }</p>
							<p class="payment-title">${payment.TITLE }</p>
							<p class="payment-price">
								<fmt:formatNumber pattern="#,###">
									${payment.PRICE }
								</fmt:formatNumber>
								원
							</p>
							<p class="payment-target">
								<fmt:formatDate value="${payment.PAYMENT_DATE}"
									pattern="YYYY-MM-dd" />
							</p>
							<p class="payment-status">${payment.STATUS }</p>
							<p class="payment-button">
								<button class="detail-button" data-id="${payment.PAYMENT_ID}">상세보기</button>
								<c:if test="${payment.REFUND == 0}">
								
									<button type="button" class="btn btn-primary refund-button"
										data-toggle="modal" data-target="#refundModal" data-id="${payment.PAYMENT_KEY}">funding-refund
									</button>

									<%-- <button class="refund-button" data-id="${payment.PAYMENT_KEY}">환불하기</button> --%>
								</c:if>
							</p>
						</div>
					</c:forEach>
				</div>
				<div class="list-table tab__content" id="tab2">
					<div class="header">
						<p class="payment-number">결제번호</p>
						<p class="payment-title">내역</p>
						<p class="payment-price">금액</p>
						<p class="payment-target">결제일</p>
						<p class="payment-status">결제상태</p>
						<p class="payment-button">상세</p>
					</div>
				</div>
				<%@ include file="../refund/refundModal.jsp"%>
			</div>
		</div>
	</div>
	</div>
</body>
</html>