<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" href="${path}/resources/css/chatting.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div class="chat-container">
		<div class="EnterOut_div">
			<input type="text" id="user" class="form-control" placeholder="유저명">
		</div>
		<div id="chatting">
			<c:forEach var="message" items="${beforeChat}">
				<c:if test="${message.member_id == member.member_id}">
					<div class="message_container">
						<span style="font-size: 12px; color: #777; margin-bottom: 3px;">
							${message.send_date}</span>
						<div class="message">
							<span class="message_content">${message.message_content}</span>
						</div>
					</div>
				</c:if>
				<c:if test="${message.member_id != member.member_id}">
					<div class="yourChat_message">
						<span class="member_id">🧳 ${message.nickname}</span>
						<div class="your_message_background">
							<div class="your_message">
								<span class="message_content">${message.message_content}</span>
							</div>
							<span style="font-size: 12px; color: #777; margin-bottom: 3px;">${message.send_date}</span>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
		<div class="input_Btn input_wrap">
			<input type="text" name="msg" id="msg" placeholder="대화 내용을 입력하세요."
				class="form-control">
			<button class="btn_send">전송</button>
		</div>
	</div>
	<script>
		function connectWebSocket(url) {
			console.log(location.host);
			if (ws != null) {
				ws.close();
				ws = null;
			}
			ws = new WebSocket("ws://" + location.host + url);
			ws.onopen = function(evt) {
				ws.send('1#' + $('#user').val() + '#');
				$('#user').attr('readonly', true);
				$('#msg').attr('disabled', false);

				// 연결 후 마감일 + 7일 뒤에 연결 끊기 타이머 시작
				startDisconnectTimer();
			};

			function startDisconnectTimer() {
				//funding정보 가져오기
				$.ajax({
							url : "${path}/getFunding",
							type : "GET",
							data : {
								fundId : chatId
							},
							success : function(response) {
								endDate = response;

								var currentTime = getCurrentTimeInMilliseconds();
								var time = endDate - currentTime + 604800000;

								console.log("타이머: " + time);

								// JavaScript의 setTimeout은 최대 2147483647 밀리초(약 24.8일)까지 처리 가능
								var maxTimeout = 2147483647;

								function setLongTimeout(callback, time) {
									if (time > maxTimeout) {
										let iterations = Math.floor(time
												/ maxTimeout);
										let remainder = time % maxTimeout;
										let delay = 0;

										function scheduleNextTimeout(iteration) {
											if (iteration < iterations) {
												setTimeout(
														function() {
															//console.log(`Iteration ${iteration + 1}: ${maxTimeout}ms elapsed`);
															scheduleNextTimeout(iteration + 1);
														}, maxTimeout);
											} else {
												setTimeout(callback, remainder);
											}
										}

										scheduleNextTimeout(0); // 시작점 호출
									} else {
										setTimeout(callback, time);
									}
								}
								setLongTimeout(function() {
									console.log('여행 마지막 + 7일 후 웹소켓이 닫힙니다.');
									ws.close();
								}, time);
							},
							error : function(xhr, status, error) {
								console.error("Error: " + error);
							}
						});

				function getCurrentTimeInMilliseconds() {
					var now = new Date();
					return now.getTime();
				}
			}

			ws.onmessage = function(evt) {
				let no = evt.data.substring(0, 1);
				let user = evt.data.substring(2, evt.data.length - 1);
				let index = evt.data.indexOf("#", 2);
				let txt = evt.data.substring(index + 1);
				if (no == '1') {
					print(user, txt);
				} else if (no == '2') {
					index = evt.data.indexOf(":", 2);
					user = evt.data.substring(2, index);
					let index2 = evt.data.indexOf("#", 2 + index);
					txt = evt.data.substring(index + 1, index2);
					printOther(user, txt);
				}
			};
			ws.onclose = function(evt) {
				console.log('소켓이 닫힙니다.');
			};
			ws.onerror = function(evt) {
				console.log(evt.data);
			};
		}

		var chatId;

		var endDate;

		function print(user, txt) {
			if (txt.trim() == '')
				return;
			let temp = '';
			temp += '<div class="message_container">';
			temp += ' <span style="font-size:12px;color:#777;margin-bottom: 3px;">'
					+ new Date().toLocaleTimeString([], {
						hour : '2-digit',
						minute : '2-digit'
					}) + '</span>';
			temp += '<div class="message_background">';
			temp += '<div class="message">';
			temp += txt;
			temp += '</div>';
			temp += '</div>';
			temp += '</div>';
			$('#chatting').append(temp);
		}

		var isFirstMessage = {};
		function printOther(user, txt) {
			if (txt.trim() == '')
				return;
			let temp = '';
			if (!isFirstMessage[user]) {
				temp += '<div class="coming_user">';
				temp += "🛫  '" + user + "' 이(가) 접속했습니다.  🛬";
				temp += '</div>';
				isFirstMessage[user] = true;
			}
			temp += '<div class="yourChat_message">';
			temp += '🧳' + user;
			temp += '<div class="your_message_background">';
			temp += '<div class="your_message">' + txt + '</div>';
			temp += ' <span style="font-size:12px;color:#777;margin-bottom: 3px;">'
					+ new Date().toLocaleTimeString([], {
						hour : '2-digit',
						minute : '2-digit'
					}) + '</span>';
			temp += '</div>';
			temp += '</div>';
			$('#chatting').append(temp);
		}

		$(".btn_send").on("click", function() {
			let _msg = $("#msg").val();
			ws.send('2#' + $('#user').val() + '#' + _msg);
			print($('#user').val(), _msg);
			$('#msg').val('');
			$('#msg').focus();

			// Save message to server
			$.ajax({
				url : `${path}/chat/${fundingId}/save.do`,
				method : 'POST',
				data : {
					message_content : _msg
				},
				success : function() {
					console.log('Message saved successfully');
				},
				error : function() {
					console.error('Failed to save message');
				}
			});
		});

		$('#msg').keydown(function(event) {
			if (event.keyCode == 13) {
				$(".btn_send").trigger("click");
			}
		});

		$(function() {
			var aa = chatId % 8 + 1;
			$("#chatting")
					.css(
							{
								"background-image" : `url("${path}/resources/images/sh_character_0\${aa}.png")`,
								"background-size" : "50%", // or "cover"
								"background-repeat" : "no-repeat"
							});
		});
	</script>
</body>
</html>