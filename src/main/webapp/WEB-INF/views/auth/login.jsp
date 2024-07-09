<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>로그인</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../common/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/login.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${path}/resources/js/login.js"></script>
</head>
<body>

	<div class="container">
		<h2>${loginResult }</h2>
		<form action="${path}/auth/login.do" method="post">
			<img src="${path}/resources/images/sh_character_01.png" alt="신한캐릭터1">
			<div class="form-group">
				<label for="login_id">LOGIN ID</label> <input type="text"
					class="form-control" id="login_id" name="login_id">
			</div>
			<div class="form-group">
				<label for="login_pwd">PASSWORD</label> <input type="password"
					id="login_pwd" name="login_pwd" class="form-control">
			</div>
			<div class="form-group">
				<label> <input type="checkbox" id="remember">
					Remember me
				</label>
			</div>
			<div class="form-group">
				<button type="submit">로그인하기</button>
			</div>
		</form>
		<div class="text-center">
			<a href="${path}/auth/join.do">회원가입</a>
		</div>
	</div>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>
