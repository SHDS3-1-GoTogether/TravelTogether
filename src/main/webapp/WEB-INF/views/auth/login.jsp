<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>로그인</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<%@ include file="../common/header.jsp"%>

<style>
.container {
	border: solid 3px #0046FF;
	border-radius: 10px;
}

.centered-container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 60vh; /* 전체 높이로 가운데 정렬을 위한 높이 설정 */
}

.centered-container img {
	max-width: 100%; /* 이미지가 부모의 크기를 넘지 않도록 설정 */
	height: auto; /* 이미지의 비율을 유지 */
}

.half-width {
	width: 50%; /* 너비를 50%로 설정 */
}

</style>
</head>
<body>
	<div class="container mt-5 half-width centered-container2">
		<h2>${loginResult }</h2>
		<form action="${path }/auth/login.do" method="post">
			<div class="mb-3 mt-3">
				<label for="login_id">LOGIN_ID:</label> <input type="text"
					class="form-control " id="login_id" name="login_id">
			</div>
			<div class="mb-3">
				<label for="login_pwd">PASSWORD:</label> <input type="password"
					class="form-control " id="login_pwd" name="login_pwd">
			</div>
			<div class="form-check mb-3">
				<label class="form-check-label"> <input
					class="form-check-input" type="checkbox" id="remember">
					Remember me
				</label>
			</div>
			<button type="submit" class="btn btn-primary mb-3">로그인하기</button>
		</form>
	</div>
	<div class="centered-container">
		<img src="/travel/resources/images/sh_character_01.png" alt="신한캐릭터1">
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		$(function() {
			$("form").on("submit", f);
			$("#login_id").val(localStorage.getItem("login_id"));
			$("#login_pwd").val(localStorage.getItem("login_pwd"));
			var checkStatus = localStorage.getItem("checkStatus");
			if (checkStatus == 1) {
				$("#remember").prop("checked", true);
			}
		});
		function f() {
			var check = $("#remember").prop("checked");
			if (check) {
				localStorage.setItem("login_id", $("#login_id").val());
				localStorage.setItem("login_pwd", $("#login_pwd").val());
				localStorage.setItem("checkStatus", 1);
			} else {
				localStorage.removeItem("login_id");
				localStorage.removeItem("login_pwd");
				localStorage.removeItem("checkStatus");
			}
		}
	</script>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>