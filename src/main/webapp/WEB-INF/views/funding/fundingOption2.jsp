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
			<div>숙소</div>
			<div>모집인원을 모두 수용가능한 숙소를 예약하셨습니까?</div>
			<input type="checkbox" id="accommodationCheck" onclick="accommodCheck()"> <span>예약완료</span><br>
			<span>주소 : </span> <input type="text" id="accommodation" disabled> <img alt="upload" id="acc-upload" src="${path}/resources/images/upload.png">
			<div>주소를 입력 후 예약 내역을 첨부해주세요.</div>
			<div id="accImgArea"></div>
		</div>
		<div>
			<div>교통</div>
			<div>모집인원을 모두 수용가능한 교통편을 예약하셨습니까?</div>
			<input type="checkbox" id="trafficCheck" onclick="trafficCheck()"> <span>예약완료</span><br>
			<span>교통수단 : </span> <input type="text" id="traffic" name="traffic" disabled> <img id="traffic-upload" alt="upload" src="${path}/resources/images/upload.png">
			<div>교통수단을 입력 후 예약 내역을 첨부해주세요.</div>
			<span>출발지 : </span><input type="text" id="departure" name="departure" disabled><br>
			<div id="trafficImgArea"></div>
		</div>
	</div>
	<button id="submit2" class="submit">NEXT</button>
	
	<input type="file" id="accommodation_pic" name="prov_pics" accept="image/*" style="display:none">
	<input type="file" id="traffic_pic" name="prov_pics" accept="image/*" style="display:none">
	
</body>
</html>