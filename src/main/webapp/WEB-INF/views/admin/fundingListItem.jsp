<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="funding" items="${fundinglist}">
	<div class="data">
		<p class="funding_id">${funding.funding_id}</p>
		<p class="funding-writer">${funding.nickname}</p>
		<p class="funding-title">
			<a href="fundingDetail.do?funding_id=${funding.funding_id}">${funding.title}</a>
		</p>
		<p class="funding-area">${funding.area}</p>
		<p class="funding-deadline">${funding.deadline}</p>
		<p class="funding-people-num">${funding.people_num}</p>
		<input type="hidden" value="${funding.funding_state}">
		<p class="funding-process-state"></p>
		<p class="funding-confirm-state">
			<button class='confirm-button' onclick='f_confirmBtnClick(${funding.funding_id})'>컨펌하기</button>
		</p>
	</div>
</c:forEach>
<script>
	$(function(){
		init();	
	});
	
	function init(){
		$(".data").each(function(index) {
			var funding_id = Number($(this).find(".funding_id"));
			var confirm_state = $(this).find(".funding-confirm-state");
			var process_state = $(this).find(".funding-process-state");
			var funding_state = $(this).find("input[type='hidden']").val();
			
			if(funding_state == 0) {	// 컨펌대기
				/* confirm_state.html(`<button class='confirm-button' onclick='f_confirmBtnClick(funding_id)'>컨펌하기</button>`); */
			} else if(funding_state == 1) {	// 컨펌완료
				confirm_state.html("컨펌완료");
				confirm_state.addClass("confirm-complete");
				process_state.html("진행중");
				process_state.addClass("funding-ongoing");
			} else if(funding_state == 2) {	// 컨펌실패
				confirm_state.html("컨펌실패");
				confirm_state.addClass("confirm-fail");
			} else if(funding_state == 3) {	// 펀딩성공
				confirm_state.html("컨펌완료");
				confirm_state.addClass("confirm-complete");
				process_state.html("펀딩성공");
				process_state.addClass("funding-success");
			} else if(funding_state == 4) {	// 펀딩실패
				confirm_state.html("컨펌완료");
				confirm_state.addClass("confirm-complete");
				process_state.html("펀딩실패");
				process_state.addClass("funding-fail");
			}
		});
	}
	
	function f_confirmBtnClick(funding_id){	// 컨펌하기 버튼 클릭시 호출
		if(funding_id == null){
			alert("잘못된 요청입니다.");
		} else {
			location.href="fundingDetail.do?funding_id="+funding_id;
		}
	}
</script>
