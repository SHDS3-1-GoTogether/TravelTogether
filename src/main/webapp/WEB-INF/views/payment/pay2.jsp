<%@page import="java.util.ArrayList"%>
<%@page import="com.shinhan.travelTogether.coupon.UserCouponDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.shinhan.travelTogether.coupon.CouponService"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	session="false"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/payment.css" />
<title>결제 예약</title>
<script src="https://js.tosspayments.com/v1/payment-widget"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

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

					<!-- 쿠폰 콤보박스 -->
					<div class="detail">
						<span>쿠폰 선택:</span> <select id="coupon-box" class="coupon-box">
							<option value="0" disabled selected>쿠폰을 선택하세요</option>
							<option value="0">사용안함</option>
							<c:forEach var="coupon" items="${couponlist }">
								<option value="${coupon.discount_rate},${coupon.max_discount}">${coupon.title}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<br> <br>
				<div class="total-amount">
					<span>총 결제 금액:</span> <span id="changeAmount"></span>
				</div>
				<hr>
			</div>

			<!-- 주문서 영역 -->
			<div class="wrapper">
				<div class="box_section"
					style="padding: 10px 30px 50px 30px; margin-top: 30px; margin-bottom: 50px">
					<!-- 결제 UI -->
					<div id="payment-method"></div>
					<!-- 이용약관 UI -->
					<div id="agreement"></div>




					<!-- 쿠폰 체크박스 -->
					<!-- <div class="checkable typography--p" style="padding-left: 25px">
						<label for="coupon-box_bk"
							class="checkable__label typography--regular"><input
							id="coupon-box_bk" class="checkable__input" type="checkbox"
							aria-checked="true" /><span
							class="checkable__label-text">5,000원 쿠폰 적용</span></label>
					</div> -->




					<div class="notice">
						<label> <img src="resources/images/payment_warning.png"><span>결제
								유의사항</span>
						</label>
						<ul>
							<li>어쩌고 저쩌고</li>
							<li>저쩌고 어쩌고</li>
						</ul>
					</div>

					<div class="notice">
						<label> <img src="resources/images/payment_warning.png"><span>펀딩참여
								유의사항</span>
						</label>
						<ul>
							<li>어쩌고 저쩌고</li>
							<li>저쩌고 어쩌고</li>
						</ul>
					</div>

					<!-- 결제하기 버튼 -->
					<button class="button" id="payment-button" name="payment-button"
						style="margin-top: 30px" disabled="disabled">결제하기</button>
				</div>
			</div>
			<!-- <a href="#" class="btn-submit" id="paymentButton">결제하기</a> -->
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


<script>
	//페이지가 브라우저 캐시에서 로드될 때 새로고침
	// 일단 보류
	window.onpageshow = function(event) {
	    if (event.persisted || (window.performance && window.performance.navigation.type == 2)) {
	        location.reload();
	    }
	};
    const button = document.getElementById("payment-button");
    const coupon = document.getElementById("coupon-box");
    /* couponBox.addEventListener("change", function() {
        var coupon = couponBox.value;
        console.log(coupon); // 선택된 옵션의 value 출력
    }); */
    const currentURL = window.location.protocol + "//" + window.location.host + "/" + window.location.pathname.split("/")[1];
    //console.log(currentURL);
    const generateRandomString = () => window.btoa(Math.random()).slice(0, 20);
    
    // testMoney
    var amount = 320000;
  	//window.onload = updateAmount;
  	// 페이지 로드 됐을 때 html부분도 새로고침하게 되는 법 ########
  	// 현재 페이지 이동 후에 뒤로가기 버튼을 누르면 쿠폰 선택했던 부분은 그대로 남아있는데 가격 부분은 새로 고침이 되어 있는 상태임 이부분 확인해보고 병합 ㄱㄱ
    document.getElementById("changeAmount").innerText = amount+"원";
    // ------  결제위젯 초기화 ------
    // TODO: clientKey는 개발자센터의 결제위젯 연동 키 > 클라이언트 키로 바꾸세요.
    // TODO: 구매자의 고유 아이디를 불러와서 customerKey로 설정하세요. 이메일・전화번호와 같이 유추가 가능한 값은 안전하지 않습니다.
    // @docs https://docs.tosspayments.com/reference/widget-sdk#sdk-설치-및-초기화
    
    // API 개별 연동 client Key 
    //const clientKey = "test_ck_ex6BJGQOVDk0KzEMB1z53W4w2zNb";
    // 기존 sample
    const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
    const customerKey = generateRandomString();
    const paymentWidget = PaymentWidget(clientKey, customerKey); // 회원 결제
    // const paymentWidget = PaymentWidget(clientKey, PaymentWidget.ANONYMOUS); // 비회원 결제

    // ------  결제 UI 렌더링 ------
    // @docs https://docs.tosspayments.com/reference/widget-sdk#renderpaymentmethods선택자-결제-금액-옵션
    paymentMethodWidget = paymentWidget.renderPaymentMethods(
      "#payment-method",
      { value: amount },
      // 렌더링하고 싶은 결제 UI의 variantKey
      // 결제 수단 및 스타일이 다른 멀티 UI를 직접 만들고 싶다면 계약이 필요해요.
      // @docs https://docs.tosspayments.com/guides/payment-widget/admin#멀티-결제-ui
      { variantKey: "DEFAULT" }
    );
    // ------  이용약관 UI 렌더링 ------
    // @docs https://docs.tosspayments.com/reference/widget-sdk#renderagreement선택자-옵션
    paymentWidget.renderAgreement("#agreement", { variantKey: "AGREEMENT" });

    //  ------  결제 UI 렌더링 완료 이벤트 ------
    paymentMethodWidget.on("ready", function () {
      button.disabled = false;
      coupon.disabled = false;
    });

    // ------  결제 금액 업데이트 ------
    // @docs https://docs.tosspayments.com/reference/widget-sdk#updateamount결제-금액
    /*coupon.addEventListener("change", function () {
    	const selectedValue = this.value;
    	console.log(selectedValue);
    	const discount = parseInt(selectedValue, 10) || 0;
      if (coupon.checked) {
        paymentMethodWidget.updateAmount(amount - discount);
      } else {
        paymentMethodWidget.updateAmount(amount);
      }
    });*/
    coupon.addEventListener("change", function() {
        var selectedValue = this.value;
        
     	// 쿠폰을 여러 차례 선택한 뒤 결제를 진행하지 않을 경우 발생하는 에러(총 결제 금액이 변동됨)를 방지하기 위해 임시변수 사용
     	var applicableAmount = amount;
        var discountAmount = 0;
        
        
     	//  할인율, 최대 할인 가능 금액
        var [discountRate, maxDiscount] = selectedValue.split(',').map(Number);
    	// test
        console.log(discountRate);
        console.log(maxDiscount);

        if(selectedValue == 0){
        	paymentMethodWidget.updateAmount(applicableAmount);
        	updateAmount(applicableAmount);
        	return;
        }
        if(discountRate == 0){
        	discountAmount = maxDiscount;
        	// 결제 금액 - 금액 할인권
        	paymentMethodWidget.updateAmount(applicableAmount = discountAmount > 50000 ? amount-50000 : amount - discountAmount);
        }else{
        	discountAmount = discountRate;
        	// 결제 금액 - 퍼센트 할인권
        	paymentMethodWidget.updateAmount(applicableAmount = (amount * (discountAmount * 0.01)) > 50000 ? amount-50000 : amount-(amount * (discountAmount * 0.01)));
        }
        
        // 총 결제 금액 변경
        updateAmount(applicableAmount);
        
        // 십진수로 변환
        //const discount = parseInt(selectedValue, 10) || 0;
    });

    // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
    // @docs https://docs.tosspayments.com/reference/widget-sdk#requestpayment결제-정보
    button.addEventListener("click", function () {
      paymentWidget.requestPayment({
        orderId: generateRandomString(),
        orderName: "토스 티셔츠 외 2건",
        successUrl: currentURL + "/success.do",
        failUrl: currentURL + "/failure.do",
        customerEmail: "customer123@gmail.com",
        customerName: "김토스",
        customerMobilePhone: "01012341234",
      }).catch(function(error){
    	  // 결제 취소 시 처리
    	  if(error.code === 'USER_CANCEL'){
    		  handlePaymentCancel();
    	  }else{
    		  console.error("Payment error : ", error);
    	  }
      });
    });
    // 결제 취소시
    function handlePaymentCancel() {
        console.log("Payment was cancelled. Amount remains unchanged.");
        alert("결제가 취소되었습니다.");
    }
    
    // 총 결제 금액 갱신
    function updateAmount(price){
    	document.getElementById("changeAmount").innerText = price+"원";
    }
    
    
  </script>
</html>