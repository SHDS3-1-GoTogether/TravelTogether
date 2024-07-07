<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${path}/resources/css/userCouponList.css" rel="stylesheet">
<link href="${path}/resources/css/mypageMenu.css" rel="stylesheet">
<link href="${path}/resources/css/chatroom.css" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<div class="container">
		<%@ include file="./mypageMenu.jsp"%>
		<div class="mypage-coupon-content">
			<h2>
				<i class="fas fa-user"></i> 채팅룸
			</h2>
			<div class="coupon-content-wrap">
				<h1>${member.nickname }님의 채팅방 목록</h1>
			<div id = "row-css">
				<div id="chatroom">
					<c:forEach var="chat" items="${chatRoom}">
						<a href="${path}/chat/${chat.funding_id}" class="myRoom">
                            ${chat.title} (${chat.people_num})
                            <br> [ ${chat.start_date} ~ ${chat.end_date} ]
                        </a>
					</c:forEach>
				</div>
				<div class="content-view" id="content-view">
                <!-- 여기에 동적으로 페이지를 로드 -->
                페이지로드
            </div>
			</div>
			</div>
		</div>
	</div>
		
	<script>
$(document).ready(function() {
	localStorage.removeItem('selectedRoomId');
	chatId = sessionStorage.getItem('selectedRoomId');
	if (chatId) {
		var chatUrl = '${path}/chat/' + chatId;
		
		// 채팅방 내용 로드
		$.ajax({
			url: chatUrl,
			method: 'GET',
			success: function(response) {
				$('#content-view').html(response);
				// 동적으로 로드한 HTML의 스크립트를 실행하도록 추가
				var link = document.createElement('link');
                link.rel = 'stylesheet';
                link.href = '${path}/resources/css/chatting.css';
                document.head.appendChild(link);
                
                initChatPage(chatId);
                sessionStorage.removeItem('selectedRoomId');
			},
			error: function() {
				alert('채팅방 내용을 불러오는 데 실패했습니다.');
			}
		});
	}
	
    $('#chatroom').on('click', '.myRoom', function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        chatId = url.match(/\/chat\/(\d+)/)[1]; // 정규 표현식을 사용하여 숫자 부분 추출
		//console.log(chatId);
        //console.log("?"+url);
        
        $.ajax({
            url: url,
            method: 'GET',
            success: function(response) {
                $('#content-view').html(response);
             // 동적으로 로드된 콘텐츠에 필요한 스타일시트를 추가
                var link = document.createElement('link');
                link.rel = 'stylesheet';
                link.href = '${path}/resources/css/chatting.css';
                document.head.appendChild(link);
                
                initChatPage(chatId);
            },
            error: function(error) {
                console.log('Error fetching content:', error);
            }
        });
    });
});

// 채팅 소켓 전역 설정
var ws = null;

function initChatPage(chatId) {
	$('#btnConnect').attr('data-url',
			'/travelTogether/chatserver/' + chatId);
	console.log("${member.nickname}");
	console.log("test");
	//$('#user').val(${member.nickname});
	var chatUrl = '${path}/chatserver/' + chatId;
	console.log("ddddd" + chatUrl);
	
	$.ajax({
		url : '${path}/getUsername', // 위에서 작성한 컨트롤러 매핑 URL
		type : 'GET',
		success : function(username) {
			$('#user').val(username); // 가져온 사용자 이름을 input 요소에 설정
		},
		error : function(xhr, status, error) {
			console.error('Failed to get username:', error);
		}
	}); 
	connectWebSocket(chatUrl);
}
</script>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>