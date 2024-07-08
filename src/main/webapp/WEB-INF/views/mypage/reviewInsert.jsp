<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지 후기</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="${path}/resources/css/mypageReviewList.css" rel="stylesheet">
	<link href="${path}/resources/css/mypageMenu.css" rel="stylesheet">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="mypage-header">
		<h2>마이페이지</h2>
	</div>
	<div class="container">
		<%@ include file="./mypageMenu.jsp"%>
		<div class="mypage-review-content">
			<h3><i class="fas fa-pencil-alt"></i> 나의 후기</h3>
		</div>
		<div class="review-content-wrap">
		<form id="insert_form" action="${path}/mypage/reviewInsert.do" method="post">
			<input type="hidden" name="funding_id" value="${funding_id}">
			<div>
				<label for="review_content">후기 내용</label>
				<textarea name="review_content" id="review_content" placeholder="ex) 정말 즐거운 여행이였어요!!" maxlength="4000" required></textarea>
			</div>
			<div class="buttons">
				<a href="${path}/mypage/reviewList.do"><button type="button" class="cancel-button">취소</button></a>
				<button type="submit" class="submit-button">등록</button>
			</div>

		</form>
		</div>
		
	</div>
	<%@ include file="../common/footer.jsp" %>
	
	<%-- Review 등록 결과 모달 --%>
	<div class="insert-result-modal-box">
		<c:if test="${insertResult != 0}">
			<h3>리뷰 등록 성공</h3>
			<p>리뷰를 등록하였습니다.</p>
		</c:if>
		<c:if test="${insertResult == 0}">
			<h3>리뷰 등록 실패</h3>
			<p>리뷰등록에 실패하였습니다.</p>
		</c:if>
		<button type="button" class="confirm-button">확인</button>
	</div>
	
	<div class="modal_bg"></div>
	
	<script>
		$(function(){
			if(${insertResult}>=0) {
				f_insertResult();
			}
			
			$("#review_content").on("click", f_insertReview);
			//$("#addBtn").on("click", f_addReviewBtnClick);
			
			$(".cancel-button").on("click", f_cancelBtnClick);
			$(".confirm-button").on("click", f_confirmBtnClick);
		});
		
		/* 사용자 Review 등록 결과 모달창 호출 */
		function f_insertResult() {
			if(${insertResult} >= 0){
				$(".insert-result-modal-box").fadeIn(500);
				$(".modal_bg").fadeIn(500);
			} else {
				$(".insert-result-modal-box").fadeOut(500);
				$(".modal_bg").fadeOut(500);
			}
		}
		
		function f_addReviewBtnClick() {
			$(".review-content-wrap").fadeIn(500);
			$(".modal_bg").fadeIn(500);
		}
		
		function f_cancelBtnClick() {
			$(".review-content-wrap").fadeOut(500);
			//$(".update-qna-modal-box").fadeOut(500);
			$(".modal_bg").fadeOut(500);
		}
		
		/* function f_confirmBtnClick() {
			$(".insert-result-modal-box").fadeOut(500);
			//$(".delete-result-modal-box").fadeOut(500);
			$(".modal_bg").fadeOut(500);
		} */
		
		
	</script>
	
</body>
</html>