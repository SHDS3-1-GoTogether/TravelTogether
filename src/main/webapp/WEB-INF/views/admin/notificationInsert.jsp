<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림 등록</title>
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
/>
<link href="${path}/resources/css/adminMenu.css" rel="stylesheet">
<link href="${path}/resources/css/notificationInsert.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<%@ include file="./adminMenu.jsp"%>
		<%-- 관리자페이지 사이드 메뉴 --%>
		<div class="content">
			<h2>
				<i class="fas fa-bell"></i> 알림 등록
			</h2>
			<div class="list-table">
				<div class="header">
					<p class="select-checkbox"></p>
					<p class="nickname">닉네임</p>
					<p class="membership">회원등급</p>
					<p class="community">후기/댓글/문의</p>
					<p class="funding">참여중인 펀딩</p>
				</div>
				<div class="data-wrap">
					<c:forEach var="member" items="${memberlist}">
						<div class="data">
							<input type="hidden" class="nickname-value" value="${member.nickname}">
							<input type="hidden" class="member-id-value" value="${member.member_id}">
							<p class="select-checkbox"><input type="checkbox" class="member-checkbox"></p>
							<p class="nickname">${member.nickname}</p>
							<c:if test="${member.membership_id == 'walker'}">
								<p class="membership">뚜벅이</p>
							</c:if>
							<c:if test="${member.membership_id == 'bicycle'}">
								<p class="membership">자전거</p>
							</c:if>
							<c:if test="${member.membership_id == 'car'}">
								<p class="membership">자동차</p>
							</c:if>							
							<p class="community"></p>
							<p class="funding"></p>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="select-member-list-wrap">
				<h3>선택한 회원</h3>
				<div id="selected-values"></div>
			</div>
			
			<div class="message-input-wrap">
				<h3>메시지 작성</h3>
				<form action="${path}/admin/notificationInsert.do" method="post" id="notificationForm">
					<input type="hidden" name="selectedMembers" id="selectedMembers">
					<textarea name="message_content" class="message-content-input" rows="5" placeholder="내용을 입력하세요."></textarea>
					<button type="button" id="submitBtn"><i class="fas fa-paper-plane"></i></button>
				</form>
			</div>
			
		</div>
	</div>
	<script>
		$(function(){
			$("#notificationMenu").addClass("active");
			
			// 체크박스 변화 감지
			$(".member-checkbox").on("change", f_selectMember);
			$("#submitBtn").on("click", f_submitBtnClick);
		});
		
		function f_selectMember() {
			let selectedNicknames = [];
			let selectedMemberIds = [];

			// 체크된 체크박스들을 순회
			$(".member-checkbox:checked").each(function() {
				let hiddenNickname = $(this).closest(".data").find("input[class='nickname-value']").val();
				let hiddenMemberId = $(this).closest(".data").find("input[class='member-id-value']").val();
				selectedNicknames.push(hiddenNickname);
				selectedMemberIds.push(hiddenMemberId);
			});
			console.log(selectedNicknames);
			console.log(selectedMemberIds);

			// 선택된 값을 보여줌
			$("#selected-values").html(selectedNicknames.join("<br>"));
			$("#selectedMembers").val(selectedMemberIds.join(","));
		}
		
		function f_submitBtnClick(){
			console.log($("#selectedMembers").val());
			$("#notificationForm").submit();
		}
	</script>
</body>
</html>