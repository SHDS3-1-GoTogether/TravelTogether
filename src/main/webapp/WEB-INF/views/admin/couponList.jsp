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
	<%@ include file="../common/header.jsp" %>
	<div class="container">
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
					<input type="hidden" class="coupon-option" value="${coupon.coupon_option}">
					<c:if test="${coupon.discount_rate > 0}">
						<p class="discount_rate" >${coupon.discount_rate}%</p>
						<%--<input type="hidden" class="discount-rate-input"value="${coupon.discount_rate}"> --%>
						<p class="coupon-price coupon-price-data">
							<fmt:formatNumber pattern="#,###">${coupon.max_discount}</fmt:formatNumber>원
						</p>
						<p class="coupon-price"></p>
					</c:if>
					<c:if test="${coupon.discount_rate <= 0}">
						<p></p>
						<p class="coupon-price"></p>
						<p class="coupon-price coupon-price-data"><fmt:formatNumber pattern="#,###">${coupon.max_discount}</fmt:formatNumber>원</p>
					</c:if>
					<input type="hidden" class="discount-rate-input"value="${coupon.discount_rate}">
					<input type="hidden" class="coupon-price-input" value="${coupon.max_discount}">
					<p class="coupon-target">${coupon.membership_id}</p>
					<p class="coupon-button"><button class="button update-btn"><i class="fas fa-pencil-alt"></i></button></p>
					<p class="coupon-button">
						<button class="button delete-btn"><i class="fas fa-trash-alt"></i></button>
					</p>
					<input type="hidden" class="coupon_id" value="${coupon.coupon_id}">
				</div>
			</c:forEach>
		</div>
	</div>
	</div>
	<%@ include file="../common/footer.jsp" %>
	<%-- 쿠폰 등록 입력폼 모달 --%>
	<div class="add-coupon-modal-box">
		<h2>쿠폰 등록</h2>
		<form id="insert_form" action="${path}/admin/couponInsert.do" method="post">
			<input type="hidden" name="coupon_id" value="0">
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
				<textarea name="coupon_name" id="coupon_name" placeholder="ex) 5% 할인쿠폰" maxlength="50" required></textarea>
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
	
	<%-- 쿠폰 수정 입력폼 모달 --%>
	<div class="update-coupon-modal-box">
		<h2>쿠폰 수정</h2>
		<form id="update_form" action="${path}/admin/couponUpdate.do" method="post">
			<input type="hidden" id="update_coupon_id" name="coupon_id">
			<div class="row">
				<label for="update_option">구분</label>
				<select id="update_option">
					<option value="0">정기</option>
					<option value="1">특별</option>
					<option value="2">일반</option>
				</select>
				<input type="hidden" id="update_option_input" name="option" value="">
			</div>
			<div class="row membership_fields">
				<label for="update_membership_id">지급대상</label>
				<select id="update_membership_id" name="membership_id">
					<option value="walker">뚜벅이</option>
					<option value="bicycle">자전거</option>
					<option value="car">자동차</option>
				</select>
			</div>
			<div class="row">
				<label for="update_coupon_type">종류</label>
				<select id="update_coupon_type" name="type">
					<option value="rate" selected>할인율 지정</option>
					<option value="amount">할인금액 지정</option>
				</select>
			</div>
			<div class="row">
				<label for="update_coupon_name">쿠폰명</label>
				<textarea name="coupon_name" id="update_coupon_name" placeholder="ex) 5% 할인쿠폰" maxlength="50"></textarea>
			</div>
			<div class="row rate-fields">
				<label for="update_discount_rate">할인율</label>
	            <input type="number" id="update_discount_rate" name="discount_rate" value="0"><span>%</span>
	            <span class="note">1~100사이의 숫자만 입력 가능</span>
			</div>
			<div class="row rate-fields">
				<label for="update_max_discount">최대할인금액</label>
	            <input type="number" id="update_max_discount" name="max_discount" value="0"><span>원</span>
	            <span class="note">최대 1,000,000까지 입력 가능</span>
			</div>
			<div class="row price-fields">
				<label for="update_discount_price">할인금액</label>
				<input type="number" id="update_discount_price" name="discount_price" value="0"><span>원</span>
				<span class="note">최대 1,000,000까지 입력 가능</span>
			</div>
			<div class="buttons">
                <button type="button" class="cancel-button">취소</button>
                <button type="submit" class="submit-button">수정</button>
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
	
	<%-- 쿠폰 수정 결과 모달 --%>
	<div class="update-result-modal-box">
		<h3 id="update_result_title"></h3>	
		<p id="update_result_content"></p>	
		<button type="button" class="update-confirm-button">확인</button>
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
			console.log(${insertResult}+" "+${updateResult})
			if(${insertResult}>=0) {
				f_insertResult();
			}
			if(${updateResult}>=0) {
				f_updateResult();
			}
			
			f_insertCouponOptionSelect();
			f_insertCouponTypeSelect();
			$("#coupon_option").on("change", f_optionSelectChange);
			$("#addBtn").on("click", f_addCouponBtnClick);
			$("#option").on("change", f_insertCouponOptionSelect);
			$("#update_option").on("change", f_updateCouponOptionSelect);
			$("#coupon_type").on("change", f_insertCouponTypeSelect);
			$("#update_coupon_type").on("change", f_updateCouponTypeSelect);
			$(".cancel-button").on("click", f_cancelBtnClick);
			$(".confirm-button").on("click", f_confirmBtnClick);
			$(".delete-btn").on("click", f_deleteBtnClick);
			$(".update-btn").on("click", f_updateBtnClick)
			$(".delete-confirm-button").on("click", f_deleteConfirmClick);
			$(".update-confirm-button").on("click", f_confirmBtnClick);
			$("form").on("submit", f_formSubmitBtnClick);
		});
		
		/* 쿠폰 등록 결과 모달창 호출 */
		function f_insertResult() {
			if(${insertResult} >= 0){
				$(".insert-result-modal-box").fadeIn(500);
				$(".modal_bg").fadeIn(500);
			} else {
				$(".insert-result-modal-box").fadeOut(500);
				$(".modal_bg").fadeOut(500);
			}
		}
		
		/* 쿠폰 수정 결과 모달창 호출 */
		function f_updateResult() {
			console.log(${updateResult});
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
		
		function f_optionSelectChange() {
			var option = $("#coupon_option option:selected").val();
			location.href="${path}/admin/couponList.do?option="+option;
		}
		
		function f_addCouponBtnClick() {
			$(".add-coupon-modal-box").fadeIn(500);
			$(".modal_bg").fadeIn(500);
		}
		
		function f_insertCouponOptionSelect() {
			console.log($("#option").val());
			var option = $("#option").val();
			$("#option_input").val(option);
			if($("#option").val() == 0){
				$(".membership_fields").show();
			} else {
				$(".membership_fields").hide();
			}
			
		}
		function f_updateCouponOptionSelect() {
			console.log($("#update_option").val());
			var option = $("#update_option").val();
			$("#update_option_input").val(option);
			if($("#update_option").val() == 0){
				$(".membership_fields").show();
			} else {
				$(".membership_fields").hide();
			}
		}
		
		function f_insertCouponTypeSelect() {
			if ($("#coupon_type").val() === 'rate') {
				$(".rate-fields").show();
				$(".price-fields").hide();
			} else {
				$(".rate-fields").hide();
				$(".price-fields").show();
			}
		}
		function f_updateCouponTypeSelect() {
			if ($("#update_coupon_type").val() === 'rate') {
				$(".rate-fields").show();
				$(".price-fields").hide();
			} else {
				$(".rate-fields").hide();
				$(".price-fields").show();
			}
		}
		
		function f_cancelBtnClick() {
			$(".add-coupon-modal-box").fadeOut(500);
			$(".update-coupon-modal-box").fadeOut(500);
			$(".modal_bg").fadeOut(500);
		}
		
		function f_confirmBtnClick() {
			$(".insert-result-modal-box").fadeOut(500);
			$(".delete-result-modal-box").fadeOut(500);
			$(".update-result-modal-box").fadeOut(500);
			$(".modal_bg").fadeOut(500);
		}
		
		/* 선택한 쿠폰 수정하는 함수 */
		function f_updateBtnClick() {
			var data = $(this).parent().parent();
			var form = $("#update_form");
			
			var coupon_id = data.find("input[class='coupon_id']").val();
			var title = data.find(".coupon-title").text().slice(5);
			var option = data.find(".coupon-option").val();
			var coupon_type = null;
			var coupon_rate = Number(data.find(".discount-rate-input").val());
			console.log(coupon_rate);
			var coupon_price = Number(data.find(".coupon-price-input").val());
			var membership_id = data.find(".coupon-target").text();
			if(coupon_rate != NaN && coupon_rate > 0 ) {
				coupon_type = 'rate';
			} else {
				coupon_type = 'amount';
			}
			
			form.find("#update_coupon_id").val(coupon_id);
			form.find("#update_option").val(option).prop("selected", true);
			form.find("#update_option_input").val(option);
			form.find("#update_membership_id").val(membership_id).prop("selected", true);
			form.find("#update_coupon_type").val(coupon_type).prop("selected", true);
			form.find("#update_coupon_name").val(title);
			form.find("#update_discount_rate").val(coupon_rate);
			form.find("#update_max_discount").val(coupon_price);
			form.find("#update_discount_price").val(coupon_price);
			
			f_updateCouponOptionSelect();
			f_updateCouponTypeSelect();
			
			$(".update-coupon-modal-box").fadeIn(500);
			$(".modal_bg").fadeIn(500);
		}
		
		/* 선택한 쿠폰 삭제하는 함수 */
		function f_deleteBtnClick() {
			var deleteNum = $(this).parent().parent().find(".coupon_id").val();
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
					
					$(".modal_bg").fadeIn(500);
					$(".delete-result-modal-box").fadeIn(500);
				}
			});
		}
		
		function f_deleteConfirmClick() {
			$(".delete-result-modal-box").fadeOut(500);
			$(".modal_bg").fadeOut(500);
			setTimeout(() => {
				location.href="${path}/admin/couponList.do";
			}, 500);
			
		}
		
		/* form 제출 버튼 클릭시 데이터 validation 검증 */
		function f_formSubmitBtnClick(event) {
			console.log(event.target);
			var type = $(event.target).find("select[name='type']");
			var discount_rate = $(event.target).find("input[name='discount_rate']");
			var max_discount = $(event.target).find("input[name='max_discount']");
			var discount_price = $(event.target).find("input[name='discount_price']");
			
			console.log("discount_rate="+discount_rate.val());
			console.log("max_discount="+max_discount.val());
			console.log("discount_price="+discount_price.val())
			
			if(type.val() == 'rate') {
				console.log("11");
				if(discount_rate.val()<=0 || discount_rate.val() > 100){
					/* console.log($(event.target).find(".rate-fields:first-child .note").text()); */
					alert("할인율은 1 ~ 100사이의 숫자만 입력 가능합니다.");
					discount_rate.focus();
					console.log("22");
				}
				else if(max_discount.val() <=0 || max_discount.val() > 1000000) {
					alert("최대할인금액은 1 ~ 1,000,000사이의 숫자만 입력 가능합니다.");
					max_discount.focus();
					console.log("33");
				} else {
					return true;
				}
				console.log("44");
				return false;
			} else if(type.val() == 'amount') {
				console.log("55");
				if(discount_price.val() <=0 || discount_price.val() > 1000000) {
					alert("할인금액은 1 ~ 1,000,000사이의 숫자만 입력 가능합니다.")
					discount_price.focus();
					console.log("66");
					return false;
				}
			}
			console.log("77");
		}
		
</script>
</body>
</html>