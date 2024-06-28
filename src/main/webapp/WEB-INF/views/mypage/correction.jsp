<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${path}/resources/css/userCouponList.css" rel="stylesheet">
<link href="${path}/resources/css/mypageMenu.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(function() {
		// 현재 페이지의 URL 가져오기
		var currentUrl = window.location.href;
		$(".menu-link").removeClass("highlight");

		// URL에 "correction"이 포함되어 있는지 확인
		if (currentUrl.includes("correction")) {
			// "회원정보 수정" 링크의 폰트 스타일 변경
			$("#correction-link").addClass("highlight");
		}
		
		$("#correction").on("click", f_correction);
	});

	function f_correction() {
	    var memid = $("#login_id2").val();
	    if (memid == "") {
	        alert("아이디를 입력하세요");
	        document.querySelector("#login_id").focus();
	        return;
	    }
	    var mempwd = $("#login_pwd2").val();
	    if (mempwd == "") {
	        alert("비밀번호를 입력하세요");
	        document.querySelector("#login_pwd").focus();
	        return;
	    }
	    $.ajax({
	        url: "correctionForm.do",
	        type: "get",
	        data: {
	            login_id: memid,
	            login_pwd: mempwd
	        },
	        success: function(responseData) {
	            if (responseData == "1") {
	            	$("#correctionForm").show();
	            	$("#loginForm").hide();	            	
	            }
	        },
	        error: function(data) {
	            alert("오류: " + data);
	        }
	    });
	}
</script>
<style>
#correctionForm{
	display: none;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="mypage-header">
		<h2>마이페이지</h2>
	</div>
	<div class="container">
		<%@ include file="./mypageMenu.jsp"%>
		<div class="mypage-coupon-content">
			<h3>
				<i class="fas fa-user"></i> 정보수정
			</h3>
			<div class="coupon-content-wrap">
			<div id="correctionForm">
				<%@include file="correctionForm.jsp"%>
			</div>
				<form action="${path}/mypage/correction.do" method="post" id="loginForm">
					<div class="form-group">
						<label for="login_id">LOGIN ID</label> <input type="text"
							class="form-control" id="login_id2" name="login_id">
					</div>
					<div class="form-group">
						<label for="login_pwd">PASSWORD</label> <input type="password"
							id="login_pwd2" name="login_pwd" class="form-control">
					</div>
					<div class="form-group">
						<button type="button" id="correction">수정하기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>