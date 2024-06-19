<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지 쿠폰</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="${path}/resources/css/userCouponList.css" rel="stylesheet">
	<link href="${path}/resources/css/mypageMenu.css" rel="stylesheet">
	<link
	    rel="stylesheet"
	    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
	  />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		$(function(){
			// 현재 페이지의 URL 가져오기
	        var currentUrl = window.location.href;
			$(".menu-link").removeClass("highlight");
	
	        // URL에 "coupon"이 포함되어 있는지 확인
	        if (currentUrl.includes("coupon")) {
	            // "쿠폰" 링크의 폰트 스타일 변경
	            $("#coupon-link").addClass("highlight");
	        }
		});
	</script>
</head>
<body>
<div class="container">
	<%@ include file="../common/header.jsp" %>
	<%@ include file="./mypageMenu.jsp" %>
	<div class="mypage-coupon-content">
		<h2><i class="fas fa-tags"></i> 보유쿠폰</h2>
		<div class="coupon-content-wrap">
			<c:forEach items="${couponlist}" var="coupon">
				<div class="coupon-item-wrap">
					<c:if test="${coupon.discount_rate > 0}">
						<div class="coupon-title">${coupon.title}</div>
						<div class="coupon-info1">
							<div class="coupon-info-max-discount">
								<p>최대할인금액</p>
								<p><fmt:formatNumber pattern="#,###">${coupon.max_discount}</fmt:formatNumber>원</p>
							</div>
							<div class="coupon-info-due-date">
								<p>만료일</p>
								<p>${coupon.due_date}</p>
							</div>
						</div>
					</c:if>
					<c:if test="${coupon.discount_rate == 0}">
						<div class="coupon-title">${coupon.title}</div>
						<%-- <div class="coupon-title"><fmt:formatNumber pattern="#,###">${coupon.max_discount}</fmt:formatNumber>원 할인쿠폰</div> --%>
						<div class="coupon-info2">
							<div class="coupon-info-due-date">
								<p>만료일</p>
								<p>${coupon.due_date}</p>
							</div>
						</div>
					</c:if>
				</div>
			</c:forEach>
		</div>
	</div>
	<%@ include file="../common/footer.jsp" %>
</div>
</body>
</html>