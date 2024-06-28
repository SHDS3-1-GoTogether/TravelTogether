
		$(function() {
			$("form").on("submit", rememberIdPwd);
			$("#login_id").val(localStorage.getItem("login_id"));
			$("#login_pwd").val(localStorage.getItem("login_pwd"));
			var checkStatus = localStorage.getItem("checkStatus");
			if (checkStatus == 1) {
				$("#remember").prop("checked", true);
			}
		});

		function rememberIdPwd() {
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