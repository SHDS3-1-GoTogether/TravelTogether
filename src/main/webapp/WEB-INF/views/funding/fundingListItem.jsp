<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/css/fundingList.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<c:forEach var="fund" items="${fundlist}">
		<div class="item" onclick="location.href='fundingDetail.do?funding_id=${fund.funding_id}'">
			<div class="item_img_div">
				<c:forEach var="mainImg" items="${plist}">
					<c:if test="${mainImg.funding_id==fund.funding_id}">
						<img class="item_img" alt="${mainImg.photo_name}"
					src="${mainImg.photo_name}" />
					</c:if>
				</c:forEach>
			</div>
			<div class="item_content">
				<div>
					<span class="fund_title">${fund.title}</span> 
					<span class="fund_price"><fmt:formatNumber type="number"
							maxFractionDigits="3" value="${fund.price}" />원</span>
				</div>
				<div class="item_detail_wrapper">
					<span class="item_detail_title"> 
						<img class="item_icon" alt="깃발" src="${path}/resources/images/flag.png"><span>지역</span><br> 
						<img class="item_icon" alt="사람" src="${path}/resources/images/person.png"><span>인원</span><br>
						<img class="item_icon" alt="달력" src="${path}/resources/images/calendar.png"><span>기간</span><br>
					</span>
					<div class="v-line"></div>
					<span class="item_detail_content"> 
						<span id="fund_area">${fund.area}</span><br>
						<span id="people_num">
							<c:forEach var="consumer" items="${consumer}">
								<c:if test="${fund.funding_id == consumer.funding_id}">
									${consumer.consumerCount}
								</c:if>
							</c:forEach>
						/ ${fund.people_num}</span><br> 
						<span id="fund_date">${fund.start_date}- ${fund.end_date}</span><br>
					</span>
				</div>
				<span class="traffic-wrapper">
					<img alt="출발옵션" src="${path}/resources/images/traffic_op.png">
					<c:choose>
						<c:when test="${fund.confirm_option < 2}">
							<span class="traffic-contentPink">따로출발</span>
						</c:when>
						<c:when test="${fund.confirm_option >= 2}">
							<span class="traffic-contentBlue">같이출발</span>
						</c:when>
					</c:choose>
				</span>
				<div class="item_bottom">
					<img class="icon_view" alt="눈" src="${path}/resources/images/view.png"><span class="views">${fund.views}</span> 
					<span class="theme">
						<c:forEach var="theme" items="${tlist}">
							<c:if test="${theme.funding_id==fund.funding_id}">
								<span>#${theme.title}</span>
							</c:if>
						</c:forEach>
					</span>
				</div>
			</div>
		</div>
	</c:forEach>
</body>
</html>