<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="com.shinhan.travelTogether.payment.EnvConfig"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
// secretKey 보안처리
EnvConfig envConfig = (EnvConfig) application.getAttribute("envConfig");
String secretKey = envConfig.getProperty("SECRET_KEY");
// String secretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6:";

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

//날짜 형식을 우리가 보는 형식으로 변환
String approvedAt = (String) jsonObject.get("approvedAt");
String formattedApprovedAt = approvedAt;

try {
	SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
	SimpleDateFormat outputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date date = inputFormat.parse(approvedAt);
	formattedApprovedAt = outputFormat.format(date);
} catch (Exception e) {
	e.printStackTrace();
}
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
		<div class="p-grid">
			<button class="button p-grid-col5" onclick="#" id="sendDataBtn">홈으로</button>
		</div>
	</div>

	<div class="box_section" style="width: 600px; text-align: left; display: none;">
		<b>Response Data :</b>
		<div id="orderId"><%=jsonObject.get("orderId")%></div>
		<div id="approvedAt"><%=formattedApprovedAt%></div>
		<div id="totalAmount"><%=jsonObject.get("totalAmount")%></div>
		<div id="provider"><%=jsonObject.get("easyPay")%></div>
		<div id="paymentKey"><%=jsonObject.get("paymentKey")%></div>
	</div>
</body>
<script>
document.getElementById('sendDataBtn').addEventListener('click', function() {
	var orderId = document.getElementById('orderId').innerText;
    var approvedAt = document.getElementById('approvedAt').innerText;
    var totalAmount = document.getElementById('totalAmount').innerText;
	var providerJson = document.getElementById('provider').innerText;
	var paymentKey = document.getElementById('paymentKey').innerText;
	 
    // JSON 문자열 파싱-- 간편결제 결제 방법 파싱
    var providerObj = JSON.parse(providerJson);
    var provider = providerObj.provider;
    
    console.log(provider);
    // paymentKey test
    console.log("paymentKey : " + provider);
    
    var jsonData = {
    		orderId: orderId,
    		requestAt: approvedAt,
    		totalAmount: totalAmount,
    		provider: provider,
    		paymentKey:paymentKey,
    };
    
 // Fetch API를 사용하여 데이터를 서버로 POST 방식으로 (toss api jsonObject에서 데이터 파싱한 뒤 db저장위해)
    fetch('${path}/payment/savepayment.do', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'  // 서버에 JSON 형식의 데이터를 전달하고 있음을 명시
        },
        body: JSON.stringify(jsonData)  // JavaScript 객체를 JSON 문자열로 변환
    })
    .then(response =>{
    	if(response.ok){
    		window.location.href = '${path}/'; // 성공 시 리디렉션
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