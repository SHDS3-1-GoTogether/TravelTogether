<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${path}/resources/css/correctionForm.css" rel="stylesheet">
</head>
<body>
	<form action="${path}/mypage/correction.do" method="post" id="registrationForm">
		<div class="form-group">
			<label for="member_id">회원코드:</label> <input type="text" id="member_id"
				name="member_id" value=${member.member_id } readonly>
		</div>
		<div class="form-group">
			<label for="membership_id">회원등급:</label> <input type="text" id="membership_id"
				name="membership_id" value=${member.membership_id } readonly>
		</div>
		<div class="form-group">
			<label for="login_id">아이디:</label> <input type="text" id="login_id"
				name="login_id" value=${member.login_id } readonly>
		</div>
		<div class="form-group">
			<label for="login_pwd">패스워드:</label> <input type="password"
				id="login_pwd" name="login_pwd" value=${member.login_pwd }>
		</div>
		<div class="form-group">
			<label for="username">이름:</label> <input type="text" id="username"
				name="username" value=${member.username } readonly>
		</div>
		<div class="form-group">
			<label for="nickname">닉네임:</label> <input type="text" id="nickname"
				name="nickname" value=${member.nickname }>
		</div>
		<div class="form-group">
			<label for="phone">연락처:</label> <input type="text" id="phone"
				name="phone" value=${member.phone }>
		</div>
		<div class="form-group">
			<label for="email">이메일:</label> <input type="email" id="email"
				name="email" value=${member.email } readonly>
		</div>
		<div>
			<label for="gender">성별:</label> <input type="radio" id="male"
				name="gender" value="0" <c:if test="${member.gender == 0}">checked</c:if> disabled><label for="male">남성</label> <input
				type="radio" id="female" name="gender" value="1" <c:if test="${member.gender == 1}">checked</c:if> disabled><label
				for="female">여성</label>
		</div>
		<div>
			<label for="birth">생년월일:</label> <input type="date" id="birth"
				name="birth" value=${member.birth } readonly>
		</div>
		<div class="form-group">
			<button type="submit">수정</button>
		</div>
	</form>
</body>
</html>