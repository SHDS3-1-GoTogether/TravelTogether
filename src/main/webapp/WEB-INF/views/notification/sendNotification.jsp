<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림 등록</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<form action="${path}/admin/sendNotification.do" method="post">
		<input type="number" name="member_id">
		<input type="text" name="message_content">
		<input type="submit">
	</form>
</body>
</html>