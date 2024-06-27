<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SSE Notification</title>
</head>
<body>
	<% request.setCharacterEncoding("UTF-8"); %>
	<h1>${member.member_id} : Server-Sent Events (SSE) Notifications</h1>
    <div id="notifications"></div>

    <script type="text/javascript">
        var member_id = ${member.member_id}; // 실제 memberId로 설정
        
        const eventSource = new EventSource("${path}/notifications/subscribe?member_id="+member_id);
        connect();

        function connect() {
            
            eventSource.addEventListener('notification', function(event) {
                var message = event.data;
                console.log('Received notification:', message);
                // 여기서 알림을 표시하거나 원하는 처리를 수행할 수 있습니다.
                const notificationDiv = document.getElementById('notifications');
                const newNotification = document.createElement('div');
                newNotification.textContent = message;
                notificationDiv.appendChild(newNotification);
            });
        }

        eventSource.addEventListener('error', function(event) {
            console.error('EventSource error:', event);
            if(eventSource.readyState === EventSource.CLOSED){
            	console.log("Connection was closed. Reconnecting...");
            	setTimeout(connect, 60000);
            }
        });
        
        eventSource.addEventListener('close', function(event) {
            console.log('EventSource closed:', event);
        });
        
        /* function connect(){
        	eventSource.onmessage = function(event) {
            	console.log("EventSource success: "+event.data);
                const notificationDiv = document.getElementById('notifications');
                const newNotification = document.createElement('div');
                newNotification.textContent = event.data;
                notificationDiv.appendChild(newNotification);
            };

            eventSource.onerror = function(event) {
                console.error("EventSource failed: ", event);
                if(eventSource.readyState === EventSource.CLOSED){
                	console.log("Connection was closed. Reconnecting...");
                	setTimeout(connect, 5000);
                }
            };
            
         	// 연결이 성공적으로 설정되었을 때의 처리
            eventSource.onopen = function(event) {
                console.log("Connection was opened.");
            };
        } */
    </script>
</body>
</html>