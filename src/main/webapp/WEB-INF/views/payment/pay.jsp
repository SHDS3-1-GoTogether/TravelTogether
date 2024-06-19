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
	width: 60%;
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
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document).ready(
			function() {
				$("#paymentButton").click(
						function() {
							// 약관동의 확인
							var isAgreementChecked = $(
									'input[name="payagreement"]')
									.is(':checked');
							// 결제 수단 선택
							var selectedPayment = $(
									'input[name="payment"]:checked').val();
							//var testMoney = $("#testMoney").val();

							//test
							alert(selectedPayment);

							if (!isAgreementChecked) {
								alert("약관에 동의해야 합니다.");
								return;
							}

							$.ajax({
								url : '/travel/process' + selectedPayment
										+ '.do', // 서버에서 처리할 URL
								dataType : 'json',

								/* type: 'POST', */
								/*
								data: {
								    testMoney: testMoney
								}, */
								success : function(response) {
									var box = response.next_redirect_pc_url;
									//alert('서버 응답: ' + JSON.stringify(response, null, 2));
									// 결제 팝업창 생성(새로운 브라우저에 생성)
									window.open(box);
									// 현재 창에서 URL로 이동(현재 브라우저에 생성)
									//window.location.href = box;
								},
								error : function(xhr, status, error) {
									alert('에러 발생: ' + error);
								}
							});
						});
			});
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
			<h1>결제 예약</h1>
			<div class="travel-info">
				<span>제주도 여행 가고싶당 [신청자 : 김주현]</span> `
			</div>

			<div class="progress">
				<div class="progress-step">리워드 선택</div>
				<div class="arrow">→</div>
				<div class="progress-step active">결제 예약</div>
			</div>
			<hr>
			<div class="payment-info">
				<div class="payment-details">
					<div class="detail">
						<span>리워드 금액:</span> <span>320,000원</span>
					</div>
					<div class="detail">
						<span>추가 후원금:</span> <span>0원</span>
					</div>
					<div class="detail">
						<span>쿠폰사용:</span> <span>현재 사용 가능한 쿠폰이 없습니다.</span>
					</div>
				</div>
				<br> <br>
				<div class="total-amount detail">
					<span>총 결제 금액:</span> <span>320,000원</span>
				</div>
			</div>

			<div class="payment-method">
				<span>결제 선택</span> <label> <input type="radio" id="Kakaopay"
					value="Kakaopay" name="payment" checked> <img
					src="resources/img/kakaopay.png" alt="Kakao Pay"><span
					class="new">NEW</span>
				</label> <label> <input type="radio" id="Npay" value="Npay"
					name="payment"> <img src="resources/img/naverpay.png"
					alt="N Pay"><span class="new">NEW</span>
				</label>
			</div>

			<div class="payment-warning">
				<label> <img src="resources/img/payment_warning.png"><span>결제
						유의사항</span>
				</label>
				<ul>
					<li>어쩌고 저쩌고</li>
					<li>저쩌고 어쩌고</li>
				</ul>
			</div>

			<div class="agreement">
				<label> <input type="checkbox" name="payagreement"><span>약관동의</span>
				</label>
				<ul>
					<li>어쩌고 저쩌고</li>
					<li>저쩌고 어쩌고</li>
				</ul>
			</div>
			<a href="#" class="btn-submit" id="paymentButton">결제하기</a>
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