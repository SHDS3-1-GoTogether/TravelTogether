<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/css/fundingBase.css">
<link rel="stylesheet" href="${path}/resources/css/fundingDetail.css">
<script src="${path}/resources/js/fundingDetail.js"></script>
<script>
	let images = new Array();
</script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
		<div class="content_wrapper">
		<h1 class="pageTitle">Join Funding!</h1>
		<div class="form-wrapper">
		<div class="form-left-wrapper">
			<div class="detailContent">
				<div class="detail-title">"${fund.title}"</div>
				<div class="detail-content">${fund.funding_content}</div>
				<c:forEach var="photo" items="${pic}">
<%-- 					<img alt="${photo}" 
					src="${photo}"
					width="200" height="200"> --%>
					<script>
						images.push("${photo}");	
					</script>
				</c:forEach>	
						<div class="slider__wrap">
		            <div class="slider__img"></div>
		            <div class="slider__thumnail"></div>
		            <div class="slider__btn">
		                <a href="#" class="previous"><img alt="vector-left.png" src="${path}/resources/images/vector-left.png"></a>
		                <a href="#" class="next"><img alt="" src="${path}/resources/images/vector-right.png"/></a>
		            </div>
		        </div>
			</div>

		</div>
		<div class="right-wrapper">
		<div class="option_wrapper">
			<p class="option-title">옵션내역</p>
			<ul class="option-li-wrapper">
				<li>
					여행일정
					<div>${fund.start_date}-${fund.end_date}</div>
					
				</li>
				<li>
					여행지
					<div>${fund.area}</div>
				</li>
				<li>
					인원
					<div>${fund.people_num}</div>
				</li>
				<li>
					숙소
					<c:if test="${fund.accommodation==null}"><div>미정</div></c:if>
					<div>${fund.accommodation}</div>
				</li>
				<li>
					교통
					<c:if test="${fund.traffic==null}"><div>미정</div></c:if>
					<div>${fund.traffic}</div>	
				</li>
				<li>
					예산
					<div><fmt:formatNumber type="number" maxFractionDigits="3" value="${fund.price}" />원</div>
				</li>
				<li>
					테마<br>
					<c:forEach var="theme" items="${tlist}">
						<c:if test="${theme.funding_id==fund.funding_id}">
							<span>#${theme.title}</span>
						</c:if>
					</c:forEach>
				</li>
				<li>
					펀딩마감일
					<div>${fund.deadline}</div>
				</li>
			</ul>			

		</div>
		<div class="payBtn-wrapper">
			<button id="doPay" class="payBtn" onclick="location.href='${path}/payment/pay.do?funding_id=${fund.funding_id}'" >신청하기</button>	
		</div>
		</div>
	</div>
</div>


</body>
</html>