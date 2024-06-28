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
<title>마이페이지 알림</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${path}/resources/css/mypageNotification.css" rel="stylesheet">
<link href="${path}/resources/css/mypageMenu.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(function() {
		// 현재 페이지의 URL 가져오기
		var currentUrl = window.location.href;
		$(".menu-link").removeClass("highlight");

		// URL에 "notification"이 포함되어 있는지 확인
		if (currentUrl.includes("notification")) {
			// "알림" 링크의 폰트 스타일 변경
			$("#notification-link").addClass("highlight");
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
		<div class="mypage-notification-content">
			<h2><i class="fas fa-bell"></i> 알림함</h2>
			<div class="notification-list-wrap">
				<c:if test="${fn:length(notificationlist) <= 0}">
					<div class="no-notification-content">알림이 없습니다.</div>
				</c:if>
				<div class="notification-list-content">
				<c:forEach items="${notificationlist}" var="notification">
					<div class="notification-item-wrap">
						<div class="notification-content">${notification.message_content}</div>
						<div class="notification-send-date">
							<fmt:formatDate value="${notification.send_date}" pattern=""/>
						</div>
					</div>
				</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>