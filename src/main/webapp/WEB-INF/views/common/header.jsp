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
		<li><a href="${path}/funding/fundingList.do"><img
				class="menuImage" src="${path}/resources/images/travel1.png"
				alt="일반여행">
				<p>일반펀딩</p></a></li>
		<li><a href="#"><img class="menuImage"
				src="${path}/resources/images/travel2.png" alt="랜덤여행">
				<p>랜덤펀딩</p></a></li>
		<li><a href="#"><img class="menuImage"
				src="${path}/resources/images/review.png" alt="후기">
				<p>후기</p></a></li>
		<li><a href="${path}/admin/dashboard.do"><img class="menuImage"
				src="${path}/resources/images/manager.png" alt="관리자">
				<p>관리자</p></a></li>
		<li><a href="${path}/mypage/correction.do"><img
				class="menuImage" src="${path}/resources/images/mypage.png"
				alt="마이페이지">
				<p>마이페이지</p></a></li>
	</ul>
	<ul class="navbar-menu2" id="navbarMenu2">
		<li><c:if test="${member==null}">
				<a href="${path}/auth/login.do">login</a>
			</c:if> <c:if test="${member!=null}">
				<%-- <img src="${path}/resources/images/profile.png" alt="프로필이미지"
					class="profile_img"> --%>
				<div id="infoHeader">
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
									<h3>알림</h3>
									<p id="plusBtn" class="notification-plus">더보기</p>
								</div>
								<div class="notification-content-wrap">
									<div id="notifications"></div>
								</div>
							</div>
						</div>
						<%-- <a href="${path}/chat" id="notification">
							<i class="far fa-bell"></i>
						</a> --%>
					</div>
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
		var member_id = ${member.member_id}; // 실제 memberId로 설정
		$("#notificationIcon").on("click", togglePopup);
		$(document).on("click", function(event){
			if(!$(event.target).closest("#notificationIcon, #popupMenu").length) {
				$("#popupMenu").hide();
				$("#notificationIcon").attr("aria-expended", "false");
			}
		});
		
		$("#plusBtn").on("click", f_plusBtnClick);
		
        connect(member_id);
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
			$("#notifications").html("");
			loadPreviousNotifications(${member.member_id});
			popupMenu.show();
			$(this).attr("aria-expanded", "true");
		}
		console.log("!!!!!!!!!!!여기!!!!!!!!!!!!!!" + $(".content_wrapper").html())

	}
	
	async function loadPreviousNotifications(member_id) {
		<%--$.ajax({
            url: `${path}/notifications/history`,
            data: { member_id: member_id },
            method: 'GET',
            dataType: 'json',
            success: function(notifications) {
                const notificationDiv = $('#notifications');
                notifications.forEach((notification, index) => {
                	if(index < 5) {
                    	const newNotification = $('<div></div>').text(notification.message_content);
                    	notificationDiv.append(newNotification);
                	}
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.error('Error fetching notifications:', textStatus, errorThrown);
            }
        });--%>
        const response = await fetch("${path}/notifications/history?member_id="+member_id);
        const notifications = await response.json();
        const notificationDiv = document.getElementById('notifications');
        notifications.forEach((notification, index) => {
        	if(index < 10){
        		console.log(notification.message_content);
        		console.log("시간:"+notification.send_date);
            	<%--const newNotification = document.createElement('div');
            	newNotification.textContent = notification.message_content;
            	notificationDiv.appendChild(newNotification);--%>
            	const message = notification.message_content;
            	const send_date = notification.send_date;
            	addNotification(message, 1, send_date);
        	}
        });
	}
	
	function connect(member_id) {
		<%--console.log("member_id="+member_id);
		const eventSource = new EventSource("${path}/notifications/subscribe?member_id="+member_id);
		console.log(eventSource.url);
        eventSource.onmessage = function(event) {
        	var message = event.data;
            console.log('Received notification:', message);
            const notificationDiv = $('#notifications');
            const newNotification = $('<div></div>').text(message);
            notificationDiv.prepend(newNotification); // 새로운 알림을 첫 번째 자식으로 추가
            
         	// 알림이 5개를 초과하면 마지막 알림을 제거
            if (notificationDiv.children().length > 5) {
                notificationDiv.children().last().remove();
            }
        };

        eventSource.onerror = function(event) {
            console.error("EventSource failed: ", event);
            if (eventSource.readyState === EventSource.CLOSED) {
                console.log("Connection was closed. Reconnecting...");
                setTimeout(connect, 60000); // 5초 후 재연결 시도
            }
        };

        eventSource.onopen = function(event) {
            console.log("Connection was opened.");
        };--%>
        
        const eventSource = new EventSource("${path}/notifications/subscribe?member_id="+member_id);
		console.log(eventSource);
        eventSource.addEventListener('notification', function(event) {
        	var data = event.data;
        	const parsedData = JSON.parse(data);	
       		console.log('Received notification:', parsedData);
               <%--const notificationDiv = document.getElementById('notifications');
               const newNotification = document.createElement('div');
               newNotification.textContent = message;
               notificationDiv.insertBefore(newNotification, notificationDiv.firstChild);

               // 알림이 5개를 초과하면 마지막 알림을 제거
               if (notificationDiv.children.length > 5) {
                   notificationDiv.removeChild(notificationDiv.lastChild);
               }--%>
               addNotification(parsedData.message_content, 0, parsedData.send_date);
        	
            
        });

        eventSource.onerror = function(event) {
            console.error("EventSource failed: ", event);
            if (eventSource.readyState === EventSource.CLOSED) {
                console.log("Connection was closed. Reconnecting...");
                setTimeout(connect, 60000); // 5초 후 재연결 시도
            }
        };

        eventSource.onopen = function(event) {
            console.log("Connection was opened.");
        };
    }
	
	function addNotification(message, type, send_date) {
        const notificationDiv = document.getElementById('notifications');
        const newNotification = document.createElement('div');
        const formatDate = formatTimestamp(send_date);
        console.log(send_date);
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
    	console.log("timestamp"+timestamp);
        const date = new Date(timestamp);
        console.log("date"+date);
        const year = date.getFullYear();
        console.log("year"+year);
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
