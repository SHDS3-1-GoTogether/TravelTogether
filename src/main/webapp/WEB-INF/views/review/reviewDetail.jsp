<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 상세보기</title>
<link rel="stylesheet" href="${path}/resources/css/fundingBase.css">
<link rel="stylesheet" href="${path}/resources/css/fundingDetail.css">
<link rel="stylesheet" href="${path}/resources/css/reviewDetail.css">
<%-- <script src="${path}/resources/js/fundingDetail.js"></script> --%>


</head>
<body>
<%@ include file="../common/header.jsp" %>
		<div class="content_wrapper">
		<h1 class="pageTitle">Review </h1>
		<div class="form-wrapper">
		<div class="form-left-wrapper">
		
			<div class="detailContent">
			
				<div class="detail-title">"${fundingDetail.title}"</div>
			
				<div class="detail-content">${reviewDetail.review_content}</div>
				<%-- <c:forEach var="photo" items="${pic}">
					<img alt="${photo}" 
					src="${photo}"
					width="200" height="200">
					<script>
						images.push("${photo}");	
					</script>
				</c:forEach> --%>	
						<div class="slider__wrap">
		            <div class="slider__img"></div>
		            <div class="slider__thumnail"></div>
		            <div class="slider__btn">
		                <a href="#" class="previous"><img alt="vector-left.png" src="${path}/resources/images/vector-left.png"></a>
		                <a href="#" class="next"><img alt="" src="${path}/resources/images/vector-right.png"/></a>
		            </div>
		        </div>
			</div>
	
		</div>
		<div class="right-wrapper">
		<div class="option_wrapper">
			<p class="option-title">옵션내역</p>
			<ul class="option-li-wrapper">
				<li>
					여행일정
					<div>${fundingDetail.start_date}-${fundingDetail.end_date}</div>
					
				</li>
				<li>
					여행지
					<div>${fundingDetail.area}</div>
				</li>
				<li>
					인원
					<div>${fundingDetail.people_num}</div>
				</li>
				<li>
					숙소
					<c:if test="${fundingDetail.accommodation==null}"><div>미정</div></c:if>
					<div>${fundingDetail.accommodation}</div>
				</li>
				<li>
					교통
					<c:if test="${fundingDetail.traffic==null}"><div>미정</div></c:if>
					<div>${fundingDetail.traffic}</div>	
				</li>
				<li>
					예산
					<div><fmt:formatNumber type="number" maxFractionDigits="3" value="${fundingDetail.price}" />원</div>
				</li>
				<li>
					테마<br>
					<c:forEach var="theme" items="${tlist}">
						<c:if test="${theme.funding_id==fundingDetail.funding_id}">
							<span>#${theme.title}</span>
						</c:if>
					</c:forEach>
				</li>
				<li>
					펀딩마감일
					<div>${fundingDetail.deadline}</div>
				</li>
			</ul>			

		</div>
		</div>
		
		
		</div>
		<div class="select-category">
			<c:if test="${member.member_id != null}">
				<button class="add-button" id="addBtn"><i class="fas fa-plus"></i> 댓글작성하기</button>
			</c:if>
		</div>
		<div class="comment-wrapper">
		<div class="down-wrapper">
			<div class="list-table">
				<div class="header">
					<p class="comment-nickname">작성자</p>
					<p class="comment-content">작성내용</p>
					<p class="comment-create-date">작성날짜</p>
					<p class="comment-button"></p>
				</div>
				<c:forEach var="comment" items="${commentlist}">
					<div class="data">
					<input type="hidden" id="member_id"  value="${comment.member_id}" >
					<input type="hidden" id="review_id"  value="${comment.review_id}" >
					
						<p class="comment-nickname">${comment.nickname}</p>
						<p class="comment-content">${comment.comment_content}</p>
						<p class="comment-create-date">${comment.create_date}</p>
						<p class="comment-button">
							<c:if test="${member.member_id == comment.member_id}">
								<button type="button" class="update-button" 
								onclick="f_updateBtnClick(${comment.comment_id}, '${comment.comment_content}')">
									<i class="fas fa-pencil-alt"></i>
								</button>
								<button type="button" class="delete-button" onclick="f_deleteBtnClick(${comment.comment_id})"><i class="fas fa-trash-alt"></i></button>
							</c:if>
						</p>
						<input type="hidden" class="comment_id" value="${comment.comment_id}">
					</div>
				</c:forEach>
			</div>
		</div>
		</div>
	</div>
	<%@ include file="../common/footer.jsp" %>
	
	<%-- 댓글 등록 입력폼 모달 --%>
	<div class="add-comment-modal-box">
		<h2>댓글 등록</h2>
		<form id="insert_form" action="${path}/review/commentInsert.do" method="post">
			<input type="text" name="comment_id" value="0">
			<input type="text" name="review_id" value="${param.review_id}">
			 
			<div class="row">
				<label for="comment_content">내용</label>
				<textarea name="comment_content" id="comment_content" placeholder="댓글에 작성할 내용을 써주세요." maxlength="5000" rows="4" required></textarea>
			</div>
			<div class="buttons">
                <button type="button" class="cancel-button">취소</button>
                <button type="submit" class="submit-button">등록</button>
            </div>
		</form>
	</div>

	<%-- 댓글 수정 입력폼 모달 --%>
	<div class="update-comment-modal-box">
		<h2>댓글 수정</h2>
		<form id="update_form" action="${path}/review/commentUpdate.do" method="post">
			<input type="text" id="update_comment_id" name="comment_id">
			<input type="text" name="review_id" value="${param.review_id}">
			<div class="row">
				<label for="update_comment_content">내용</label>
				<textarea name="comment_content" id="update_comment_content" maxlength="5000" rows="4" required></textarea>
			</div>
			<div class="buttons">
                <button type="button" class="cancel-button">취소</button>
                <button type="submit" class="submit-button">등록</button>
            </div>
		</form>
	</div>
	
	<%-- 댓글 등록 결과 모달 --%>
	<div class="insert-result-modal-box">
		<c:if test="${insertResult2 != 0}">
			<h3>QnA등록 성공</h3>
			<p>댓글을 등록하였습니다.</p>
		</c:if>
		<c:if test="${insertResult2 == 0}">
			<h3>QnA등록 실패</h3>
			<p>QnA등록에 실패하였습니다.</p>
		</c:if>
		<button type="button" class="confirm-button">확인</button>
	</div>

	<%-- 댓글 삭제 결과 모달 --%>
	<div class="delete-result-modal-box">
		<h3 id="delete_result_title"></h3>	
		<p id="delete_result_content"></p>	
		<button type="button" class="delete-confirm-button">확인</button>
	</div>
	
	<%-- 댓글 수정 결과 모달 --%>
	<div class="update-result-modal-box">
		<h3 id="update_result_title"></h3>	
		<p id="update_result_content"></p>	
		<button type="button" class="update-confirm-button">확인</button>
	</div>
	
	<div class="modal_bg"></div>
	
<script>
	$(function(){
		if(${insertResult2}>=0) {
			f_insertResult();
		}
		if(${updateResult2}>=0) {
			f_updateResult();
		}
		
		//$("#qna_category").on("change", f_categorySelectChange);
		$("#addBtn").on("click", f_addCommentBtnClick);
		//$("#category").on("change", f_insertQnACategorySelect);
		//$("#update_category").on("change", f_updateQnACategorySelect);
		
		
		$(".cancel-button").on("click", f_cancelBtnClick);
		$(".confirm-button").on("click", f_confirmBtnClick);
		$(".delete-btn").on("click", f_deleteBtnClick);
		//$(".update-btn").on("click", f_updateBtnClick);
		$(".delete-confirm-button").on("click", f_deleteConfirmClick);
		$(".update-confirm-button").on("click", f_confirmBtnClick);
		/* $("form").on("submit", f_formSubmitBtnClick); */
	});
	
	/* 댓글 등록 결과 모달창 호출 */
	function f_insertResult() {
		if(${insertResult2} >= 0){
			$(".insert-result-modal-box").fadeIn(500);
			$(".modal_bg").fadeIn(500);
		} else {
			$(".insert-result-modal-box").fadeOut(500);
			$(".modal_bg").fadeOut(500);
		}
	}
	
	/* 댓글 수정 결과 모달창 호출 */
	function f_updateResult() {
		if(${updateResult2} >= 0){
			if(${updateResult2} > 0) {
				$("#update_result_title").text("수정성공");
				$("#update_result_content").text("수정 완료하였습니다.");
			} else if(${updateResult2} == 0) {
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
	
	function f_addCommentBtnClick() {
		$(".add-comment-modal-box").fadeIn(500);
		$(".modal_bg").fadeIn(500);
	}
	
	function f_cancelBtnClick() {
		$(".add-comment-modal-box").fadeOut(500);
		$(".update-comment-modal-box").fadeOut(500);
		$(".modal_bg").fadeOut(500);
	}
	
	function f_confirmBtnClick() {
		$(".insert-result-modal-box").fadeOut(500);
		$(".delete-result-modal-box").fadeOut(500);
		$(".update-result-modal-box").fadeOut(500);
		$(".modal_bg").fadeOut(500);
	}
	
	/* 선택한 댓글 수정하는 함수 */
	function f_updateBtnClick(comment_id, comment_content) {
		var data = $(this).parent().parent();
		var form = $("#update_form");
		
		//var qna_id = data.find("input[class='qna_id']").val();
		console.log("comment_id="+comment_id);
		//var title = data.find(".qna-title").text().slice(5);
		//var category = data.find(".qna-category").val();
		
		form.find("#update_comment_id").val(comment_id);
		
		//form.find("#update_category_input").val(category);
		//form.find("#update_comment_title").val(title);
		form.find("#update_comment_content").val(comment_content);
		
		
	//f_updateQnACategorySelect();
		
		$(".update-comment-modal-box").fadeIn(500);
		$(".modal_bg").fadeIn(500);
	}
	
	/* 선택한 댓글 삭제하는 함수 */
	function f_deleteBtnClick(comment_id) {
		
		//var deleteNum = $(this).parent().parent().find(".comment_id").val();
		//console.log(deleteNum);
		$.ajax({
			url: "${path}/review/commentDelete.do",
			type: "post",
			data: {"comment_id": comment_id},
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
			location.href="${path}/review/reviewDetail.do?review_id=${reviewDetail.review_id}";
		}, 500);
		
	}
</script>	
	
</body>
</html>