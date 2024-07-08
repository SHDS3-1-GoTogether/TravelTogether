<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Funding Making</title>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/fundingInput.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <div class="header">
            <h5>여행 일정</h5>
        </div>
        <div >
        	<div id="yearWrapper"></div>
	        <div class="calendar-header">
	        <img src="${path}/resources/images/vector-left.png" class="nav-button" id="prev-button">  	
	        <div class="calendar-month-wrapper">
	            <div class="calendar_month" id="calendar1-month"></div>
	            <div class="calendar_month" id="calendar2-month"></div>
	        </div>
	        <img src="${path}/resources/images/vector-right.png" class="nav-button" id="next-button">
	        </div>
	        <div class="calendar-container">	
	            <div class="calendars">
	                <div class="calendar" id="calendar1"></div>
	                <div class="calendar" id="calendar2"></div>
	            </div>
	        </div>
	        <div class="inputBookWrapper2">
		        <div class="info-wrapper">
			        <div class="info-label">
			        	<span>여행지</span>
			        </div>
			        <div class="info">
			            <input type="text" id="area" placeholder="여행지를 입력해주세요.">
			        </div>	        
		        </div>
				<div class="info-wrapper">
			        <div class="info-label">
			            <span>인원</span>
			        </div>
			        <div class="info2">
			            <input type="number" min="2" id="people_num" placeholder="모집할 인원을 입력해주세요."><br>
			            <div id="people_num_info">인원 수는 2~50명까지 입력 가능합니다.</div>
			        </div>			
				</div>
			</div>
	        <button id="submit1" class="submit">NEXT</button>
        </div>
    </div>
</body>
</html>
