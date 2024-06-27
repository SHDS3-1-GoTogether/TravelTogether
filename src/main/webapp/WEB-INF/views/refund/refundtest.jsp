<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!doctype html>
<html lang="en">

<body>
    <h1>윤철이가 만든 마이페이지</h1>

    <!-- Button trigger modal -->
    <button type="button" class="btn btn-primary" data-toggle="modal"
        data-target="#refundModal">funding-refund</button>
    
    <!-- 여기야 윤철아 -->
    <%@ include file="refundModal.jsp" %>
	<!-- 여기야 윤철아 -->
    
</body>
</html>
