	var check1 = 0;
	var check2 = 0;

	function validateForm() {
		var loginId = document.getElementById("login_id").value;
		var loginPwd = document.getElementById("login_pwd").value;
		var username = document.getElementById("username").value;
		var nickname = document.getElementById("nickname").value;
		var phone = document.getElementById("phone").value;
		var email = document.getElementById("email").value;
		var emailCode = document.getElementById("emailCode").value;
		var male = document.getElementById("male").checked;
		var female = document.getElementById("female").checked;
		var birth = document.getElementById("birth").value;

		if (check1 == 0) {
			alert("아이디 중복체크 하세요");
			event.preventDefault();
			return false;
		} else if (check2 == 0) {
			alert("이메일 인증하세요");
			event.preventDefault();
			return false;
		}

		if (!loginId) {
			alert("아이디를 입력하세요.");
			event.preventDefault();
			return false;
		}
		if (!loginPwd) {
			alert("패스워드를 입력하세요.");
			event.preventDefault();
			return false;
		}
		if (!username) {
			alert("이름을 입력하세요.");
			event.preventDefault();
			return false;
		}
		if (!nickname) {
			alert("닉네임을 입력하세요.");
			event.preventDefault();
			return false;
		}
		if (!phone) {
			alert("연락처를 입력하세요.");
			event.preventDefault();
			return false;
		}
		if (!email) {
			alert("이메일을 입력하세요.");
			event.preventDefault();
			return false;
		}
		if (!emailCode) {
			alert("인증번호를 입력하세요.");
			event.preventDefault();
			return false;
		}
		if (!male && !female) {
			alert("성별을 선택하세요.");
			event.preventDefault();
			return false;
		}
		if (!birth) {
			alert("생년월일을 입력하세요.");
			event.preventDefault();
			return false;
		}

		return true;
	}

	window.onload = function() {
		document.getElementById("registrationForm").onsubmit = validateForm;
	};

	$(function() {
		$("#btnDupCheck").on("click", f_dupCheck);
		$("#sendEmail").on("click", emailSend);
		$("#checkEmail").on("click", emailCheck);
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
					check1 = 1;
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

	function emailSend() {
		var email = $("#email").val();
		if (email == "") {
			alert("이메일을 입력하세요");
			document.querySelector("#email").focus();
			return;
		}
		$('#emailCode').removeAttr("disabled");
		$.ajax({
			url : "sendMail.do",
			data : {
				"email" : email
			},
			type : "get",
			success : function(responseData, status, xhr) {
				alert("Mail sent successfully!");
				console.log(responseData);
				console.log(xhr);
				console.log(status);
			},
			error : function(data) {
				alert(data);
			}
		});
	}

	function emailCheck() {
		var emailCode = $("#emailCode").val();
		console.log(emailCode);
		if (emailCode == "") {
			alert("코드를 입력하세요");
			document.querySelector("#emailCode").focus();
			return;
		}
		$.ajax({
			url : "checkMail.do",
			data : {
				"emailCode" : emailCode
			},
			type : "get",
			success : function(responseData) {
				var message = "";
				if (responseData == "0") {
					message = "인증오류";
				} else {
					message = "인증완료";
					check2 = 1;
				}
				$('#emailCode').val(message);
			},
			error : function(data) {
				alert(data);
			}
		});
	}