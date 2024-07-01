<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>대표 사진</div>
		<input type="file" accept="image/*" name="main_pic"> <br>
	<div id="mainImgArea"></div>
	<div>상세 사진</div>
	<div id="extraImg" class="extraImg">
		<input  type="file" accept="image/*" name="extra_pics"> <br>
		<div id="extraImgArea"></div>
	</div>

	
	<input type="button" onclick="addImg()" value="추가"><br>
	
    <button id="submit5" class="submit">제출</button>
</body>
</html>