<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" href="${path}/resources/css/header.css">

<%-- <link rel="icon" href="${path}/resources/images/logo.gif"> --%>
<nav class="navbar" id="tt_header">
	<a class="navbar-brand" href="${path }"> <img
		src="${path}/resources/images/logo.gif" alt="트투" >
	</a>
	<ul class="navbar-menu" id="navbarMenu">
		<li><a href="#">일반펀딩</a></li>
		<li><a href="#">랜덤펀딩</a></li>
		<li><a href="#">후기</a></li>
		<li><a href="#">관리자</a></li>
	</ul>
	<ul class="navbar-menu2" id="navbarMenu2">
		<li>
			<c:if test="${member==null }">
   				<a href="${path}/auth/login.do">로그인</a>
			</c:if> 
			<c:if test="${member!=null }">
				<img src="${path}/resources/images/profile.png" alt="프로필이미지" class="profile_img">
   				<span>${member.nickname}님</span>
   				<a href="${path}/auth/logout.do">로그아웃</a>
			</c:if>
		</li>
	</ul>
</nav>
