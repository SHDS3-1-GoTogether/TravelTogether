<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 펀딩관리</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link href="${path}/resources/css/adminMenu.css" rel="stylesheet">
<link href="${path}/resources/css/adminFundingList.css" rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<%@ include file="./adminMenu.jsp"%>
		<div class="content">
			<h2>
				<i class="fas fa-tags"></i> 펀딩 목록
			</h2>
			<div class="option">
				<div class="select-option">
					<div class="select-option-item">
						<p class="select-label">회원유형 :</p>
						<select id="member_option">
							<option value="-1" selected>전체</option>
							<option value="0">일반회원</option>
							<option value="1">관리자</option>
						</select>
					</div>
					<div class="select-option-item">
						<p class="select-label">펀딩상태 :</p>
						<select id="state_option">
							<option value="-1" selected>전체</option>
							<option value="0">컨펌대기</option>
							<option value="1">컨펌완료/진행중</option>
							<option value="2">컽펌반려</option>
							<option value="3">펀딩성공</option>
							<option value="4">펀딩실패</option>
						</select>
					</div>
				</div>
				<div class="select-option">
					<button class="add-button" onclick="location.href='${path}/admin/fundingInput.do'">
						<i class="fas fa-plus"></i> 펀딩등록
					</button>
				</div>
			</div>
			<div class="list-table">
				<div class="header">
					<p>번호</p>
					<p class="funding-writer">등록자</p>
					<p class="funding-title">펀딩명</p>
					<p class="funding-area">지역</p>
					<p class="funding-deadline">마감일</p>
					<p class="funding-people-num">인원수</p>
					<p class="funding-confirm-state">컨펌상태</p>
					<p class="funding-process-state">진행상태</p>
					<!-- <p class="funding-confirm-button"></p> -->
				</div>
				<div class="list-item">
				
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp"%>

	<script>
		$(function() {
			$.ajax({
				url : "${path}/admin/fundingListItem.do",
				type : "get",
				success : function(responseData) {
					$(".list-item").html(responseData);
				}
			});
			
			$("#member_option").on("change", f_memberOptSelect);
			$("#state_option").on("change", f_memberOptSelect);
		});
		
		function f_memberOptSelect(){
			var member_type = $("#member_option").val();
			var funding_state = $("#state_option").val();
			$.ajax({
				url: "${path}/admin/fundingListItem.do",
				type: "get",
				data: {
					"member_type": member_type,
					"funding_state": funding_state
				},
				success: function(responseData){
					$(".list-item").html(responseData);
				}
			});
		}
	</script>
</body>
</html>