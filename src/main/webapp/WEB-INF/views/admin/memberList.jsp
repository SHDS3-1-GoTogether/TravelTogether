<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 회원관리</title>
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
/>
<link href="${path}/resources/css/adminMenu.css" rel="stylesheet">
<link href="${path}/resources/css/adminMemberList.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<div class="container">
		<%@ include file="./adminMenu.jsp" %>
		<div class="content">
			<h2><i class="fas fa-id-badge"></i> 회원 목록</h2>
			<div class="search-content">
				<input type="text" id="searchInput" placeholder="아이디, 이름, 닉네임 등 검색">
				<button id="searchBtn" class="search-btn"><i class="fas fa-search"></i></button>
			</div>
			<div class="list-table">
				<div class="header">
					<p class="member-id">회원번호</p>
					<p class="member-login-id">아이디</p>
					<p class="member-nickname">닉네임</p>
					<p class="member-email">이메일</p>
					<p class="member-membership">등급</p>
					<p class="member-acc-amount">누적금액</p>
					<p class="member-delete">탈퇴</p>
				</div>
				<div class="list-item">
					<c:forEach var="member" items="${memberlist}">
						<div class="data">
							<p class="member-id">${member.member_id}</p>
							<p class="member-login-id">${member.login_id}</p>
							<p class="member-nickname">${member.nickname}</p>
							<p class="member-email">${member.email}</p>
							<p class="member-membership">${member.membership_id}</p>
							<p class="member-acc-amount">${member.acc_amount}</p>
							<p class="member-delete">
								<c:if test="${member.is_delete == false}">
									<button class="button delete-btn" onclick="f_memberDelete(${member.member_id})"><i class="fas fa-trash-alt"></i></button>
								</c:if>
								<c:if test="${member.is_delete == true}"><span>탈퇴</span></c:if>
							</p>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp" %>
	
	<%-- 회원 삭제 성공 모달 --%>
	<div class="delete-success-modal-box">
		<h3>회원삭제 성공</h3>
		<p>회원을 삭제하였습니다.</p>
		<button type="button" class="confirm-button">확인</button>
	</div>
	<div class="delete-fail-modal-box">
		<h3>회원삭제 실패</h3>
		<p>삭제할 수 없는 회원입니다.</p>
		<button type="button" class="confirm-button">확인</button>
	</div>
	<div class="modal_bg"></div>
	
	<script>
		$(function(){
			$("#searchInput").on("keypress", f_keypressEnter);
			$("#searchBtn").on("click", f_searchWord);
			$(".confirm-button").on("click", f_confirmBtnClick);
		});
		
		function f_searchWord(){
			var word = $("#searchInput");
			
			if(word.val() == "") {
				alert("검색어를 입력해주세요.");
				word.focus();
			} else {
				location.href="${path}/admin/memberList.do?word="+word;
			}	
		}
		
		function f_keypressEnter(e){
			if(e.keyCode && e.keyCode == 13){
				$("#searchBtn").trigger("click");
				return false;
			}
			//엔터키 막기
			if(e.keyCode && e.keyCode == 13){
				  e.preventDefault();	
			}
		}
		
		function f_memberDelete(member_id) {
			console.log(member_id);
			$.ajax({
				url: "${path}/admin/memberDelete.do",
				method: "post",
				data: {"member_id": member_id},
				success: function(responseData){
					console.log(responseData);
					$("body").addClass("scrollLock");
					$(".modal_bg").fadeIn(500);
					if(responseData == "0") {
						$(".delete-fail-modal-box").fadeIn(500);
					} else {
						$(".delete-success-modal-box").fadeIn(500);
					}
				}
			});
		}
		function f_confirmBtnClick(){
			location.href="${path}/admin/memberList.do";
		}
	</script>
</body>
</html>