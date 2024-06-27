<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Test Funding ID Form</title>
</head>
<body>
    <h2>Funding ID Test Form</h2>
    <form action="${pageContext.request.contextPath}/payment/pay.do" method="post">
        <label for="fundingId">Funding ID:</label>
        <input type="text" id="fundingId" name="fundingId" value="24">
        <input type="submit" value="Submit">
    </form>
</body>
</html>
