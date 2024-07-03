<%@page import="java.util.ArrayList"%>
<%@page import="com.shinhan.travelTogether.coupon.UserCouponDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.shinhan.travelTogether.coupon.CouponService"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	session="false"%> --%>
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
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<main>
			<h1>결제 예약</h1>
			<div class="travel-info">
				<span>${title} [신청자 : ${applicantNick}]</span>
			</div>

			<div class="progress progress-container">
				<div class="progress-step">리워드 선택</div>
				<div class="arrow">→</div>
				<div class="progress-step active">결제 예약</div>
			</div>
			<hr>
			<div class="payment-info">
				<div class="payment-details">
					<div class="detail">
						<span>리워드 금액:</span>
						<span>
							<fmt:formatNumber pattern="#,###">
								${price}
							</fmt:formatNumber>원
						</span>
						
					</div>
					<!-- <div class="detail">
						<span>추가 후원금:</span> <span>0원</span>
					</div> -->

					<!-- 쿠폰 콤보박스 -->
					<div class="detail">
						<span>쿠폰 선택:</span> <select id="coupon-box" class="coupon-box">
							<option value="0" disabled selected>쿠폰을 선택하세요</option>
							<option value="0">사용안함</option>
							<c:forEach var="coupon" items="${couponlist }">
								<option
									value="${coupon.discount_rate},${coupon.max_discount},${coupon.coupon_record_id}">${coupon.title}</option>
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
					style="padding: 10px 30px 50px 30px; margin-top: 30px; margin-bottom: 20px">
					<!-- 결제 UI -->
					<div id="payment-method"></div>
					<!-- 이용약관 UI -->
					<div id="agreement"></div>

					<div class="notice">
						<label> <img
							src="${path}/resources/images/payment_warning.png"><span>결제
								유의사항</span>
						</label>
						<ul>
							<li>어쩌고 저쩌고</li>
							<li>저쩌고 어쩌고</li>
						</ul>
					</div>

					<div class="notice">
						<label> <img
							src="${path}/resources/images/payment_warning.png"><span>펀딩참여
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
		</main>
	</div>
</body>

<script>
	//페이지가 브라우저 캐시에서 로드될 때 새로고침(일단보류)
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
    
    // 상품금액 적용
    var amount = "${price}";
    // 상품명 적용
    var title = "${title}";
    
  	//window.onload = updateAmount;
  	// 페이지 로드 됐을 때 html부분도 새로고침하게 되는 법 ########
  	// 현재 페이지 이동 후에 뒤로가기 버튼을 누르면 쿠폰 선택했던 부분은 그대로 남아있는데 가격 부분은 새로 고침이 되어 있는 상태임 이부분 확인해보고 병합 ㄱㄱ
    document.getElementById("changeAmount").innerText = formatNumber(amount)+"원";
    // ------  결제위젯 초기화 ------
    // TODO: clientKey는 개발자센터의 결제위젯 연동 키 > 클라이언트 키로 바꾸세요.
    // TODO: 구매자의 고유 아이디를 불러와서 customerKey로 설정하세요. 이메일・전화번호와 같이 유추가 가능한 값은 안전하지 않습니다.
    // @docs https://docs.tosspayments.com/reference/widget-sdk#sdk-설치-및-초기화
    
    // API 개별 연동 client Key 
    //const clientKey = "test_ck_ex6BJGQOVDk0KzEMB1z53W4w2zNb";
    // sample
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
     	//  할인율, 최대 할인 가능 금액, 쿠폰 기록 아이디
        var [discountRate=0, maxDiscount=0, coupon_record_id=0] = selectedValue.split(',').map(Number);
     	
     	// test
        console.log(discountRate);
        console.log(maxDiscount);
		console.log(coupon_record_id);
        
        // 쿠폰 미선택시
        if(discountRate == 0 && maxDiscount == 0 && coupon_record_id == 0){
        	paymentMethodWidget.updateAmount(applicableAmount);
        	updateAmount(applicableAmount);
        	sendCouponId(coupon_record_id);
        	return;
        }
        
        // 쿠폰 할인율/할인 금액 구분
        if(discountRate == 0 && maxDiscount > 0){
        	discountAmount = maxDiscount;
        	// 결제 금액 - 금액 할인권
        	paymentMethodWidget.updateAmount(applicableAmount = applicableAmount-discountAmount);
        	
        }else{
        	discountAmount = discountRate;
        	// 결제 금액 - 퍼센트 할인권
        	paymentMethodWidget.updateAmount(applicableAmount = (amount * (discountAmount * 0.01)) > maxDiscount ? amount-maxDiscount : amount-(amount * (discountAmount * 0.01)));
        }
     	// 쿠폰id 세션저장
        sendCouponId(coupon_record_id);
        // 총 결제 금액 변경
        updateAmount(applicableAmount);
    });

    // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
    // @docs https://docs.tosspayments.com/reference/widget-sdk#requestpayment결제-정보
    button.addEventListener("click", function () {
      paymentWidget.requestPayment({
        orderId: generateRandomString(),
        orderName: title,
        successUrl: currentURL + "/payment/success.do",
        failUrl: currentURL + "/payment/failure.do",
        /* customerEmail: "customer123@gmail.com",
        customerName: "김토스",
        customerMobilePhone: "01012341234", */
      }).catch(function(error){
    	  // 결제 취소 시 처리
    	  if(error.code === 'USER_CANCEL'){
    		  handlePaymentCancel();
    	  }else if(error.code == 'NEED_AGREEMENT_WITH_REQUIRED_TERMS'){
    		  handledonotAgreeTerms();
    	  }
    	  else{
    		  console.error("Payment error : ", error);
    	  }
      });
    });
    // 결제 취소시
    function handlePaymentCancel() {
        console.log("Payment was cancelled. Amount remains unchanged.");
        alert("결제가 취소되었습니다.");
    }
    function handledonotAgreeTerms() {
        console.log("User didn't agree Terms");
        alert("필수 약관에 동의해주세요.");
    }
    // 총 결제 금액 갱신
    function updateAmount(price){
    	document.getElementById("changeAmount").innerText = formatNumber(price)+"원";
    	//document.getElementById("changeAmount").innerText = price+"원";
    }
    
 	// 적용된 쿠폰 정보 저장
    function sendCouponId(coupon_record_id) {
        $.ajax({
            url: '${path}/payment/save-coupon-id',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ couponId: coupon_record_id }),
            success: function(response) {
                var data = JSON.parse(response);
                if (data.status === 'success') {
                    console.log('쿠폰이 성공적으로 저장되었습니다.');
                } else {
                    console.log('쿠폰 적용을 실패하였습니다.')
                }
            },
            error: function(xhr, status, error) {
                console.error('Error:', error);
                console.log('서버 오류가 발생하였습니다.')
            }
        });
    }
 	// 가격 단위 포맷팅
    function formatNumber(num) {
        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

  </script>
</html>