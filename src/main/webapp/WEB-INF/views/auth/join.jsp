<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>회원가입</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<%@ include file="../common/header.jsp"%>
<style>
/* .container {
	border: solid 3px #0046FF;
	border-radius: 10px;
} */
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

/* .half-width {
	width: 50%; /* 너비를 50%로 설정 */
}
*
/
</style>
<script>
	$(function(){
		$("#btnDupCheck").on("click",f_dupCheck);
	})

	function f_dupCheck() {
		var memid = $("#login_id").val();
		if (memid == "") {
			alert("아이디를 입력하세요");
			document.querySelector("#login_id").focus();
			return;
		}
		$.ajax({
			url : "idCheck.do",
			data : {
				"login_id" : memid
			},
			type : "get",
			success : function(responseData) {
				var message = "";
				if (responseData == "0") {
					message = "사용가능";
				} else {
					message = "사용불가능";
					$("login_id").val("");
					document.querySelector("#login_id").focus();
				}
				$("#resultMessage").val(message);
			},
			error : function(data) {
				alert(data);
			}
		});
	}


</script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div class="mt-5 centered-container">
		<form action="${path }/auth/join.do" method="post">
			<table class="table table-bordered " style="text-align: center;">
				<thead>
					<tr>
						<th colspan="3">회원 가입</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><label for="login_id">아이디:</label></td>
						<td><input type="text" class="form-control" id="login_id"
							name="login_id"></td>
						<td>
							<button type="button" class="btn btn-primary" id="btnDupCheck">중복체크</button>
							<input type="text" value="중복확인 하세요" disabled id="resultMessage" >
						</td>
					</tr>
					<tr>
						<td><label for="login_pwd">패스워드:</label></td>
						<td colspan="2"><input type="password" class="form-control"
							id="login_pwd" name="login_pwd"></td>
					</tr>
					<tr>
						<td><label for="username">이름:</label></td>
						<td colspan="2"><input type="text" class="form-control"
							id="username" name="username"></td>
					</tr>
					<tr>
						<td><label for="nickname">닉네임:</label></td>
						<td colspan="2"><input type="text" class="form-control"
							id="nickname" name="nickname"></td>
					</tr>
					<tr>
						<td><label for="phone">연락처:</label></td>
						<td colspan="2"><input type="text" class="form-control"
							id="phone" name="phone"></td>
					</tr>
					<tr>
						<td><label for="email">이메일:</label></td>
						<td colspan="2"><input type="email" class="form-control"
							id="email" name="email"></td>
					</tr>
					<tr>
						<td>본인인증:</td>
						<td>
							<button type="button" class="btn btn-primary" id="auth-Check-Btn">본인인증</button>
						</td>
						<td><input class="form-control mail-check-input"
							placeholder="인증번호 입력" disabled="disabled" maxlength="6">
						</td>
					</tr>
					<tr>
						<td><label for="gender">성별:</label></td>
						<td colspan="2"><input type="radio" id="male" name="gender"
							value="0"><label for="male">남성</label> <input
							type="radio" id="female" name="gender" value="1"><label
							for="female">여성</label></td>
					</tr>
					<tr>
						<td><label for="birth">생년월일 8자리:</label></td>
						<td colspan="2"><input type="text" class="form-control"
							id="birth" name="birth"></td>
					</tr>
					<tr>
						<td colspan="3">
							<button type="submit" class="btn btn-primary">가입</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<div class="centered-container">
		<img src="/travel/resources/images/sh_character_02.png" alt="신한캐릭터2">
	</div>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>