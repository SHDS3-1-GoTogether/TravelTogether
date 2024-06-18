<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<style>
#tt_header {
	font-size: 30px;
	font-family: "Nanum Gothic", sans-serif;
	font-weight: 400;
	font-style: normal;
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.navbar-menu, .navbar-menu2 {
	list-style: none;
	padding: 0;
	margin: 0;
	display: flex;
	align-items: center;
}

.navbar-menu li, .navbar-menu2 li {
	margin-right: 20px;
}

.navbar-menu li a, .navbar-menu2 li a {
	text-decoration: none;
	color: inherit;
}

.navbar-brand img {
	height: 100px;
	width: 100px;
}

.profile_img {
	height: 50px;
	width: 50px;
	border-radius: 50%;
}
</style>

<link rel="icon" href="/travel/resources/images/logo.png">
<nav class="navbar" id="tt_header">
	<ul class="navbar-menu" id="navbarMenu">
		<li><a class="navbar-brand" href="${path }"> <img
				src="/travel/resources/images/logo.png" alt="트투" height="200"
				width="200">
		</a></li>
		<li><a href="#">일반펀딩</a></li>
		<li><a href="#">랜덤펀딩</a></li>
		<li><a href="#">후기</a></li>
		<li><a href="#">관리자</a></li>
	</ul>
	<ul class="navbar-menu2" id="navbarMenu2">
		<li><img src="/travel/resources/images/profile.png" alt="프로필이미지"
			class="profile_img"></li>
		<li><c:if test="${member==null }">Guest
   <a href="${path }/auth/login.do">로그인</a>
   <a href="${path }/auth/join.do">회원가입</a>
			</c:if> <c:if test="${member!=null }">${member.nickname }님
   <a href="${path }/auth/logout.do">로그아웃</a>
			</c:if></li>
	</ul>
</nav>
<hr>