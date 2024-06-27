<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!-- prettier-ignore -->
<%@ page import="java.util.Base64"%>
<%@ page import="java.util.Base64.Encoder"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.net.URL"%>
<%@ page import="org.json.simple.JSONObject"%>
<%@ page import="org.json.simple.JSONArray"%>
<%@ page import="org.json.simple.parser.JSONParser"%>
<%@ page import="org.json.simple.parser.ParseException"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.io.InputStream"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="java.io.Reader"%>
<%@ page import="java.nio.charset.StandardCharsets"%>

<%
// payments key는 각 작업의 후속작업을 발생하는 코유의 키인데 환불시 해당 키가 반드시 필요함
String paymentKey = (String) request.getAttribute("primaryKey");
String cancelReason = (String) request.getAttribute("reason");
String refundDate = (String) request.getAttribute("refundDate");
//String paymentKey = "${primaryKey}";
//String cancelReason = "${reason}";

//부분 취소에서만 사용
String cancelAmount = "300";

//refundReceiveAccount - 가상계좌 거래에 대해 입금후에 취소하는 경우만 필요
String bank = "신한";
String accountNumber = "12345678901234";
String holderName = "홍길동";

// --- 시크릿키 변경
String secretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6:";

Encoder encoder = Base64.getEncoder();
byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
String authorizations = "Basic " + new String(encodedBytes, 0, encodedBytes.length);

URL url = new URL("https://api.tosspayments.com/v1/payments/" + paymentKey + "/cancel");

HttpURLConnection connection = (HttpURLConnection) url.openConnection();
connection.setRequestProperty("Authorization", authorizations);
connection.setRequestProperty("Content-Type", "application/json");
connection.setRequestMethod("POST");
connection.setDoOutput(true);

JSONObject obj = new JSONObject();
obj.put("cancelReason", cancelReason);
obj.put("cancelAmount", cancelAmount);

JSONObject refundReceiveAccount = new JSONObject();
refundReceiveAccount.put("bank", bank);
refundReceiveAccount.put("accountNumber", accountNumber);
refundReceiveAccount.put("holderName", holderName);

obj.put("refundReceiveAccount", refundReceiveAccount);

OutputStream outputStream = connection.getOutputStream();
outputStream.write(obj.toString().getBytes("UTF-8"));

int code = connection.getResponseCode();
boolean isSuccess = code == 200 ? true : false;

InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
JSONParser parser = new JSONParser();
JSONObject jsonObject = (JSONObject) parser.parse(reader);
responseStream.close();

// easyPay 객체에서 provider 값을 가져오기
JSONObject easyPay = (JSONObject) jsonObject.get("easyPay");
String provider = (String) easyPay.get("provider");

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
<title>환불</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath }/resources/css/payment.css" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<style>
.detail-row {
	display: flex;
	justify-content: space-between;
	margin-bottom: 10px;
}

.detail-row b {
	flex: 1;
	text-align: left;
}

.detail-row .value {
	flex: 1;
	text-align: right;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<div class="box_section" style="width: 600px; margin-top: 200px;">
		<img width="100px"
			src="https://static.toss.im/illusts/check-blue-spot-ending-frame.png" />
		<h2>환불을 완료했어요</h2>
		<%
		if (isSuccess) {
		%>
		<div class="detail-row">
			<b>상품명:</b>
			<div class="value"><%=jsonObject.get("orderName")%></div>
		</div>
		<div class="detail-row">
			<b>환불금액:</b>
			<div class="value"><%=jsonObject.get("totalAmount")%></div>
		</div>
		<div class="detail-row">
			<b>구매 날짜:</b>
			<div class="value"><%=formattedApprovedAt%></div>
		</div>
		<div class="detail-row">
			<b>환불 날짜:</b>
			<div class="value"><%=refundDate%></div>
		</div>
		<div class="detail-row">
			<b>결제 방식:</b>
			<div class="value"><%=jsonObject.get("method")%></div>
		</div>
		<div class="detail-row">
			<b>결제 방법:</b>
			<div class="value"><%=provider%></div>
		</div>
		<div class="detail-row">
			<b>환불 사유:</b>
			<div class="value" id="refundReason"><%=cancelReason%></div>
		</div>
		<div id="paymentKey" style="display: none;"><%= paymentKey %></div>
		
		<%
		} else {
		%>
		<h1>취소 실패</h1>
		<div class="detail-row">
			<div class="value"><%=jsonObject.get("message")%></div>
		</div>
		<div class="detail-row">
			<span>에러코드: <%=jsonObject.get("code")%></span>
		</div>
		<%
		}
		%>
		<div class="p-grid">
			<%-- <button class="button p-grid-col5" onclick="location.href= ${path}/" id="sendDataBtn">홈으로</button> --%>
			<button class="button p-grid-col5" id="sendDataBtn">홈으로</button>
		</div>
		
	</div>
	
	<script>
		$(document).ready(function() {
			$("#sendDataBtn").click(function() {
				 var refundReason = $('#refundReason').text(); // 사용자 입력에서 환불 사유 가져오기
		         var paymentKey = $('#paymentKey').text(); // 사용자 입력에서 결제
				
				// AJAX 요청 설정
				$.ajax({
					url : '${path}/refund/saveinfo.do',
					type : 'POST', // 데이터 전송 방식
					data : {
						payment_key : paymentKey,
						refund_reason : refundReason
					},
					success : function(response) {
						// 서버로부터 응답 받았을 때 처리
						if (response.status === 'ok') {
							// 응답이 'ok'일 경우 홈 페이지로 리다이렉트
							window.location.href = '${path}/';
						} else {
							// 응답이 'ok'가 아닐 경우 에러 처리
							alert('Error: ' + response.message);
						}
					},
					error : function(xhr, status, error) {
						// AJAX 요청 실패 시 처리
						alert('AJAX Error: ' + error);
					}
				});
			});
		});
	</script>
</body>
</html>