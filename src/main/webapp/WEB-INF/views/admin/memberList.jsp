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
				<button id="searchBtn"><i class="fas fa-search"></i></button>
			</div>
			<div class="list-table">
				<div class="header">
					<p>회원번호</p>
					<p class="">아이디</p>
					<p class="">닉네임</p>
					<p class="">이메일</p>
					<p class="">성별</p>
					<p class="">등급</p>
					<p>글/댓글/후기/문의</p>
					<p>탈퇴<p>
				</div>
				<div class="list-item">
					<c:forEach var="member" items="${memberlist}">
						<div class="data">
							<p>${member.member_id}</p>
							<p class="">${member.login_id}</p>
							<p class="">${member.nickname}</p>
							<p class="">${member.email}</p>
							<p class="">${member.membership_id}</p>
							
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp" %>
	
	<script>
		$(function(){
			$("#searchInput").on("keypress", f_keypressEnter);
			$("#searchBtn").on("click", f_searchWord);
		});
		
		function f_searchWord(){
			var word = $("#searchInput").val();
			
			if(word == null) {
				alert("검색어를 입력해주세요.");
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
	</script>
</body>
</html>