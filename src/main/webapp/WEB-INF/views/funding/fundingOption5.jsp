<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="info-label"><span>대표 사진</span></div>
   	<div class="info-ment">사람들의 주목을 받을 수 있는 멋진 대표 사진을 등록해주세요!</div>
    <div id="mainImageWrapper" class="mainImage-preview"  onclick="mainImageOnClick()">
		<img alt="add_img.png" id="mainImage" class="default-image" src="${path}/resources/images/add_img.png" alt="add_img.png">
	</div>
	<input type="file" id="main-image" accept="image/*" name="main_pic" style="display:none"> <br>
	<div id="mainImgArea"></div>

	
     <div class="funding-section">
     	<div class="info-label"><span>상세 사진</span></div>
     	<div class="info-ment">내가 만든 펀딩을 더 홍보하기 위한 상세 사진을 등록해주세요! 여러장을 등록할 수 있습니다.</div>
        <div class="detail-image-upload">
            <div class="image-slider">
                <button type="button" class="slider-btn" id="prevBtn" onclick="slideLeft()">&#10094;</button>
                <div id="detailImageWrapper" class="image-wrapper">
                    <div id="detailImageContainer" class="image-container">
                        <div class="detail-image" id="defaultDetailImage">
    						<input type="file" class="extra_pics"  id="detailImage0" name="extra_pics" accept="image/*" style="display:none" >
                            <div id="detailImage0Preview" class="image-preview"  onclick="detailImageOnClick(0)">
                                <img class="default-image" src="${path}/resources/images/add_img.png" alt="add_img.png">
                            </div>
                            <button type="button" class="remove-icon" onclick="removeDetailImage(0)">X</button>
                        </div>
                    </div>
                </div>
                <button type="button" class="slider-btn" id="nextBtn" onclick="slideRight()">&#10095;</button>
            </div>
            <button type="button" class="add-btn" onclick="addDetailImage()">+</button>
        </div>
    </div>
	
    <button id="submit5" class="submit">제출</button>
    
    


</body>
</html>