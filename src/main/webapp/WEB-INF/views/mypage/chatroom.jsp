<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${path}/resources/css/userCouponList.css" rel="stylesheet">
<link href="${path}/resources/css/mypageMenu.css" rel="stylesheet">
<link href="${path}/resources/css/chatroom.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<div class="container">
		<%@ include file="../common/header.jsp"%>
		<%@ include file="./mypageMenu.jsp"%>
		<div class="mypage-coupon-content">
			<h2>
				<i class="fas fa-user"></i> 채팅룸
			</h2>
			<div class="coupon-content-wrap">
				<h1>${member.nickname }님의 채팅방 목록</h1>
				<div id="chat">
					<c:forEach var="chat" items="${chatRoom}">
						<a href="${path }/chat/${chat.funding_id}">
							<div class="myRoom">"${chat.title}" 채팅방 접속하기 (${chat.people_num })
							<br> [ ${chat.start_date } ~ ${chat.end_date } ]
							</div>
						</a>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>