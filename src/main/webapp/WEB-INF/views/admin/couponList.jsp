<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 쿠폰 목록</title>
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
/>
<link href="${path}/resources/css/adminMenu.css" rel="stylesheet">
<link href="${path}/resources/css/adminCouponList.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="./adminMenu.jsp" %>
	<div class="content">
		<h2><i class="fas fa-tags"></i> 쿠폰 목록</h2>
		<div class="option">
			<div class="select-option">
				<p class="select-label">구분 : </p>
				<select id="coupon_option">
					<option value="-1">전체</option>
					<option value="0" >정기</option>
					<option value="1">특별</option>
					<option value="2">일반</option>
				</select>
			</div>
			<div class="select-option">
				<button class="add-button"><i class="fas fa-plus"></i> 쿠폰등록</button>
			</div>
		</div>
		<div class="list-table">
			<div class="header">
				<p>쿠폰번호</p>
				<p class="coupon-title">쿠폰명</p>
				<p>할인율</p>
				<p class="coupon-price">최대할인금액</p>
				<p class="coupon-price">할인금액</p>
				<p class="coupon-target">지급대상</p>
				<p class="coupon-button">수정</p>
				<p class="coupon-button">삭제</p>
			</div>
			<c:forEach var="coupon" items="${couponlist}">
				<div class="data">
					<p>${coupon.coupon_id}</p>
					<p class="coupon-title">${coupon.title}</p>
					<c:if test="${coupon.discount_rate > 0}">
						<p>${coupon.discount_rate}%</p>
						<p class="coupon-price">
							<fmt:formatNumber pattern="#,###">${coupon.max_discount}</fmt:formatNumber>원
						</p>
						<p class="coupon-price"></p>
					</c:if>
					<c:if test="${coupon.discount_rate <= 0}">
						<p></p>
						<p class="coupon-price"></p>
						<p class="coupon-price"><fmt:formatNumber pattern="#,###">${coupon.max_discount}</fmt:formatNumber>원</p>
					</c:if>
					<p class="coupon-target">${coupon.membership_id}</p>
					<p class="coupon-button"><button class="button"><i class="fas fa-pencil-alt"></i></button></p>
					<p class="coupon-button"><button class="button"><i class="fas fa-trash-alt"></i></button></p>
				</div>
			</c:forEach>
		</div>
	</div>
	<script>
		$(function(){
			$.each($("#coupon_option").children("option"), function(index, item){
				console.log(item);
				if(item.value == ${option}){
					console.log("확인");
					item.setAttribute('selected', 'selected');
				}
			});
			$("#coupon_opion")
			$("#coupon_option").on("change", f_optionSelect);
		});
		
		function f_optionSelect() {
			var option = $("#coupon_option option:selected").val();
			location.href="${path}/admin/couponList.do?option="+option;
		}
</script>
</body>
</html>