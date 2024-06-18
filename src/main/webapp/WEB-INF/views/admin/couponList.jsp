<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 쿠폰 목록</title>
<link
    rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
/>
<link href="${path}/resources/css/adminMenu.css" rel="stylesheet">
<link href="${path}/resources/css/adminCouponList.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	
	<%@ include file="./adminMenu.jsp" %> <%-- 관리자페이지 사이드 메뉴 --%>
	<div class="content">
		<h2><i class="fas fa-tags"></i> 쿠폰 목록</h2>
		<div class="option">
			<div class="select-option">
				<p class="select-label">구분 : </p>
				<select id="coupon_option">
					<option value="-1">전체</option>
					<option value="0" >정기</option>
					<option value="1">특별</option>
					<option value="2">일반</option>
				</select>
			</div>
			<div class="select-option">
				<button class="add-button" id="addBtn"><i class="fas fa-plus"></i> 쿠폰등록</button>
			</div>
		</div>
		<div class="list-table">
			<div class="header">
				<p>쿠폰번호</p>
				<p class="coupon-title">쿠폰명</p>
				<p>할인율</p>
				<p class="coupon-price">최대할인금액</p>
				<p class="coupon-price">할인금액</p>
				<p class="coupon-target">지급대상</p>
				<p class="coupon-button">수정</p>
				<p class="coupon-button">삭제</p>
			</div>
			<c:forEach var="coupon" items="${couponlist}">
				<div class="data">
					<p>${coupon.coupon_id}</p>
					<p class="coupon-title">${coupon.title}</p>
					<c:if test="${coupon.discount_rate > 0}">
						<p>${coupon.discount_rate}%</p>
						<p class="coupon-price">
							<fmt:formatNumber pattern="#,###">${coupon.max_discount}</fmt:formatNumber>원
						</p>
						<p class="coupon-price"></p>
					</c:if>
					<c:if test="${coupon.discount_rate <= 0}">
						<p></p>
						<p class="coupon-price"></p>
						<p class="coupon-price"><fmt:formatNumber pattern="#,###">${coupon.max_discount}</fmt:formatNumber>원</p>
					</c:if>
					<p class="coupon-target">${coupon.membership_id}</p>
					<p class="coupon-button"><button class="button"><i class="fas fa-pencil-alt"></i></button></p>
					<p class="coupon-button">
						<button class="button delete-btn"><i class="fas fa-trash-alt"></i></button>
						<input type="hidden" value="${coupon.coupon_id}">
					</p>
				</div>
			</c:forEach>
		</div>
	</div>
	
	<%-- 쿠폰 등록 입력폼 모달 --%>
	<div class="add-coupon-modal-box">
		<h2>쿠폰 등록</h2>
		<form id="insert_form" action="${path}/admin/couponInsert.do" method="post">
			<div class="row">
				<label for="option">구분</label>
				<select id="option">
					<option value="0" selected>정기</option>
					<option value="1">특별</option>
					<option value="2">일반</option>
				</select>
				<input type="hidden" id="option_input" name="option" value="">
			</div>
			<div class="row membership_fields">
				<label for="membership_id">지급대상</label>
				<select id="membership_id" name="membership_id">
					<option value="walker">뚜벅이</option>
					<option value="bicycle">자전거</option>
					<option value="car">자동차</option>
				</select>
			</div>
			<div class="row">
				<label for="coupon_type">종류</label>
				<select id="coupon_type" name="type">
					<option value="rate" selected>할인율 지정</option>
					<option value="amount">할인금액 지정</option>
				</select>
			</div>
			<div class="row">
				<label for="coupon_name">쿠폰명</label>
				<textarea name="coupon_name" id="coupon_name" placeholder="ex) 5% 할인쿠폰" maxlength="50"></textarea>
			</div>
			<div class="row rate-fields">
				<label for="discount_rate">할인율</label>
	            <input type="number" id="discount_rate" name="discount_rate" value="0"><span>%</span>
	            <span class="note">1~100사이의 숫자만 입력 가능</span>
			</div>
			<div class="row rate-fields">
				<label for="max_discount">최대할인금액</label>
	            <input type="number" id="max_discount" name="max_discount" value="0"><span>원</span>
	            <span class="note">최대 1,000,000까지 입력 가능</span>
			</div>
			<div class="row price-fields">
				<label for="discount_price">할인금액</label>
				<input type="number" id="discount_price" name="discount_price" value="0"><span>원</span>
				<span class="note">최대 1,000,000까지 입력 가능</span>
			</div>
			<div class="buttons">
                <button type="button" class="cancel-button">취소</button>
                <button type="submit" class="submit-button">등록</button>
            </div>
		</form>
	</div>
	
	<%-- 쿠폰 등록 결과 모달 --%>
	<div class="insert-result-modal-box">
		<c:if test="${insertResult != 0}">
			<h3>쿠폰등록 성공</h3>
			<p>쿠폰을 등록하였습니다.</p>
		</c:if>
		<c:if test="${insertResult == 0}">
			<h3>쿠폰등록 실패</h3>
			<p>쿠폰 등록에 실패하였습니다.</p>
		</c:if>
		<button type="button" class="confirm-button">확인</button>
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
			$.each($("#coupon_option").children("option"), function(index, item){
				console.log(item);
				if(item.value == ${option}){
					item.setAttribute('selected', 'selected');
				}
			});
			f_insertResult();
			f_modalCouponOptionSelect();
			f_modalCouponTypeSelect();
			$("#coupon_option").on("change", f_optionSelectChange);
			$("#addBtn").on("click", f_addCouponBtnClick);
			$("#option").on("change", f_modalCouponOptionSelect);
			$("#coupon_type").on("change", f_modalCouponTypeSelect);
			$(".cancel-button").on("click", f_cancelBtnClick);
			$(".confirm-button").on("click", f_confirmBtnClick);
			$(".delete-btn").on("click", f_deleteBtnClick);
			$(".delete-confirm-button").on("click", f_deleteConfirmClick);
		});
		
		function f_insertResult() {
			if(${insertResult} >= 0){
				$(".insert-result-modal-box").show();
				$(".modal_bg").show();
			} else {
				$(".insert-result-modal-box").hide();
				$(".modal_bg").hide();
			}
		}
		
		function f_optionSelectChange() {
			var option = $("#coupon_option option:selected").val();
			location.href="${path}/admin/couponList.do?option="+option;
		}
		
		function f_addCouponBtnClick() {
			$(".add-coupon-modal-box").fadeIn(500);
			$(".modal_bg").fadeIn(500);
		}
		
		function f_modalCouponOptionSelect() {
			console.log($("#option").val());
			var option = $("#option").val();
			$("#option_input").val(option);
			if($("#option").val() == 0){
				$(".membership_fields").show();
			} else {
				$(".membership_fields").hide();
			}
		}
		
		function f_modalCouponTypeSelect() {
			if ($("#coupon_type").val() === 'rate') {
				$(".rate-fields").show();
				$(".price-fields").hide();
			} else {
				$(".rate-fields").hide();
				$(".price-fields").show();
			}
		}
		
		function f_cancelBtnClick() {
			$(".add-coupon-modal-box").fadeOut(500);
			$(".modal_bg").fadeOut(500);
		}
		
		function f_confirmBtnClick() {
			$(".membership_fields").fadeOut(500);
		}
		
		function f_deleteBtnClick() {
			var deleteNum = $(this).next().val();
			console.log(deleteNum);
			$.ajax({
				url: "${path}/admin/couponDelete.do",
				type: "post",
				data: {"coupon_id": deleteNum},
				success: function(responseData) {
					console.log(responseData);
					if(responseData == "0" || responseData == null) {
						$("#delete_result_title").text("삭제실패");
						$("#delete_result_content").text("삭제 실패하였습니다.");
					} else {
						$("#delete_result_title").text("삭제성공");
						$("#delete_result_content").text("삭제 완료하였습니다.");
					}
					
					$(".modal_bg").show();
					$(".delete-result-modal-box").show();
				}
			});
		}
		
		function f_deleteConfirmClick() {
			location.href="${path}/admin/couponList.do";
		}
		
</script>
</body>
</html>