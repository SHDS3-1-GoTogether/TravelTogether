<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	session="false"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결제 예약</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f5f5f5;
}

.container {
	width: 40%;
	margin: 0 auto;
	background-color: #fff;
	padding: 20px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

header, footer {
	margin-left: -20px; /* 좌측 패딩 상쇄 */
	margin-right: -20px; /* 우측 패딩 상쇄 */
	margin-top: -20px; /* 상단 패딩 상쇄 */
	margin-bottom: -20px; /* 하단 패딩 상쇄 */
	padding-left: 20px; /* 내부 패딩 추가 */
	padding-right: 20px; /* 내부 패딩 추가 */
	padding-top: 20px; /* 내부 패딩 추가 */
	padding-bottom: 20px; /* 내부 패딩 추가 */
}

.logo img {
	width: 100px;
}

nav a {
	margin-right: 20px;
	text-decoration: none;
	color: #333;
}

h1 {
	text-align: left;
	margin-bottom: 20px;
	margin-left: 10px;
	text-decoration: underline; /* 텍스트에 밑줄을 추가합니다 */
	text-decoration-thickness: 1px; /* 밑줄의 두께를 설정합니다 */
	text-underline-offset: 10px; /* 밑줄과 텍스트 사이의 거리를 설정합니다 */
}

h2 {
	margin-left: 20px;
}

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

.progress {
	display: flex;
	justify-content: left;
	align-items: center;
	margin-bottom: 20px;
}

.progress-step {
	width: 100px;
	height: 100px;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 10px;
	border: 2px dashed #000; /* 점선 테두리 추가 */
}

.progress-step.active {
	background-color: #007bff;
	color: #fff;
	border: 2px solid #000; /* 점선 테두리 추가 */
}

.arrow {
	font-size: 3em;
	margin: 0 30px;
}

.payment-info {
	padding: 20px;
	margin-bottom: 20px;
}

.payment-info .detail {
	border-bottom: 1px solid #ccc; /* 밝은 회색의 1픽셀 밑줄 추가 */
	padding-bottom: 10px; /* 밑줄과 텍스트 사이에 간격을 추가 */
	margin-bottom: 20px; /* 다음 요소와의 간격을 추가 */
}

.payment-details .detail {
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;
	margin: 20px 0;
}

.total-amount {
	display: flex;
	justify-content: space-between;
	font-size: 25px;
	font-weight: bold;
	margin-top: 20px;
}

.payment-method {
	padding: 20px;
	margin-bottom: 20px;
	font-weight: bold;
	font-size: 20px;
}

.payment-method img {
	width: 70px; /* 예시로 너비를 100픽셀로 설정 */
	height: auto; /* 높이를 자동으로 조절하여 비율 유지 */
}

.payment-method span {
	display: block;
	margin-bottom: 10px;
	font-weight: bold;
}

.payment-method label {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
	padding-bottom: 10px; /* 밑줄과 요소 사이의 간격을 주기 위해 패딩 추가 */
	border-bottom: 1px solid #ccc; /* 밑줄 추가 */
}

.new {
	background: red;
	color: white;
	padding: 2px 6px;
	font-size: 12px;
	margin-left: 10px;
}

.payment-method input {
	margin-right: 10px;
}

.payment-warning, .agreement {
	border: 1px solid #e0e0e0;
	border-radius: 20px;
	padding: 20px;
	margin-bottom: 20px;
}

.payment-warning img {
	width: 25px;
	height: auto;
	margin-right: 10px;
}

.payment-warning label, .agreement label {
	display: flex;
	align-items: center;
	margin-bottom: 5px;
}

.payment-warning input[type="checkbox"], .agreement input[type="checkbox"]
	{
	margin-right: 10px;
}

.agreement label {
	display: flex; /* Flexbox 사용 */
	align-items: bottom; /* 요소들을 수직 중심으로 맞춤 */
	margin-bottom: 10px; /* 다른 요소와의 간격 */
}

.agreement input[type="checkbox"] {
	margin-right: 10px; /* 체크박스와 텍스트 사이의 간격 */
}

.payment-warning span, .agreement span {
	display: block;
	margin-bottom: 10px;
	font-weight: bold;
}

.payment-warning ul, .agreement ul {
	padding-left: 20px;
}

footer {
	text-align: center;
	font-size: 0.9em;
	color: #747579;
	background-color: #68A6F3;
}

.footer-info span {
	display: block;
	margin-bottom: 5px;
	width: 100%;
}

.btn-submit {
	display: block;
	width: 80%;
	padding: 15px;
	background-color: #007bff;
	color: #fff;
	text-align: center;
	text-decoration: none;
	border-radius: 5px;
	font-size: 1.2em;
	font-weight: bold;
	margin: 20px auto 50px; /* 상단 마진 20px, 좌우 자동, 하단 0 */
}

.reward-selection {
	display: flex;
	justify-content: center; /* 중앙 정렬 */
	padding: 20px;
}

.reward-card {
	display: flex;
	flex-direction: column;
	background-color: #fff;
	padding: 20px; /* 상, 좌, 우, 하 패딩 추가 */
	padding-bottom: 0; /* 하단 패딩은 제거 */
	border-radius: 15px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	width: 100%;
	overflow: hidden; /* 넘치는 내용 숨기기 */
}

.reward-details {
	text-align: left; /* 모든 텍스트를 왼쪽으로 정렬 */
	padding: 10px; /* 패딩을 추가하여 디자인에 여유를 줌 */
}

.reward-image {
	width: 100%; /* 이미지 너비 컨테이너에 맞춤 */
	height: auto; /* 이미지 높이 자동 조절 */
	margin-top: 20px; /* 이미지와 컨테이너 상단 사이의 공간 추가 */
}

.reward-price {
	display: flex;
	align-items: center; /* 체크박스와 라벨을 수직 중심에 맞춤 */
	font-size: 24px; /* 글꼴 크기 증가 */
	padding: 10px 20px; /* 상하, 좌우 패딩 추가 */
	border-radius: 5px; /* 모서리 둥글게 */
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 상자 그림자 추가 */
}

.reward-price input[type="checkbox"] {
	width: 24px; /* 체크박스 너비 조정 */
	height: 24px; /* 체크박스 높이 조정 */
	cursor: pointer; /* 마우스를 올렸을 때 포인터로 변경 */
	margin-right: 10px; /* 라벨과의 거리 조정 */
	vertical-align: middle; /* 수직 중심 정렬 */
}

.participant-info {
	display: flex;
	justify-content: flex-start; /* 항목들을 컨테이너 왼쪽에 배치 */
	align-items: center; /* 수직 중심 정렬 */
	width: 100%; /* 전체 너비 사용 */
}

.participant-info p {
	margin-right: 20px; /* 각 항목 사이의 오른쪽 마진 추가 */
	margin-bottom: 0; /* p 태그 아래 마진 제거 */
}

.donation-section {
    display: flex;
    flex-direction: column; /* 요소들을 수직으로 정렬 */
    align-items: flex-start; /* 좌측 정렬 */
    padding: 10px;
}

.donation-section label {
    margin-bottom: 10px; /* label 아래 여유 공간 추가 */
}
.input-container {
    display: flex;
    align-items: center; /* 입력 필드와 텍스트를 수직 중심으로 정렬 */
}
.input-container input[type="number"] {
    width: 100px; /* 입력 필드 너비 */
    height: 30px; /* 입력 필드 높이 */
    margin-right: 5px; /* 입력 필드와 텍스트 사이 간격 */
    text-align: right;
    border-radius: 30px;
}

.donation-section h3 {
    margin-bottom: 5px; /* h3 아래 간격 */
}

.proceed-button {
	width: 100%;
	padding: 10px;
	background-color: #007bff;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	
	
</script>

</head>
<body>
	<div class="container">
		<header>
			<div class="logo">
				<img src="logo.png" alt="로고">
			</div>
			<nav>
				<a href="#">일반팬딩</a> <a href="#">팬딩단팅</a> <a href="#">후기</a>
			</nav>
		</header>
		<main>
			<h1>리워드 선택</h1>
			<div class="travel-info">
				<span>제주도 여행 가고싶당 [신청자 : 김주현]</span> `
			</div>

			<div class="progress">
				<div class="progress-step active">리워드 선택</div>
				<div class="arrow">→</div>
				<div class="progress-step">결제 예약</div>
			</div>
			<br>
			<hr>

			<h2>리워드 확인</h2>


			<div class="reward-selection">

				<div class="reward-card">
					<div class="reward-price">
						<input type="checkbox" id="rewardSelect" name="rewardSelect">
						<label for="rewardSelect">₩160,000</label>
					</div>
					<img src="resources/images/jeju.jpg" alt="제주도 여행" class="reward-image">
					<div class="reward-details">
						<p>#제주도 #여행 #인생샷 #휴식 #힐링</p>
						<h2>제주도 여행갈 사람 모여라!!</h2>
						<div class="participant-info">
							<p>제한인원: 5</p>
							<p>잔여인원: 2</p>
						</div>
					</div>
				</div>
			</div>
			<hr>
			<div class="donation-section">
				<label for="additional-donation">
					<h3>후원금 더하기(선택)</h3> 후원금을 더하여 참여할 수 있습니다. 추가 후원금을 입력하시겠습니까?
				</label>
				<div class="input-container">
					<input type="number" id="additional-donation" placeholder="0">
					원을 추가로 후원합니다.
				</div>
			</div>


			<a href="payment.do" class="btn-submit" id="paymentButton">다음으로</a>
		</main>

		<footer>
			<div class="footer-info">
				<span>회사명(주) 가가가</span> <span>주소: 서울특별시 서초구 서초대로 320, 20층
					(BNK디지털타워)</span> <span>대표: 홍길동</span> <span>사업자등록번호: 012-12-12345</span>
				<span>통신판매업 신고번호: 서울서초-01234</span> <span>대표번호: 02-3456-7890</span>
				<span>이메일: support_funding@backpack.kr</span> <span>© 2024
					Backpack Inc.</span>
			</div>
		</footer>
	</div>
</body>
</html>