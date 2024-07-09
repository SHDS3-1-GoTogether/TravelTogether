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
<title>내펀딩</title>
<link href="${path}/resources/css/mypageMenu.css" rel="stylesheet">
<link href="${path}/resources/css/myFunding.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(function(){
		// 현재 페이지의 URL 가져오기
	    var currentUrl = window.location.href;
		$(".menu-link").removeClass("highlight");
	
	    // URL에 "qna"이 포함되어 있는지 확인
	    if (currentUrl.includes("myFunding")) {
	        // "QnA" 링크의 폰트 스타일 변경
	        $("#myFunding-link").addClass("highlight");
	    }
	});
</script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<div class="mypage-header">
		<h2>마이페이지</h2>
	</div>
	<div class="container">
		<%@ include file="./mypageMenu.jsp" %>
		<div class="mypage-funding-content">
			<h3><i class="fas fa-suitcase-rolling"></i> 내펀딩 목록</h3>
			<div class="list-table">
				<div class="header">
					<p class="funding-title">제목</p>
					<p class="funding-create-date">작성날짜</p>
					<p class="funding-deadline">마감일</p>
					<p class="funding-start-date">시작일</p>
					<p class="funding-end-date">종료일</p>
					<p class="funding-people-num">모집인원</p>
					<p class="funding-state">상태</p>
				</div>
				<div class="inner-wrap">
					<c:forEach var="funding" items="${fundinglist}">
						<div class="data">
							<p class="funding-title">
								<a href="${path}/funding/fundingDetail.do?funding_id=${funding.funding_id}" class="funding-link">
									${funding.title}
								</a>
							</p>
							<p class="funding-create-date">${funding.create_date}</p>
							<p class="funding-deadline">${funding.deadline}</p>
							<p class="funding-start-date">${funding.start_date}</p>
							<p class="funding-end-date">${funding.end_date}</p>
							<p class="funding-people-num">${funding.people_num}</p>
							<c:if test="${funding.funding_state == 0}">
								<p class="funding-state state${funding.funding_state}">컨펌대기중</p>
							</c:if>
							<c:if test="${funding.funding_state == 1}">
								<p class="funding-state state${funding.funding_state}">컨펌완료/진행중</p>
							</c:if>
							<c:if test="${funding.funding_state == 2}">
								<p class="funding-state state${funding.funding_state}">컨펌반려</p>
							</c:if>
							<c:if test="${funding.funding_state == 3}">
								<p class="funding-state state${funding.funding_state}">펀딩성공</p>
							</c:if>
							<c:if test="${funding.funding_state == 4}">
								<p class="funding-state state${funding.funding_state}">컨펌실패</p>
							</c:if>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>