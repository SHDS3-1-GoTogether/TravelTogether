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
	    <div class="info-label">
	        <span>펀딩 모집 마감일</span>
	    </div>  	
        <div id="header">
            <img src="${path}/resources/images/vector-left.png" class="nav-button" id="prev-btn">
            <div id="year-display"></div>
            <div id="month-display"></div>
            <img src="${path}/resources/images/vector-right.png" class="nav-button" id="next-btn">
        </div>
        <div id="calendar" class="calendar-grid"></div>
        <div class="inputBookWrapper">
	        <div class="info-wrapper">
			    <div class="info-label">
			        <span>테마</span>
			    </div> 
				<c:forEach items="${theme}" var="theme">
					<input type="checkbox" name="theme" value="${theme.theme_id}/${theme.title}">${theme.title}
				</c:forEach>        
	        </div>
			<div class="info-wrapper">
			    <div class="info-label">
			        <span>금액</span>
			    </div> 
		        <input type="number" min="0" id="price" placeholder="1인 예산을 입력해주세요.">
			</div>
		</div>
			<button id="submit3" class="submit">NEXT</button>		
    </div>

</body>
</html>
