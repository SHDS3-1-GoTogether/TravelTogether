<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="mypage-menu-wrap">
	<div class="user-membership">
		<p class="membership-header">나의 등급</p>
		<div class="membership-content-wrap">
			<div class="membership-item-wrap">
				<p>
					<i class="fas fa-running"></i>
				</p>
				<p>뚜벅이</p>
			</div>
			<div class="membership-item-wrap">
				<p>
					<i class="fas fa-bicycle"></i>
				</p>
				<p>자전거</p>
			</div>
			<div class="membership-item-wrap">
				<p>
					<i class="fas fa-car-side"></i>
				</p>
				<p>자동차</p>
			</div>
		</div>

	</div>
	<div class="menu-list">
		<ul class="list-group">			
		    <li class="list-group-item">
		    	<a href="${path}/mypage/correction.do" class="menu-link" id="correction-link">
		    		<i class="fas fa-user"></i> 정보수정
		    	</a>
		    </li>
		    <li class="list-group-item">
		    	<a href="" class="menu-link">
		    		<i class="fas fa-suitcase-rolling"></i> 내펀딩
		    	</a>
		    </li>
		    <li class="list-group-item">
		    	<a href="${path}/mypage/reviewList.do" class="menu-link">
		    		<i class="fas fa-pencil-alt"></i> 후기
		    	</a>
		    </li>
		    <li class="list-group-item">
		    	<a href="${path}/mypage/couponList.do" class="menu-link" id="coupon-link">
		    		<i class="fas fa-tags"></i> 쿠폰
		    	</a>
		    </li>
		    <li class="list-group-item">
		    	<a href="${path}/mypage/qnaList.do" class="menu-link" id="qna-link">
		    		<i class="fas fa-question-circle"></i> Q&amp;A
		    	</a>
		    </li>
		    <li class="list-group-item">
		    	<a href="${path}/mypage/notificationList.do" class="menu-link" id="notification-link">
		    		<i class="fas fa-bell"></i> 알림
		    	</a>
		    </li>
		    <li class="list-group-item">
		    	<a href="${path}/mypage/chatroom.do" class="menu-link">
		    		<i class="fas fa-comment-dots"></i> 채팅룸
		    	</a>
		    </li>
		    <li class="list-group-item"><a 
			href="${path}/mypage/paymentList.do" class="menu-link"
			id="payment-link"> <i class="fas fa-receipt"></i> 결제내역
			</a></li>
		  </ul>
	</div>
</div>
<script>
	$(function() {
		var membership = "${member.membership_id}";
		console.log(membership);
		$(".membership-item-wrap").removeClass("my-membership");
		if (membership === 'walker') {
			$(".membership-item-wrap:first-child").addClass("my-membership");
		} else if (membership === 'bicycle') {
			$(".membership-item-wrap:nth-child(2)").addClass("my-membership");
		} else if (membership === 'car') {
			$(".membership-item-wrap:last-child").addClass("my-membership");
		}
	});
</script>