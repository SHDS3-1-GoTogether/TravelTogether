<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<%@ include file="../common/header.jsp"%>
<link rel="stylesheet" href="${path}/resources/css/join.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="${path}/resources/js/join.js"></script>

</head>
<body>
	<div class="container">
		<h2>회원 가입</h2>
		<form action="${path}/auth/join.do" method="post"
			id="registrationForm">
			<div class="form-group">
				<label for="login_id">아이디:</label> <input type="text" id="login_id"
					name="login_id">
				<button type="button" id="btnDupCheck">중복체크</button>
				<input type="text" value="중복확인 하세요" disabled id="resultMessage">
			</div>
			<div class="form-group">
				<label for="login_pwd">패스워드:</label> <input type="password"
					id="login_pwd" name="login_pwd">
			</div>
			<div class="form-group">
				<label for="username">이름:</label> <input type="text" id="username"
					name="username">
			</div>
			<div class="form-group">
				<label for="nickname">닉네임:</label> <input type="text" id="nickname"
					name="nickname">
			</div>
			<div class="form-group">
				<label for="phone">연락처:</label> <input type="text" id="phone"
					name="phone">
			</div>
			<div class="form-group">
				<label for="email">이메일:</label> <input type="email" id="email"
					name="email">
				<button type="button" id="sendEmail">인증코드 발송</button>
			</div>
			<div class="form-group">
				<label>본인인증:</label> <input placeholder="인증번호 입력" maxlength="6"
					id="emailCode" name="emailCode" disabled>
				<button type="button" id="checkEmail">인증확인</button>
			</div>
			<div>
				<label for="gender">성별:</label> <input type="radio" id="male"
					name="gender" value="0"><label for="male">남성</label> <input
					type="radio" id="female" name="gender" value="1"><label
					for="female">여성</label>
			</div>
			<div>
				<label for="birth">생년월일:</label> <input type="date" id="birth"
					name="birth">
			</div>
			<div class="form-group">
				<input type="button" id="submit" value="가입" onclick="call()">
			</div>
		</form>
	</div>
	<div class="character-img">
		<img src="${path}/resources/images/sh_character_02.png" alt="신한캐릭터2">
	</div>
	<%@ include file="../common/footer.jsp"%>
	<script>
	 
		 function call() {
			var formData = $("#registrationForm").serialize();
			console.log(formData);
			$.ajax({
				url: "${path}/auth/join.do",
				type: "post",
				data: formData,
				success:function(data) {
					if(data=="1") {
						swal(
							'회원가입 성공',
							'회원가입에 성공하였습니다.',
							'success'
						).then(function() {
							location.href="${path}/auth/login.do";
						});
					} else {
						swal(
							'회원가입 실패',
							'회원가입에 실패했습니다.',
							'error'
						).then(function() {
							location.href="${path}/auth/join.do";
						});
					}
				}
			});
		} 
	 
	</script>
</body>
</html>
