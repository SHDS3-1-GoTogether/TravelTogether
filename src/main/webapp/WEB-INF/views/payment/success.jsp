<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Base64"%>
<%@ page import="java.util.Base64.Encoder"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.Reader"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.util.Set"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<%
// ------ 결제 승인 API 호출 ------
// @docs https://docs.tosspayments.com/guides/payment-widget/integration#3-결제-승인하기
// TODO: 개발자센터에 로그인해서 내 결제위젯 연동 키 > 시크릿 키를 입력하세요. 시크릿 키는 외부에 공개되면 안돼요.
// @docs https://docs.tosspayments.com/reference/using-api/api-keys
String secretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6:";

Encoder encoder = Base64.getEncoder();
byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
String authorizations = "Basic " + new String(encodedBytes, 0, encodedBytes.length);

String orderId = request.getParameter("orderId");
String paymentKey = request.getParameter("paymentKey");
String amount = request.getParameter("amount");

URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");

HttpURLConnection connection = (HttpURLConnection) url.openConnection();
connection.setRequestProperty("Authorization", authorizations);
connection.setRequestProperty("Content-Type", "application/json");
connection.setRequestMethod("POST");
connection.setDoOutput(true);
JSONObject obj = new JSONObject();
obj.put("paymentKey", paymentKey);
obj.put("orderId", orderId);
obj.put("amount", amount);

OutputStream outputStream = connection.getOutputStream();
outputStream.write(obj.toString().getBytes("UTF-8"));

int code = connection.getResponseCode();
boolean isSuccess = code == 200 ? true : false;

InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

Reader reader = new InputStreamReader(responseStream, "UTF-8");
JSONParser parser = new JSONParser();
JSONObject jsonObject = (JSONObject) parser.parse(reader);
responseStream.close();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/payment.css" />
<!-- <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" /> -->
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>결제 성공</title>
</head>
<body>
	<div class="box_section" style="width: 600px; margin-top: 200px;">
		<img width="100px"
			src="https://static.toss.im/illusts/check-blue-spot-ending-frame.png" />
		<h2>결제를 완료했어요</h2>

		<div class="p-grid typography--p" style="margin-top: 50px">
			<div class="p-grid-col text--left">
				<b>결제금액</b>
			</div>
			<div class="p-grid-col text--right" id="amount">
				<%=jsonObject.get("totalAmount")%></div>
		</div>
	</div>
	<div class="p-grid">
		<button class="button p-grid-col5" onclick="#" id="sendDataBtn">홈으로</button>
	</div>
	</div>

	<div class="box_section" style="width: 600px; text-align: left">
		<b>Response Data :</b>
		<div id="orderId"><%=jsonObject.get("orderId")%></div>
		<div id="approvedAt"><%=jsonObject.get("approvedAt")%></div>
		<div id="totalAmount"><%=jsonObject.get("totalAmount")%></div>
		<div id="provider"><%=jsonObject.get("easyPay")%></div>
	</div>
</body>
<script>
document.getElementById('sendDataBtn').addEventListener('click', function() {
	var orderId = document.getElementById('orderId').innerText;
    var approvedAt = document.getElementById('approvedAt').innerText;
    var totalAmount = document.getElementById('totalAmount').innerText;
	var providerJson = document.getElementById('provider').innerText;
    
	// 날짜만 파싱-----------------
	//var approvedAtDate = approvedAt.split('T')[0];
	 
    // JSON 문자열 파싱-- 간편결제 결제 방법 파싱
    var providerObj = JSON.parse(providerJson);
    var provider = providerObj.provider;
    
    console.log(provider);
    
    var jsonData = {
    		orderId: orderId,
    		requestAt: approvedAt,
    		totalAmount: totalAmount,
    		provider: provider,
    };

    /* // Fetch API를 사용하여 데이터를 서버로 POST 방식으로 보냅니다.
    fetch('${path}/payment/savepayment.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'  // 서버에 JSON 형식의 데이터를 전달하고 있음을 명시
        },
        body: JSON.stringify(jsonData)  // JavaScript 객체를 JSON 문자열로 변환
    })
    .then(response => response.json())  // 서버로부터의 응답을 JSON으로 파싱
    .then(data => {
        console.log('Server response:', data.message);
        window.location.href = '${path}/payment/success.do';
        //alert('서버로부터의 응답: ' + data.message);
    })
    .catch(error => {
        console.error('Error:', error);
    }); */
    
 // Fetch API를 사용하여 데이터를 서버로 POST 방식으로 보냅니다.(toss api jsonObject에서 데이터 파싱한 뒤 db저장위해)
    fetch('${path}/payment/savepayment.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'  // 서버에 JSON 형식의 데이터를 전달하고 있음을 명시
        },
        body: JSON.stringify(jsonData)  // JavaScript 객체를 JSON 문자열로 변환
    })
    .then(response =>{
    	if(response.ok){
    		window.location.href = '${path}/payment/pay.do'; // 성공 시 리디렉션
    	}else{
    		window.location.href = '${path}/payment/fail.do'; // 실패 시 리디렉션
    	}
    }).catch(error => {
        console.error('Error:', error);
        window.location.href = '${path}/payment/fail.do';
    });
});
</script>

</html>