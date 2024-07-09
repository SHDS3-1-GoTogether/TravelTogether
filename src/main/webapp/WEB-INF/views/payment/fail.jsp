<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="org.json.simple.parser.ParseException" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<%
 String message = request.getParameter("message");
  String code = request.getParameter("code");
%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/payment.css" />
    <!-- <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" /> -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>결제 실패</title>
  </head>
  
  <body>
    <div id="info" class="box_section" style="width: 600px; margin-top: 200px;">
      <img width="100px" src="https://static.toss.im/lotties/error-spot-no-loop-space-apng.png" />
      <h2>결제를 실패했어요</h2>
      <div class="p-grid">
        <button class="button p-grid-col5" onclick="window.location.href = '${path}/';">홈으로</button>
        <button class="button p-grid-col5" onclick="#" style="background-color: #e8f3ff; color: #1b64da">결제 재시도</button>
      </div>
    </div>
  </body>
</html>