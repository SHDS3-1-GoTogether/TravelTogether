<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" href="${path}/resources/css/header.css">

<nav class="navbar" id="tt_header">
	<a class="navbar-brand" href="${path }"> <img
		src="${path}/resources/images/logo.gif" alt="트투">
	</a>
	<ul class="navbar-menu" id="navbarMenu">
		<li><a href="${path}/funding/fundingList.do"><img class="menuImage"
				src="${path}/resources/images/travel1.png" alt="일반여행">
			<p>일반펀딩</p></a></li>
		<li><a href="#"><img class="menuImage"
				src="${path}/resources/images/travel2.png" alt="랜덤여행">
			<p>랜덤펀딩</p></a></li>
		<li><a href="#"><img class="menuImage"
				src="${path}/resources/images/review.png" alt="후기">
			<p>후기</p></a></li>
		<li><a href="#"><img class="menuImage"
				src="${path}/resources/images/manager.png" alt="관리자">
			<p>관리자</p></a></li>
		<li><a href="${path}/mypage/correction.do"><img class="menuImage"
				src="${path}/resources/images/mypage.png" alt="마이페이지">
			<p>마이페이지</p></a></li>
	</ul>
	<ul class="navbar-menu2" id="navbarMenu2">
		<li><c:if test="${member==null }">
				<a href="${path}/auth/login.do">login</a>
			</c:if> <c:if test="${member!=null }">
				<%-- <img src="${path}/resources/images/profile.png" alt="프로필이미지"
					class="profile_img"> --%>
				<div id="infoHeader">
					<div id="icons">
						<a href="${path}/chat" name="chat"><i
							class="far fa-comment-dots"></i></a> <a href="${path}/chat"
							name="chat"><i class="far fa-bell"></i></a>
					</div>
					<div id="loginInfo">
						<span>${member.nickname }님</span> <a href="${path}/auth/logout.do" id="logoutLink">logout</a>
					</div>
				</div>
				<link rel="stylesheet"
					href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
			</c:if></li>
	</ul>
</nav>
