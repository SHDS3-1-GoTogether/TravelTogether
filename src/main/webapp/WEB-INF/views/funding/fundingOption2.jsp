<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="inputBookWrapper">
		<div class="accommodation-wrapper">
		
			<div class="info-label"><span>숙소</span></div>
			<div class="checkComment">모집인원을 모두 수용가능한 숙소를 예약하셨습니까?</div>
			<div  class="checkWrapper"><input type="checkbox" id="accommodationCheck" onclick="accommodCheck()"> <span>예약완료</span></div><br>
			<div class="inputWrapper"><span>주소 : </span> <input type="text" id="accommodation" disabled> <img alt="upload" id="acc-upload" src="${path}/resources/images/upload.png"></div>
			<div class="inputGuide">주소를 입력 후 예약 내역을 첨부해주세요.</div>
			<div id="accImgArea"></div>
		</div>
		<div class="traffic-wrapper">
			<div class="info-label"><span>교통</span></div>
			<div class="checkComment">모집인원을 모두 수용가능한 교통편을 예약하셨습니까?</div>
			<div  class="checkWrapper"><input type="checkbox" id="trafficCheck" onclick="trafficCheck()"> <span class="checkLabel">예약완료</span></div><br>
			<div class="inputWrapper"><span>교통수단 : </span> <input type="text" id="traffic" name="traffic" disabled> <img id="traffic-upload" alt="upload" src="${path}/resources/images/upload.png"></div>
			<div class="inputGuide">교통수단을 입력 후 예약 내역을 첨부해주세요.</div>
			<div id="trafficImgArea"></div>
			<div class="inputWrapper" style="margin-left: -10px;"><span>&nbsp출발지 : </span><input type="text" id="departure" name="departure" disabled></div><br>
		</div>
	</div>
	<button id="submit2" class="submit">NEXT</button>
	
	<input type="file" id="accommodation_pic" name="prov_pics" accept="image/*" style="display:none">
	<input type="file" id="traffic_pic" name="prov_pics" accept="image/*" style="display:none">
	
</body>
</html>