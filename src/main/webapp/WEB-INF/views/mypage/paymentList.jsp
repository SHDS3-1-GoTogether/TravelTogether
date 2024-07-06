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
body {
	width: 100%;
	margin: 0;
}

.mypage-header {
	width: 70vw;
	margin: 0 auto;
	padding: 20px 20px 10px 20px;
}

.mypage-header h2 {
	font-size: 1.8em;
	padding: 0 20px;
	margin: 0;
}

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

.mypage-payment-content>h2 {
	font-size: 24px;
	margin-top: 0;
	margin-bottom: 20px;
	padding-left: 20px;
}

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

.tab__content-wrapper {
	width: 100%;
	padding: 0;
}

.tab__content {
	display: none;
}

.tab__content.active {
	display: block;
}

.list-table {
	width: 100%;
	margin: 0 auto;
	border: 1px solid #C9C9C9;
	border-radius: 8px;
	padding: 10px 0;
}

.list-table .header, .list-table .data {
	display: flex;
	justify-content: space-between;
	align-items: center;
	/* padding: 10px 0; */
}

.list-table .header p, .list-table .data p {
	color: #99A1B7;
	font-size: 0.9em;
	text-align: center;
	flex: 1;
}

.list-table .header p {
	font-weight: bold;
}

.list-table .data p {
	color: black;
}

.list-table .data .payment-buttons {
	/* display: flex; */
	flex-direction: column;
	align-items: flex-start;
}

.list-table .data .payment-buttons button {
	width: 100px !important;
	height: 30px !important;
	font-size: 14px !important;
	box-sizing: border-box;
	margin: 3px 0 !important;
	padding: 0 !important;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.payment-buttons .detail-button {
	background-color: #007bff;
	color: white;
}

.payment-buttons .detail-button:hover {
	background-color: #0056b3;
}

.payment-buttons .refund-button {
	background-color: #dc3545;
	color: white;
}

.payment-buttons .refund-button:hover {
	background-color: #c82333;
}

.refund-unavailable {
	color: red;
	font-weight: bold;
	padding: 5px;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
$(document).ready(function() {
    // 현재 페이지의 URL 가져오기
    var currentUrl = window.location.href;
    $(".menu-link").removeClass("highlight");

    // URL에 따라 적절한 탭을 활성화
    if (currentUrl.includes("refundList.do")) {
        $(".tab__item").removeClass("active");
        $(".tab__content").removeClass("active");
        $(".tab__item").filter(function() {
            return $(this).text().trim() === "환불내역";
        }).addClass("active");
        $("#tab2").addClass("active");
    } else if (currentUrl.includes("paymentList.do")) {
        $(".tab__item").removeClass("active");
        $(".tab__content").removeClass("active");
        $(".tab__item").filter(function() {
            return $(this).text().trim() === "결제내역";
        }).addClass("active");
        $("#tab1").addClass("active");
    }

    // 탭 버튼과 탭 내용 부분들을 querySelectorAll을 사용해 변수에 담는다.
    const tabItem = document.querySelectorAll(".tab__item");

    // 탭 버튼들을 forEach 문을 통해 한번씩 순회한다.
    tabItem.forEach((item) => {
        // 탭 버튼에 클릭 이벤트를 준다.
        item.addEventListener("click", (e) => {
            // 태그의 기본 동작(링크 연결) 방지를 위해 preventDefault를 추가한다.
            e.preventDefault();

            // 만약 환불내역 탭을 클릭했다면 refundList.do로 이동하여 데이터 가져오기
            if (item.textContent.trim() === "환불내역") {
                window.location.href = "${path}/mypage/refundList.do";
            } else if (item.textContent.trim() === "결제내역") {
                window.location.href = "${path}/mypage/paymentList.do";
            }
        });
    });

    // 모달창 띄우기
    $('.refund-button').click(function() {
        var paymentId = $(this).data('id');
        $('#productId').val(paymentId);
        $('#refundModal').css('display', 'block');
    });

    // 모달창 닫기
    $('.close').click(function() {
        $('#refundModal').css('display', 'none');
    });

    // 모달 외부 클릭 시 닫기
    $(window).click(function(event) {
        if (event.target.id === 'refundModal') {
            $('#refundModal').css('display', 'none');
        }
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
				<li class="tab__item active"><a href="#tab1">결제내역</a></li>
				<li class="tab__item"><a href="#tab2">환불내역</a></li>
			</ul>
			<!-- 탭 내용 영역 -->
			<div class="tab__content-wrapper">
				<div class="list-table tab__content active" id="tab1">
					<div class="header">
						<p class="payment-number">NO</p>
						<p class="payment-title">내역</p>
						<p class="payment-price">금액</p>
						<p class="payment-target">결제일</p>
						<p class="payment-status">상태</p>
						<p class="payment-button">상세</p>
					</div>
					<c:forEach var="payment" items="${paymentDetail}">
						<div class="data">
							<p class="payment-number">${payment.ROW_NUM }</p>
							<p class="payment-title">${payment.TITLE }</p>
							<p class="payment-price">
								<fmt:formatNumber pattern="#,###">${payment.PRICE }</fmt:formatNumber>
								원
							</p>
							<p class="payment-target">
								<fmt:formatDate value="${payment.PAYMENT_DATE}"
									pattern="YYYY-MM-dd" />
							</p>
							<p class="payment-status">${payment.STATUS }</p>
							<p class="payment-buttons">
								<c:choose>
									<c:when
										test="${payment.REFUND == 0 and payment.FUNDING_STATE != 3}">
										<button type="button" class="refund-button"
											data-id="${payment.PAYMENT_KEY}">환불 신청</button>
									</c:when>
									<c:otherwise>
										<span class="refund-unavailable">펀딩 확정</span>
									</c:otherwise>
								</c:choose>
							</p>
						</div>
					</c:forEach>
				</div>
				<!-- 환불 내역 리스트 -->
				<div class="list-table tab__content" id="tab2">
					<div class="header">
						<p class="payment-number">NO</p>
						<p class="payment-title">내역</p>
						<p class="payment-price">금액</p>
						<p class="payment-target">환불일</p>
						<p class="payment-status">상태</p>
						<p class="payment-button">사유</p>
					</div>
					<c:forEach var="refund" items="${refundDetail}">
						<div class="data">
							<p class="payment-number">${refund.ROW_NUM }</p>
							<p class="payment-title">${refund.TITLE }</p>
							<p class="payment-price">
								<fmt:formatNumber pattern="#,###">${refund.PRICE }</fmt:formatNumber>
								원
							</p>
							<p class="payment-target">
								<fmt:formatDate value="${refund.REFUND_DATE}"
									pattern="YYYY-MM-dd" />
							</p>
							<p class="payment-status">${refund.STATUS }</p>
							<p class="payment-buttons">${refund.REFUND_REASON }</p>
						</div>
					</c:forEach>
				</div>
				<%@ include file="../refund/refundModal.jsp"%>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>
