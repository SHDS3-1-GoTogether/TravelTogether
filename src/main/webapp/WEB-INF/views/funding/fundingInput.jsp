<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<script>
	function addImg() {
		$("#extraImg").append("<div><input type='file' name='pic'><span onclick='removeImg(this)'>x</span></div>");
	}
	
	function removeImg(id) {
		$(id).parent().remove();
	}
</script>

	<h1>펀딩글 등록</h1>
	<form action="fundingInput.do" 
	method="post"
	>
	title : <input type="text" name="title" > <br>
	price : <input type="number" name="price"><br>
	area : <input type="text" name="area"><br>
	category : <input type="text" name="category"><br>
	start_date - end-date : <input type="date" name="start_date">
	- <input type="date" name="end_date"> <br>
	accommodation (숙소) : <input type="text" name="accommodation">
	<input type="radio" value="complete" name="isBook">예약완료<br>
	traffic : 	<input type="text" name="traffic"><br>
	<input type="radio" value="together" name="traffic_option">같이출발
	<input type="radio" value="solo" name="traffic_option">따로출발
	departure(출발지) : <input type="text" name="departure"><br>
	people_num : <input type="number" name="people_num"><br>
	deadline : <input type="date" name="deadline"> <br>
	content : <input type="text" name="funding_content"> <br>

	증명용 사진:
	<input type="file" name="prov_pic"> <br>
	<!-- <input type="text" name="pic"> <br> -->
	대표 사진:
	<input type="file" name="main_pic"> <br>
	추가 사진 :
	<div id="extraImg">
		<input  type="file" name="pics"> <br>
	</div>
	<input type="button" onclick="addImg()" value="추가"><br>

	<input type="submit" value="입력">
	</form>
	

</body>
</html>