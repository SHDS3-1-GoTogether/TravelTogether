<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>마이페이지 QnA</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="${path}/resources/css/userQnAList.css" rel="stylesheet">
	<link href="${path}/resources/css/mypageMenu.css" rel="stylesheet">
	<link rel="stylesheet"
	      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		$(function(){
			// 현재 페이지의 URL 가져오기
	        var currentUrl = window.location.href;
			$(".menu-link").removeClass("highlight");
	
	        // URL에 "qna"이 포함되어 있는지 확인
	        if (currentUrl.includes("qna")) {
	            // "QnA" 링크의 폰트 스타일 변경
	            $("#qna-link").addClass("highlight");
	        }
		});
		
		
	</script>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file="../common/header.jsp" %>
<div class="mypage-header">
	<h2>마이페이지</h2>
</div>
<div class="container">
	<%@ include file="./mypageMenu.jsp" %>
	<div class="mypage-qna-content">
		<h3><i class="fas fa-question-circle"></i> Q&amp;A 목록</h3>
		<div class="option">
			<div class="select-category">
				<!-- <p class="select-label">구분 : </p>
				<select id="qna_category">
					<option value="-1">전체</option>
					<option value="0" >펀딩관련</option>
					<option value="1">결제관련</option>
					<option value="2">기타등등</option>
				</select> -->
			</div>
			<div class="select-category">
				<button class="add-button" id="addBtn"><i class="fas fa-plus"></i> Q&amp;A등록</button>
			</div>
		</div>
		<div class="list-table">
			<div class="header">
				<p class="qna-category">카테고리</p>
				<p class="qna-title">제목</p>
				<p class="qna-create-date">작성날짜</p>
				<p class="qna-answer-date">답변날짜</p>
				<p class="qna-button">수정</p>
				<p class="qna-button">삭제</p>
				<p class="qna-answer">답변</p>
			</div>
			<c:forEach var="qna" items="${qnalist}">
				<div class="data">
					<p class="qna-category">${qna.qna_category}</p>
					<p class="qna-title">${qna.title}</p>
					<p class="qna-create-date">${qna.create_date}</p>
					<p class="qna-answer-date">${qna.answer_date}</p>
					
					<p class="qna-button">
						<c:if test="${empty qna.answer}">
							<button class="button update-btn" onclick="f_updateBtnClick('${qna.qna_category}','${qna.title}', '${qna.qna_content}', ${qna.qna_id})">
								<i class="fas fa-pencil-alt"></i>
							</button>
						</c:if>
					</p>
					<p class="qna-button"><button class="button delete-btn"><i class="fas fa-trash-alt"></i></button></p>
					
						<button type="button" class="collapsible qna-answer">+</button>
						<%-- <div class="content"> ${qna.answer}</div> --%>
						<div class="content">
							<h3>[문의 내용]</h3>
							<h4>${qna.qna_content}</h4><br>
							<h3>[답변 내용]</h3>
							<c:if test="${qna.answer == null}">
							<h4>관리자가 확인중에 있습니다. 잠시만 기다려주세요.</h4>
							</c:if>
						 	${qna.answer}</div>
					<input type="hidden" class="qna_id" value="${qna.qna_id}">
					
					
					
				</div>
			</c:forEach>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>

	<%-- QnA 등록 입력폼 모달 --%>
	<div class="add-qna-modal-box">
		<h2>Q&amp;A 등록</h2>
		<form id="insert_form" action="${path}/mypage/qnaInsert.do" method="post">
			<input type="hidden" name="qna_id" value="0">
			<div class="row">
				<label for="category">무엇을 도와드릴까요?</label>
				<select id="category" name="qna_category">
					<option value="0" selected>펀딩문의</option>
					<option value="1">결제문의</option>
					<option value="2">기타등등</option>
				</select>
				<input type="hidden" id="category_input" name="category" value="">
			</div>
			<div class="row">
				<label for="title">제목</label>
				<textarea name="title" id="title" placeholder="ex) 신한카드 할인과 관련하여 질문합니다. " maxlength="100" required></textarea>
			</div>
			<div class="row">
				<label for="qna_content">내용</label>
				<textarea name="qna_content" id="qna_content" placeholder="문의할 내용을 작성해주세요." maxlength="5000" rows="8" required></textarea>
			</div>
			<div class="buttons">
                <button type="button" class="cancel-button">취소</button>
                <button type="submit" class="submit-button">등록</button>
            </div>
		</form>
	</div>

	<%-- 쿠폰 수정 입력폼 모달 --%>
	<div class="update-qna-modal-box">
		<h2>Q&amp;A 수정</h2>
		<form id="update_form" action="${path}/mypage/qnaUpdate.do" method="post">
			<input type="hidden" id="update_qna_id" name="qna_id">
			<div class="row">
				<label for="update_category">무엇을 도와드릴까요?</label>
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
				<textarea name="qna_content" id="update_qna_content" maxlength="5000" rows="8" required></textarea>
			</div>
			<div class="buttons">
                <button type="button" class="cancel-button">취소</button>
                <button type="submit" class="submit-button">등록</button>
            </div>
		</form>
	</div>
	
	<%-- QnA 등록 결과 모달 --%>
	<div class="insert-result-modal-box">
		<c:if test="${insertResult != 0}">
			<h3>QnA등록 성공</h3>
			<p>QnA를 등록하였습니다.</p>
		</c:if>
		<c:if test="${insertResult == 0}">
			<h3>QnA등록 실패</h3>
			<p>QnA등록에 실패하였습니다.</p>
		</c:if>
		<button type="button" class="confirm-button">확인</button>
	</div>

	<%-- QnA 삭제 결과 모달 --%>
	<div class="delete-result-modal-box">
		<h3 id="delete_result_title"></h3>	
		<p id="delete_result_content"></p>	
		<button type="button" class="delete-confirm-button">확인</button>
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
		//console.log("수정완료 "+${updateResult});
		$.each($("#qna_category").children("category"), function(index, item){
			console.log(item);
			if(item.value == ${category}){
				item.setAttribute('selected', 'selected');
			}
		});
		console.log(${insertResult}+" "+${updateResult})
		if(${insertResult}>=0) {
			f_insertResult();
		}
		if(${updateResult}>=0) {
			f_updateResult();
		}
		
		f_insertQnACategorySelect();
		
		$("#qna_category").on("change", f_categorySelectChange);
		$("#addBtn").on("click", f_addQnABtnClick);
		$("#category").on("change", f_insertQnACategorySelect);
		$("#update_category").on("change", f_updateQnACategorySelect);
		
		
		$(".cancel-button").on("click", f_cancelBtnClick);
		$(".confirm-button").on("click", f_confirmBtnClick);
		$(".delete-btn").on("click", f_deleteBtnClick);
		//$(".update-btn").on("click", f_updateBtnClick)
		$(".delete-confirm-button").on("click", f_deleteConfirmClick);
		$(".update-confirm-button").on("click", f_confirmBtnClick);
		/* $("form").on("submit", f_formSubmitBtnClick); */
	});
	
	/* 사용자 QnA 등록 결과 모달창 호출 */
	function f_insertResult() {
		if(${insertResult} >= 0){
			$(".insert-result-modal-box").fadeIn(500);
			$(".modal_bg").fadeIn(500);
		} else {
			$(".insert-result-modal-box").fadeOut(500);
			$(".modal_bg").fadeOut(500);
		}
	}
	
	/* 사용자 QnA 수정 결과 모달창 호출 */
	function f_updateResult() {
		console.log("update_result="+${updateResult});
		if(${updateResult} >= 0){
			if(${updateResult} > 0) {
				$("#update_result_title").text("수정성공");
				$("#update_result_content").text("수정 완료하였습니다.");
			} else if(${updateResult} == 0) {
				$("#update_result_title").text("수정실패");
				$("#update_result_content").text("수정 실패하였습니다.");
			}
			$(".update-result-modal-box").fadeIn(500);
			$(".modal_bg").fadeIn(500);
		} else {
			$(".update-result-modal-box").fadeOut(500);
			$(".modal_bg").fadeOut(500);
		}
	}
	
	function f_categorySelectChange() {
		var option = $("#qna_category category:selected").val();
		location.href="${path}/mypage/qnaList.do?category="+category;
	}
	
	function f_addQnABtnClick() {
		$(".add-qna-modal-box").fadeIn(500);
		$(".modal_bg").fadeIn(500);
	}
	
	function f_insertQnACategorySelect() {
		console.log($("#category").val());
		var option = $("#category").val();
		$("#category_input").val(category);
		
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
	
	/* 선택한 QnA 수정하는 함수 */
	function f_updateBtnClick(category, title, qna_content, qna_id) {
		console.log(category, title, qna_content)
		var data = $(this).parent().parent();
		var form = $("#update_form");
		
		//var qna_id = data.find("input[class='qna_id']").val();
		console.log("qna_id="+qna_id);
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
		
		f_updateQnACategorySelect();
		
		$(".update-qna-modal-box").fadeIn(500);
		$(".modal_bg").fadeIn(500);
	}
	
	/* 선택한 QnA 삭제하는 함수 */
	function f_deleteBtnClick() {
		var deleteNum = $(this).parent().parent().find(".qna_id").val();
		console.log(deleteNum);
		$.ajax({
			url: "${path}/mypage/qnaDelete.do",
			type: "post",
			data: {"qna_id": deleteNum},
			success: function(responseData) {
				console.log(responseData);
				if(responseData == "0" || responseData == null) {
					$("#delete_result_title").text("삭제실패");
					$("#delete_result_content").text("삭제 실패하였습니다.");
				} else {
					$("#delete_result_title").text("삭제성공");
					$("#delete_result_content").text("삭제 완료하였습니다.");
				}
				
				$(".modal_bg").fadeIn(500);
				$(".delete-result-modal-box").fadeIn(500);
			}
		});
	}
	
	function f_deleteConfirmClick() {
		$(".delete-result-modal-box").fadeOut(500);
		$(".modal_bg").fadeOut(500);
		setTimeout(() => {
			location.href="${path}/mypage/qnaList.do";
		}, 500);
		
	}
</script>
<script>
		var coll = document.getElementsByClassName("collapsible");
		var i;
		console.log(coll);

		for (i = 0; i < coll.length; i++) {
			console.log(coll[i]);
		  coll[i].addEventListener("click", function() {
			 console.log(00)
		    this.classList.toggle("active");
		    var content = this.nextElementSibling;
		    console.log(content);
		    if (content.style.display === "block") {
		      content.style.display = "none";
		    } else {
		      content.style.display = "block";
		    }
		  });
		}
</script>
</body>

</html>