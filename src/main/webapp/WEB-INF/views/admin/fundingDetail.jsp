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
<title>Insert title here</title>
<link rel="stylesheet" href="${path}/resources/css/fundingBase.css">
<link rel="stylesheet" href="${path}/resources/css/fundingDetail.css">
<script src="${path}/resources/js/fundingDetail.js"></script>
<link rel="stylesheet" href="${path}/resources/css/adminMenu.css">
<link rel="stylesheet" href="${path}/resources/css/adminFundingBase.css">
<link href="${path}/resources/css/fundingConfirm.css" rel="stylesheet">
<script>
	let images = new Array();
</script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<div class="admin-content-wrapper">
		<%@ include file="./adminMenu.jsp" %>
		<div class="content">
		<div class="title-content">
			<h1 class="pageTitle">펀딩 상세보기</h1>
			<c:if test="${fund.funding_state == 0}">
				<div class="button-group">
					<button class="btn approve" onclick="f_confirmBtnClick()">승인하기</button>
					<button class="btn reject" onclick="f_rejectBtnClick()">반려하기</button>
				</div>
			</c:if>
		</div>
		<div class="admin-form-wrapper">
			<div class="semi-wrapper">
				<div class="form-left-wrapper">
					<div class="detailContent">
						<div class="detail-title">"${fund.title}"</div>
						<div class="detail-content">${fund.funding_content}</div>
						<c:forEach var="photo" items="${pic}">
		<%-- 					<img alt="${photo}" 
							src="${photo}"
							width="200" height="200"> --%>
							<script>
								images.push("${photo}");	
							</script>
						</c:forEach>	
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
								<div>${fund.start_date}-${fund.end_date}</div>
								
							</li>
							<li>
								여행지
								<div>${fund.area}</div>
							</li>
							<li>
								인원
								<div>${fund.people_num}</div>
							</li>
							<li>
								숙소
								<c:if test="${fund.accommodation==null}"><div>미정</div></c:if>
								<div>${fund.accommodation}</div>
							</li>
							<li>
								교통
								<c:if test="${fund.traffic==null}"><div>미정</div></c:if>
								<div>${fund.traffic}</div>	
							</li>
							<li>
								예산
								<div><fmt:formatNumber type="number" maxFractionDigits="3" value="${fund.price}" />원</div>
							</li>
							<li>
								테마<br>
								<c:forEach var="theme" items="${tlist}">
									<c:if test="${theme.funding_id==fund.funding_id}">
										<span>#${theme.title}</span>
									</c:if>
								</c:forEach>
							</li>
							<li>
								펀딩마감일
								<div>${fund.deadline}</div>
							</li>
						</ul>			
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<!-- 승인 모달창 -->
	<div class="confirm-modal-box">
		<h2>펀딩 승인</h2>
		<p>이 펀딩을 승인하시겠습니까?</p>
		<div class="modal-button-group">
			<button class="cancel-button" onclick="f_modalCancelBtnClick()">취소</button>
			<button class="confirm-button" onclick="f_modalConfirmBtnClick()">확인</button>
		</div>
	</div>
	
	<!-- 승인 완료 모달창 -->
	<div class="confirm-result-modal-box">
		<h2></h2>
		<p></p>
		<button class="confirm-button" onclick="location.href='${path}/admin/fundingList.do'">확인</button>
	</div>
	
	<!-- 반려 모달창 -->
	<div class="reject-modal-box">
		<h2>펀딩 반려</h2>
		<h3>사유 선택</h3>
		<form id="reject-form" action="${path}/admin/fundingConfirm.do">
			<div class="checkbox-group">
				<div class="chekbox-item">
					<input class="check" id="checkTraffic" type="checkbox" name="check" value="1" style='zoom:1.5;'>
					<label for="checkAll">교통</label>
				</div>
				<div class="chekbox-item">
					<input class="check" id="checkAccommodation" type="checkbox" name="check" value="2" style='zoom:1.5;'>
					<label for="checkAll">숙소</label>
				</div>
				<div class="chekbox-item">
					<input class="check" id="checkEtc" type="checkbox" name="check" value="3" style='zoom:1.5;'>
					<label for="checkAll">기타</label>
				</div>
			</div>
			<textarea id="reject-reason-input" rows="5" name="etc_text" disabled></textarea>
			<div class="modal-button-group">
				<button type="button" class="cancel-button" onclick="f_modalCancelBtnClick()">취소</button>
				<button type="button" class="confirm-button" onclick="f_modalRejectBtnClick()">확인</button>
			</div>
		</form>
	</div>
	
	<div class="modal_bg"></div>
	
	<script>
	$(function() {
		menuInit();
		
		$("#checkEtc").on("click", f_checkEtcClick);
	});
	
	function menuInit() {
		var currentUrl = window.location.href;
		
		if (currentUrl.includes("funding")) {
			$("#fundingMenu").addClass("active");
		}
	}
	
	function f_checkEtcClick() {
		if($("#checkEtc").is(":checked")){
			console.log("체크!");
			$("#reject-reason-input").prop("disabled", false);
		} else {
			console.log("노체크!");
			$("#reject-reason-input").prop("disabled", true);
		}
	}
	
	function f_confirmBtnClick() {
		$(".confirm-modal-box").fadeIn(500);
		$(".modal_bg").fadeIn(500);
		
		$("body").addClass("scrollLock");
	}
	
	function f_rejectBtnClick(){
		$(".reject-modal-box").fadeIn(500);
		$(".modal_bg").fadeIn(500);
		
		$("body").addClass("scrollLock");
	}
	
	function f_modalCancelBtnClick() {
		$(".confirm-modal-box").fadeOut(500);
		$(".reject-modal-box").fadeOut(500);
		$(".modal_bg").fadeOut(500);
		
		$(".check").prop("checked", false);
		
		$("body").removeClass("scrollLock");
	}
	
	function f_modalConfirmBtnClick() {
		$(".confirm-modal-box").fadeOut(500);
		
		var funding_id = ${fund.funding_id};
		var member_id = ${fund.member_id}
		$.ajax({
			url: "${path}/admin/fundingConfirm.do",
			type: "post",
			data: {
				funding_id: funding_id,
				member_id: member_id,
				check: [],
				etc_text: null
			},
			success: function(responseData){
				console.log(responseData);
				if(responseData === "1") {
					$(".confirm-result-modal-box h2").text("승인 완료");
					$(".confirm-result-modal-box p").text("컨펌 승인이 완료되었습니다.")
					$(".confirm-result-modal-box").fadeIn(500);
					$("body").addClass("scrollLock");
				} else {
					alert("승인중 오류가 발생하였습니다. 다시 시도해주세요.");
					$(".modal_bg").fadeOut(500);
				}
			}
		});
	}
	
	function f_modalRejectBtnClick() {
		$(".reject-modal-box").fadeOut(500);
		var formData = $("#reject-form").serialize();
		
		var funding_id = ${fund.funding_id};
		var member_id = ${fund.member_id};
	    formData += "&funding_id=" + funding_id;
	    formData += "&member_id=" + member_id;
	    console.log(formData);
		
		var funding_id = ${fund.funding_id};
		$.ajax({
			url: "${path}/admin/fundingConfirm.do",
			type: "post",
			data: formData,
			success: function(responseData){
				console.log(responseData);
				if(responseData === "1") {
					$(".confirm-result-modal-box h2").text("반려 완료");
					$(".confirm-result-modal-box p").text("컨펌 반려가 완료되었습니다.");
					$(".confirm-result-modal-box").fadeIn(500);
					$("body").addClass("scrollLock");
				} else {
					alert("승인중 오류가 발생하였습니다. 다시 시도해주세요.");
					$(".modal_bg").fadeOut(500);
				}
			}
		});
	}
</script>
</body>
</html>