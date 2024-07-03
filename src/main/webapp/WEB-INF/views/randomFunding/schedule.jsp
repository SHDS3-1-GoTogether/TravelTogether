<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${path}/resources/css/fundingBase.css">
<title>Insert title here</title>

<style type="text/css">
.travel-info {
	border: 1px solid #e0e0e0;
	border-radius: 20px;
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 30px;
	height: 60px;
	font-size: 18px;
	padding-left: 20px;
	box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.1), /* 내부 그림자 */
                0 2px 4px rgba(0, 0, 0, 0.1); /* 외부 그림자 */
}
h1 {
    text-align: left;
    font-size: 2.5em; /* 글자 크기 조절 */
    color: rgba(0, 0, 0, 0.7);
    font-weight: bold; /* 글자 두께 */
    margin-bottom: 20px; /* 아래 여백 추가 */
    font-family: 'Arial', sans-serif; /* 글꼴 변경 */
    padding-left: 20px; /* 왼쪽 여백 추가 */
    border-left: 5px solid hsla(237, 74%, 33%, 0.61); /* 왼쪽 테두리 추가 */
}
.progress {
	display: flex;
	justify-content: left;
	align-items: center;
	margin-bottom: 20px;
}

.progress-container {
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
}

.progress-step {
	width: 100px;
	height: 110px;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 40px;
	border: 2px dashed #000;
	transition: all 0.3s ease;
	background-color: #f0f0f0;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.progress-step.active {
	background-color: #007bff;
	color: #fff;
	border: 2px solid #007bff;
	box-shadow: 0 0 20px rgba(0, 123, 255, 0.5);
	transform: scale(1.1);
}

.arrow {
	font-size: 3em;
	margin: 0 30px;
}

.top_hr {
	position: relative;
	width: 95%;
	margin-bottom: 2%;
}

.container_date {
	width: 80%;
	margin: 50px auto;
	border: 1px solid #000; /* 테두리 색을 검정색으로 변경 */
	border-radius: 15px; /* 테두리 둥글게 변경 */
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	margin: 50px auto;
}

.container_date h3 {
	text-align: left;
	font-size: 20px;
	color: #666;
	margin-bottom: 25px;
	margin-top: 10px;
}

.container_img {
	background-color: #FBFADD;
	width: 80%;
	margin: 50px auto;
	border: 1px solid #000; /* 테두리 색을 검정색으로 변경 */
	border-radius: 15px; /* 테두리 둥글게 변경 */
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	display: flex;
	justify-content: center; /* 이미지 가운데 정렬 */
	align-items: center;
}

.container_img img {
	width: 300px;
	height: auto;
	max-width: 80%;
	padding: 0;
	border-radius: 10px;
	max-width: 80%;
	padding: 0;
}

.input-group {
	flex: 1;
	display: flex;
	justify-content: center; /* 요소들을 가운데로 모음 */
	align-items: center;
	margin-bottom: 20px;
}

.input-group-inner {
	width: 60%; /* 부모 요소의 60%를 차지하도록 설정 */
	display: flex;
	justify-content: space-between; /* 내부 요소들을 간격을 두고 배치 */
	align-items: center;
}

.input-group label {
	font-size: 18px;
	margin-right: 10%; /* label과 input 사이의 거리를 줄임 */
	width: 100px; /* width를 auto로 설정하여 더 유연하게 만듦 */
	text-align: right; /* label을 오른쪽 정렬 */
}

.input-group input {
	width: 100%;
	padding: 10px;
	font-size: 16px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
	text-align: center; /* 입력 필드를 가운데 정렬 */
}

.container_date button {
	display: block;
	margin-right: 0; /* 오른쪽 여백을 제거 */
}

.button-group {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 30px;
	width: 100%;
}

.prev-button {
	justify-self: flex-start;
}

.next-button {
	justify-self: flex-end;
}

.button {
	display: block;
	width: 25%;
	padding: 10px;
	font-size: 18px;
	color: white;
	background-color: #007bff;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	text-align: center;
	font-weight: bold;
	margin-top: 30px;
}

.button:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="content_wrapper">
		<h1>랜덤 펀딩</h1>
		<div class="progress progress-container">
			<div class="progress-step active">일정 선택</div>
			<div class="arrow">→</div>
			<div class="progress-step">금액 선택</div>
			<div class="arrow">→</div>
			<div class="progress-step">테마 선택</div>
		</div>

		<hr class="top_hr">

		<form action="${path}/randomFunding/amount.do" method="get">
			<div class="container_date">
				<h3>여행 가능한 기간을 선택해주세요 (시작일, 마감일)</h3>
				<div class="input-group">
					<div class="input-group-inner">
						<label for="departure">출발일</label> <input type="date"
							id="departure" name="departure">
					</div>
				</div>
				<div class="input-group">
					<div class="input-group-inner">
						<label for="arrival">도착일</label> <input type="date" id="arrival"
							name="arrival">
					</div>
				</div>
				<div class="button-group">
					<button type="button" class="button prev-button" 
						onclick="history.back()">이전으로</button>
					<button type="submit" class="button next-button">다음으로</button>
				</div>
			</div>
		</form>

		<%-- <div class="container_img" style="background-color: #FBFADD;">
			<img src="${path }/resources/images/randomFunding.png" alt="랜덤박스 이미지"/>
		</div> --%>
	</div>
	<%@ include file="../common/footer.jsp"%>
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			const form = document.querySelector('form');
			form.addEventListener('submit', function(event) {
				
				event.preventDefault(); // 폼 제출 막기@@@@@@
				
				const departure = document.getElementById('departure').value;
				const arrival = document.getElementById('arrival').value;
				
				if (!departure || !arrival) {
					event.preventDefault(); // 폼 제출 막기
					alert('출발일과 도착일을 모두 선택해주세요.');
					return;
				}
				
				$.ajax({
					url:`${path}/randomFunding/amount.do`,
					type:'POST',
					contentType:'application/json',
					data: JSON.stringify({ departure: departure, arrival:arrival}),
					success: function(response){
						if(response.status == 'fail'){
							alert(response.data);
						}else{
							window.location.href=`${path}/randomFunding/` + response.data +
												`?departure=` + departure + `&arrival=` + arrival;
						}
					},
					error: function(xhr, status, error){
						console.error('Error:', error);
		                console.log('서버 오류가 발생하였습니다.')
					}
				});

				
			});
		});
	</script>
</body>
</html>