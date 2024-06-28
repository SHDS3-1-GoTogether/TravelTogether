<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>관리자 QnA 목록</title>
	<link rel="stylesheet"
	    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<link href="${path}/resources/css/adminQnAList.css" rel="stylesheet">
	<link href="${path}/resources/css/adminMenu.css" rel="stylesheet">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<%@ include file="../common/header.jsp" %>
	<div class="container">
	<%@ include file="./adminMenu.jsp" %>	
	<div class="content">
		<h2><i class="fas fa-question-circle"></i> Q&amp;A 목록</h2>
		<!-- <div class="category">
			<div class="select-category">
				<p class="select-label">구분 : </p>
				<select id="qna-category">
					<option value="-1">전체</option>
					<option value="0" >펀딩관련</option>
					<option value="1">결제관련</option>
					<option value="2">기타등등</option>
				</select>
			</div>
		</div> -->
		<div class="list-table">
			<div class="header">
				<p class="qna-category">카테고리</p>
				<p class="qna-title">제목</p>
				<p class="qna-create-date">작성날짜</p>
				<p class="qna-answer-date">답변날짜</p>
				<p class="qna-button">답변</p>
			</div>
			<c:forEach var="qna" items="${qnalist}">
				<div class="data">
					<p class="qna-category">${qna.qna_category}</p>
					<p class="qna-title">${qna.title}</p>
					<p class="qna-create-date">${qna.create_date}</p>
					<p class="qna-answer-date">${qna.answer_date}</p>
					<p class="qna-button">
						<button class="button update-btn" onclick="f_updateBtnClick('${qna.qna_category}','${qna.title}','${qna.qna_content}','${qna.answer}',${qna.qna_id})" >
							<i class="fas fa-pencil-alt"></i>
						</button>
					</p>
					<input type="hidden" class="qna_id" value="${qna.qna_id}">
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>

	<%-- 쿠폰 수정 입력폼 모달 --%>
	<div class="update-qna-modal-box">
		<h2>Q&amp;A 답변</h2>
		<form id="update_form" action="${path}/admin/qnaUpdate.do" method="post">
			<input type="hidden" id="update_qna_id" name="qna_id">
			<div class="row">
				<label for="update_category">문의내용</label>
				<select id="update_category" name="update_qna_category" disabled>
					<option value="0">펀딩문의</option>
					<option value="1">결제문의</option>
					<option value="2">기타등등</option>
				</select>
				<input type="hidden" id="update_category_input" name="qna_category" value="" readonly>
			</div>
			<div class="row">
				<label for="update_qna_title">제목</label>
				<textarea name="title" id="update_qna_title" maxlength="100" required readonly></textarea>
			</div>
			<div class="row">
				<label for="update_qna_content">내용</label>
				<textarea name="qna_content" id="update_qna_content" maxlength="5000" rows="10" required readonly ></textarea>
			</div>
			<div class="row">
				<label for="update_qna_answer">답변</label>
				<textarea name="answer" id="update_qna_answer" maxlength="5000" rows="7" required></textarea>
			</div>
			<div class="buttons">
                <button type="button" class="cancel-button">취소</button>
                <button type="submit" class="submit-button">답변등록</button>
            </div>
		</form>
	</div>
	
	
	<%-- QnA 수정 결과 모달 --%>
	<div class="update-result-modal-box">
		<h3 id="update_result_title"></h3>	
		<p id="update_result_content"></p>	
		<button type="button" class="update-confirm-button">확인</button>
	</div>
	
	<div class="modal_bg"></div>
	
	<script>
	$(function(){
		$.each($("#qna-category").children("category"), function(index, item){
			console.log(item);
			if(item.value == ${category}){
				item.setAttribute('selected', 'selected');
			}
		});
		console.log(${insertResult}+" "+${updateResult})
		if(${updateResult}>=0) {
			f_updateResult();
		}
		
		//f_insertQnACategorySelect();
		
		$("#qna_category").on("change", f_categorySelectChange);
		//$("#category").on("change", f_insertQnACategorySelect);
		$("#update_category").on("change", f_updateQnACategorySelect);
		
		$(".cancel-button").on("click", f_cancelBtnClick);
		$(".confirm-button").on("click", f_confirmBtnClick);
		//$(".update-btn").on("click", f_updateBtnClick)
		$(".update-confirm-button").on("click", f_confirmBtnClick);
		/* $("form").on("submit", f_formSubmitBtnClick); */
	});
	
	
	/* 관리자 QnA 업데이트 결과 모달창 호출 */
	function f_updateResult() {
		console.log(${updateResult});
		if(${updateResult} >= 0){
			if(${updateResult} > 0) {
				$("#update_result_title").text("답변성공");
				$("#update_result_content").text("답변 완료하였습니다.");
			} else if(${updateResult} == 0) {
				$("#update_result_title").text("답변실패");
				$("#update_result_content").text("답변 실패하였습니다.");
			}
			$(".update-result-modal-box").fadeIn(500);
			$(".modal_bg").fadeIn(500);
		} else {
			$(".update-result-modal-box").fadeOut(500);
			$(".modal_bg").fadeOut(500);
		}
	}
	
	function f_categorySelectChange() {
		var category = $("#qna-category category:selected").val();
		location.href="${path}/mypage/qnaList.do?category="+category;
	}
	
	function f_updateQnACategorySelect() {
		console.log($("#update_category").val());
		var category = $("#update_category").val();
		$("#update_category_input").val(category);
	}
	
	function f_cancelBtnClick() {
		$(".add-qna-modal-box").fadeOut(500);
		$(".update-qna-modal-box").fadeOut(500);
		$(".modal_bg").fadeOut(500);
	}
	
	function f_confirmBtnClick() {
		$(".insert-result-modal-box").fadeOut(500);
		$(".delete-result-modal-box").fadeOut(500);
		$(".update-result-modal-box").fadeOut(500);
		$(".modal_bg").fadeOut(500);
	}
	
	/* 선택한 QnA 답변하는 함수 */
	function f_updateBtnClick(category, title, qna_content, qna_answer, qna_id) {
		console.log(category, title, qna_content, qna_answer, qna_id)
		var data = $(this).parent().parent();
		var form = $("#update_form");
		
		//var qna_id = data.find("input[class='qna_id']").val();
		//var title = data.find(".qna-title").text().slice(5);
		//var category = data.find(".qna-category").val();
		
		form.find("#update_qna_id").val(qna_id);
		//form.find("#update_category").val(category).prop("selected", true);
		
		$("#update_category option").each(function(index, item){
			console.log(item, index)
			if(category==="[" + $(item).text() + "]"){
				$(this).prop("selected",true)
			}else{
				$(this).prop("selected",false)
			}
		});
		
		
		form.find("#update_category_input").val(category);
		form.find("#update_qna_title").val(title);
		form.find("#update_qna_content").val(qna_content);
		form.find("#update_qna_answer").val(qna_answer);
		
		f_updateQnACategorySelect();
		
		$(".update-qna-modal-box").fadeIn(500);
		$(".modal_bg").fadeIn(500);
	}
</script>
</body>
</html>