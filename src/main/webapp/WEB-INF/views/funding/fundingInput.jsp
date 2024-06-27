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
<link rel="stylesheet" href="${path}/resources/css/fundingMake.css">
<script src="${path}/resources/js/fundingInput.js"></script>

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
		
<%-- 			<form action="fundingInput.do" method="post" enctype="multipart/form-data" >
				<div class="form-top-wrapper">
				<span class="form-left-wrapper">
					<span>제목 : <input type="text" name="title" ></span> <br>
					<span>지역 : <input type="text" name="area"></span><br>
					<span>출발일 : <input type="date" name="start_date"></span><br>
					<span>숙소 : <input type="text" name="accommodation">
					<input type="radio" value="complete" name="isBook">예약완료</span><br>
					<span>펀딩마감일 : <input type="date" name="deadline"> </span><br>
					<span>인원수  : <input type="number" name="people_num"></span><br>
				</span>
				<span class="form-right-wrapper">
					<span>총 예산 : <input type="number" name="price"></span><br>
					<span>
						테마 :
						<c:forEach items="${theme}" var="theme">
							<input type="checkbox" name="theme" value="${theme.theme_id}">${theme.title}
						</c:forEach>
					</span>
					<span>도착일 : <input type="date" name="end_date"> </span><br>
					<span>출발지 : 
					<input type="radio" value="together" name="traffic_option">따로출발
					<input type="radio" value="solo" name="traffic_option">같이출발
					<input type="text" name="departure"></span><br>
					<span>교통 : <input type="text" name="traffic"></span>
				</span>
					
		
				</div>

				<input type="text" name="funding_content"> <br>
			
				증명용 사진:
				<div id="provImg">
					<input  type="file" accept="image/*" name="prov_pics"> <br>
				</div>
				<input type="button" onclick="addProvImg()" value="추가"><br>
				
				대표 사진:
				<input type="file" accept="image/*" name="main_pic"> <br>
				추가 사진 :
				<div id="extraImg">
					<input  type="file" accept="image/*" name="extra_pics"> <br>
				</div>
				<input type="button" onclick="addImg()" value="추가"><br>
			
				<input type="submit" value="입력">
		</form> --%>
		</div>

			
	</div>

	
	<%@ include file="../common/footer.jsp" %>

</body>
</html>