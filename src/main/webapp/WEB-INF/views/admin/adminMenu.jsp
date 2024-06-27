<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="side-menubar">
	<ul class="side-menubar-list">
        <li id="dashboard">
        	<a href="#">
	        	<p><i class="fas fa-home"></i></p>
	        	<p>대시보드</p>
        	</a>
        </li>
        <li id="memberMenu">
        	<a href="#">
	        	<p><i class="fas fa-id-badge"></i></p>
	        	<p>회원관리</p>
        	</a>
        </li>
        <li id="fundingMenu">
        	<a href="#">
	        	<p><i class="fas fa-suitcase-rolling"></i></p>
	        	<p>펀딩관리</p>
        	</a>
        </li>
        <li id="qnaMenu">
        	<a href="#">
	        	<p><i class="fas fa-question-circle"></i></p>
	        	<p>Q&A관리</p>
        	</a>
        </li>
        <li id="notificationMenu">
        	<a href="${path}/admin/notificationList.do">
	        	<p><i class="fas fa-bell"></i></p>
	        	<p>알림</p>
        	</a>
        </li>
        <li id="couponMenu">
        	<a href="${path}/admin/couponList.do">
	        	<p><i class="fas fa-tags"></i></p>
	        	<p>쿠폰</p>
        	</a>
        </li>
    </ul>
</div>
<script>
	$(function(){
		// 페이지 로드 시 현재 URL에 맞는 메뉴 항목에 active 클래스 추가
        var currentPath = window.location.pathname;
        $(".side-menubar-list li a").each(function() {
            var linkPath = $(this).attr("href");
            if (linkPath === currentPath) {
                $(this).parent().addClass("active");
            }
        });
        
	});
	
</script>