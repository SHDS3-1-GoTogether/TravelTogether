 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<link rel="stylesheet" href="${path}/resources/css/fundingBase.css">
<link rel="stylesheet" href="${path}/resources/css/fundingInput.css">

<script src="${path}/resources/js/fundingInput.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>
	function addImg() {
		$("#extraImg").append("<div><input type='file' accept='image/*' name='extra_pics'><span onclick='removeImg(this)'>x</span></div>");
	}
	function addProvImg() {
		$("#provImg").append("<div><input type='file' accept='image/*' name='prov_pics'><span onclick='removeImg(this)'>x</span></div>");
	}
	function removeImg(id) {
		$(id).parent().remove();
	}
	
</script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<div class="content_wrapper">
		<h1 class="pageTitle">Funding Making</h1>
		<div class="form-wrapper">
		<div class="semi-title">펀딩 입력</div><br>
		<input type="hidden" id="inputSelector" value=1>
		<div class="form-left-wrapper">
			<div id="input1" class="inputArr">
				<%@ include file="fundingOption1.jsp" %>					
			</div>
			<div id="input2" class="inputArr">
				<%@ include file="fundingOption2.jsp" %>						
			</div>
			<div id="input3" class="inputArr">
				<%@ include file="fundingOption3.jsp" %>						
			</div>
			<div id="input4" class="inputArr">
				<%@ include file="fundingOption4.jsp" %>
			</div>
			<div id="input5" class="inputArr">
				<%@ include file="fundingOption5.jsp" %>
			</div>
		</div>
		<div class="option_wrapper">
			<p class="option-title">옵션내역</p>
			<ul class="option-li-wrapper">
				<li>여행일정</li>
				<li>여행지</li>
				<li>인원</li>
				<li>숙소</li>
				<li>교통</li>
				<li>예산</li>
				<li>테마</li>
				<li>펀딩마감일</li>
			</ul>			
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>

</body>
</html>