<%@page import="javax.imageio.plugins.tiff.GeoTIFFTagSet"%>
<%@page import="com.shinhan.travelTogether.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" href="${path}/resources/css/header.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<!--<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet"> -->

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<nav class="navbar" id="tt_header">
	<a class="navbar-brand" href="${path}"> <img
		src="${path}/resources/images/logo.gif" alt="트투">
	</a>
	<ul class="navbar-menu" id="navbarMenu">
		<li>
			<a href="${path}/funding/fundingList.do">
				<img class="menuImage" src="${path}/resources/images/travel1.png" alt="일반여행">
				<p>일반펀딩</p>
			</a>
		</li>
		<li>
			<a href="${path}/randomFunding/schedule.do">
				<img class="menuImage" src="${path}/resources/images/travel2.png" alt="랜덤여행">
				<p>랜덤펀딩</p>
			</a>
		</li>
		<li>
			<a href="${path}/review/reviewList.do">
				<img class="menuImage" src="${path}/resources/images/review.png" alt="후기">
				<p>후기</p>
			</a>
		</li>
		<li>
			<c:if test="${member != null && member.is_manager}">
				<a href="${path}/admin/dashboard.do">
					<img class="menuImage" src="${path}/resources/images/manager.png" alt="관리자">
					<p>관리자</p>
				</a>
			</c:if>
			<c:if test="${member != null && !member.is_manager}">
				<a href="${path}/mypage/correction.do">
					<img class="menuImage" src="${path}/resources/images/mypage.png" alt="마이페이지">
					<p>마이페이지</p>
				</a>
			</c:if>
		</li>
	</ul>
	<ul class="navbar-menu2" id="navbarMenu2">
		<li><c:if test="${member==null}">
				<a href="${path}/auth/login.do">login</a>
			</c:if> <c:if test="${member!=null}">
				<%-- <img src="${path}/resources/images/profile.png" alt="프로필이미지"
					class="profile_img"> --%>
				<div id="infoHeader">
					<c:if test="${!member.is_manager}">
					<div id="icons">
						<a href="${path}/chat" id="chat"> <i
							class="far fa-comment-dots"></i>
						</a>
						<div class="notification-wrap">
							<button type="button" id="notificationIcon" class="notification-btn"
								aria-haspopup="true" aria-expanded="false"
								aria-controls="popupMenu">
								<i class="far fa-bell"></i>
							</button>
							<div id="popupMenu" class="notification-layer" role="menu"
								aria-labelledby="notificationIcon">
								<div class="notification-header">
									<h3 class="header-content">알림</h3>
									<p id="plusBtn" class="notification-plus">더보기</p>
								</div>
								<div class="notification-content-wrap">
									<div id="notifications"></div>
								</div>
							</div>
						</div>
					</div>
					</c:if>
					<div id="loginInfo">
						<span>${member.nickname }님</span> <a href="${path}/auth/logout.do"
							id="logoutLink">logout</a>
					</div>
				</div>
			</c:if></li>
	</ul>
</nav>
<script>
	$(function(){
		<% 
	        Integer member_id = null;
			Boolean is_manager = false;
	        if (session.getAttribute("member") != null) {
	            member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();
	            is_manager = ((MemberDTO) session.getAttribute("member")).getIs_manager();
	        }
	    %>
	    var member_id = <%= member_id %>;
	    var is_manager = <%= is_manager %>
		console.log("=="+member_id);
		
		$("#notificationIcon").on("click", togglePopup);
		$(document).on("click", function(event){
			if(!$(event.target).closest("#notificationIcon, #popupMenu").length) {
				$("#popupMenu").hide();
				$("#notificationIcon").attr("aria-expended", "false");
			}
		});
		
		$("#plusBtn").on("click", f_plusBtnClick);
		
		if(member_id != null && !is_manager) {
			loadPreviousNotifications(member_id);	// 이전 알림 불러오기
        	connect(member_id);			
		}
	});
	
	function f_plusBtnClick() {
		location.href="${path}/mypage/notificationList.do";
	}
	
	function togglePopup() {
		var popupMenu = $("#popupMenu");
		var notificationIcon = $("notificationIcon");
		var isExpanded = $(this).attr("aria-expanded") === "true";
		
		if(isExpanded) {
			popupMenu.hide();
			$(this).attr("aria-expanded", "false");
		} else {
			//$("#notifications").html("");
			//loadPreviousNotifications(${member.member_id});
			popupMenu.show();
			$(this).attr("aria-expanded", "true");
		}

	}
	
	async function loadPreviousNotifications(member_id) {
        const response = await fetch("${path}/notifications/history?member_id="+member_id);
        const notifications = await response.json();
        const notificationDiv = document.getElementById('notifications');
        notifications.forEach((notification, index) => {
        	if(index < 10){
        		console.log(notification.message_content);
        		console.log("시간:"+notification.send_date);
            	const message = notification.message_content;
            	const send_date = notification.send_date;
            	addNotification(message, 1, send_date);
        	}
        });
	}
	
	function connect(member_id) {
        const eventSource = new EventSource("${path}/notifications/subscribe?member_id="+member_id);
		console.log(eventSource);
        eventSource.addEventListener('notification', function(event) {
        	var data = event.data;
        	const parsedData = JSON.parse(data);
            addNotification(parsedData.message_content, 0, parsedData.send_date);
        });

        eventSource.onerror = function(event) {
            if (eventSource.readyState === EventSource.CLOSED) {
                setTimeout(connect, 10000); // 10초 후 재연결 시도
            }
        };

        eventSource.onopen = function(event) {
        };
    }
	
	function addNotification(message, type, send_date) {
        const notificationDiv = document.getElementById('notifications');
        const newNotification = document.createElement('div');
        const formatDate = formatTimestamp(send_date);
        newNotification.className = 'notification';
        newNotification.innerHTML = `
            <div class="notification-content">
                <p>` + message + `</p>
                <p>` + formatDate + `</p>
            </div>
        `;
        if(type === 1) {
        	notificationDiv.appendChild(newNotification);
        } else {
        	notificationDiv.insertBefore(newNotification, notificationDiv.firstChild);
        }

        // 알림이 5개를 초과하면 마지막 알림을 제거
        if (notificationDiv.children.length > 10) {
            notificationDiv.removeChild(notificationDiv.lastChild);
        }
    }
	
    function formatTimestamp(timestamp) {
        const date = new Date(timestamp);
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');

        let hours = date.getHours();
        const minutes = String(date.getMinutes()).padStart(2, '0');
        const ampm = hours >= 12 ? '오후' : '오전';
        hours = hours % 12;
        hours = hours ? hours : 12; // 0시를 12시로 변환

        return year+"-"+month+"-"+day+" "+ampm +" " + hours+":"+minutes;
    }
</script>
