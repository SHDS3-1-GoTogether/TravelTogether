<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div id="funding-container">
        <div id="header">
            <button id="prev-btn">이전</button>
            <div id="year-display"></div>
            <div id="month-display"></div>
            <button id="next-btn">다음</button>
        </div>
        <div id="calendar" class="calendar-grid"></div>
        
        <h3>테마</h3>
        
		<span>테마 : </span>
		<c:forEach items="${theme}" var="theme">
			<input type="checkbox" name="theme" value="${theme.theme_id}/${theme.title}">${theme.title}
		</c:forEach>
		
		
        <h3>금액</h3>
        <input type="number" id="price" placeholder="1인 예산을 입력해주세요.">

		<button id="submit3" class="submit">NEXT</button>
    </div>

</body>
</html>
