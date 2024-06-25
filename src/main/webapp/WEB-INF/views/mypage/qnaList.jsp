<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자 QnA 리스트</title>
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
/>
<link href="${path}/resources/css/userQnAList.css" rel="stylesheet">
<link href="${path}/resources/css/mypageMenu.css" rel="stylesheet">
<link
	    rel="stylesheet"
	    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
	  />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<div class="container">
	<%@ include file="./mypageMenu.jsp" %>	
	<div class="mypage-qna-content">
		<h2><i class="fas fa-question-circle"></i> Q&amp;A 목록</h2>
		<div class="option">
			<div class="select-option">
				<p class="select-label">구분 : </p>
				<select id="qna_category">
					<option value="-1">전체</option>
					<option value="0" >펀딩관련</option>
					<option value="1">결제관련</option>
					<option value="2">기타등등</option>
				</select>
			</div>
			<div class="select-option">
				<button class="add-button" id="addBtn"><i class="fas fa-plus"></i> QnA등록</button>
			</div>
		</div>
		<div class="list-table">
			<div class="header">
				<p class="qna-category">카테고리</p>
				<p class="qna-title">제목</p>
				<p class="qna-create-date">작성날짜</p>
				<p class="qna-answer-date">답변날짜</p>
				<!-- <p class="qna-answer-status">답변상태</p> -->
				<p class="qna-button">수정</p>
				<p class="qna-button">삭제</p>
			</div>
			<c:forEach var="qna" items="${qnalist}">
				<div class="data">
					<p class="qna-category">${qna.qna_category}</p>
					<p class="qna-title">${qna.title}</p>
					<p class="qna-create-date">${qna.create_date}</p>
					<p class="qna-answer-date">${qna.answer_date}</p>
					<%-- <p class="qna-answer-status">${qna.answer_status}</p> --%>
					<p class="qna-button"><button class="button"><i class="fas fa-pencil-alt"></i></button></p>
					<p class="qna-button">
						<button class="button delete-btn"><i class="fas fa-trash-alt"></i></button>
						<input type="hidden" value="${qna.qna_id}">
					</p>
				</div>
			</c:forEach>
		</div>
	</div>
</div>
	<%-- 쿠폰 삭제 결과 모달 --%>
	<div class="delete-result-modal-box">
		<h3 id="delete_result_title"></h3>	
		<p id="delete_result_content"></p>	
	<button type="button" class="delete-confirm-button">확인</button>
	</div>
	
	<div class="modal_bg"></div>
	
	<script>
		$(function(){
			$.each($("#qna_option").children("option"), function(index, item){
				console.log(item);
				if(item.value == ${option}){
					item.setAttribute('selected', 'selected');
				}
			});
			f_insertResult();
			$("#qna_category").on("change", f_categorySelectChange);
			$("#addBtn").on("click", f_addQnABtnClick);
			$(".cancel-button").on("click", f_cancelBtnClick);
			$(".confirm-button").on("click", f_confirmBtnClick);
			$(".delete-btn").on("click", f_deleteBtnClick);
			$(".delete-confirm-button").on("click", f_deleteConfirmClick);
		});
		
	
</script>
</body>
</html>