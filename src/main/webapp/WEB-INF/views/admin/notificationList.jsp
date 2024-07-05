<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림 리스트 조회</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link href="${path}/resources/css/adminMenu.css" rel="stylesheet">
<link href="${path}/resources/css/adminNotificationList.css"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<%@ include file="./adminMenu.jsp"%>
		<%-- 관리자페이지 사이드 메뉴 --%>
		<div class="content">
			<h2>
				<i class="fas fa-bell"></i> 알림 목록
			</h2>
			<div class="button-wrap">
				<button class="add-button" id="addBtn">
					<i class="fas fa-plus"></i> 알림등록
				</button>
			</div>
			<div class="list-table">
				<div class="header">
					<p class="notification-number">알림번호</p>
					<p class="message-content">내용</p>
					<p class="send-date">발송일</p>
					<p>수신자</p>
				</div>
				<div class="data-wrap">
					<c:forEach var="notification" items="${notificationlist}">
						<div class="data">
							<p class="notification-number">${notification.message_id}</p>
							<div class="message-content">${notification.message_content}</div>
							<p class="send-date">${notification.send_date}</p>
							<p>${notification.member_id}</p>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp"%>
	<script>
		$(function() {
			$("#addBtn").on("click", f_addBtnClick);
			
			extractTextContent();
		});

		function f_addBtnClick() {
			location.href = "${path}/admin/notificationInsert.do";
		}
		
		function extractTextContent() {
            var originalElements = document.getElementsByClassName('notification-content');
            var targetElements = document.getElementsByClassName('text-only-content');

            for (var i = 0; i < originalElements.length; i++) {
                var textContent = originalElements[i].textContent || originalElements[i].innerText;
                targetElements[i].textContent = textContent;
            }
        }
	</script>
</body>
</html>