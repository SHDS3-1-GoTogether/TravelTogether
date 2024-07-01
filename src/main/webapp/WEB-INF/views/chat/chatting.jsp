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
	<div class="container">
		<div class="EnterOut_div">
			<input type="text" id="user" class="form-control" placeholder="유저명">
			<button type="button" class="btn btn-default enter_Btn"
				id="btnConnect">연결</button>
			<button type="button" class="btn btn-default out_Btn"
				id="btnDisconnect" disabled>종료</button>
		</div>
		<div id="chat">
			<c:forEach var="message" items="${beforeChat}">
				<p>${message.message_id}</p>
				<p>${message.message_content}</p>
				<p>${message.send_date}</p>
			</c:forEach>
		</div>
		<div class="input_Btn input_wrap">
			<input type="text" name="msg" id="msg" placeholder="대화 내용을 입력하세요."
				class="form-control" disabled>
			<button class="btn_send">전송</button>
		</div>
	</div>
	<script>
		var ws;

		function connectWebSocket(url) {
			ws = new WebSocket("ws://" + location.host + "/" + url);
			ws.onopen = function(evt) {
				console.log(ws);
				console.log("url:"+url);
				ws.send('1#' + $('#user').val() + '#');
				$('#user').attr('readonly', true);
				$('#btnConnect').attr('disabled', true);
				$('#btnDisconnect').attr('disabled', false);
				$('#msg').attr('disabled', false);
				
				// 연결 후 마감일 + 7일 뒤에 연결 끊기 타이머 시작
		        startDisconnectTimer();
			};
			
			function startDisconnectTimer() {
				//funding정보 가져오기ㅣ
			    $.ajax({
	                url: "${path}/getFunding",
	                type: "GET",
	                data: { fundId: chatId },
	                success: function(response) {
	                    endDate = response;
	                    console.log("aaaaaaaaa"+endDate);
	                    
	                    var currentTime = getCurrentTimeInMilliseconds();
	                    var time = endDate - currentTime + 604800000;

	                    console.log("지금: " + currentTime);
	                    console.log("마감일: " + endDate);
	                    console.log("타이머: " + time);

	                    if (time > 0) {
	                        timerId = setTimeout(function() {
	                            console.log('여행 마지막 + 7일 후 웹소켓이 닫힙니다.');
	                            console.log("타임:"+time);
	                            //ws.close();
	                        }, time);
	                    } else {
	                        console.error("타이머가 0 또는 음수입니다. 즉시 웹소켓을 닫습니다.");
	                        ws.close();
	                    }
	                },
	                error: function(xhr, status, error) {
	                    console.error("Error: " + error);
	                }
	            });
			    
				 function getCurrentTimeInMilliseconds() {
			            var now = new Date();
			            return now.getTime();
			        }

				/*  timerId = setTimeout(function() {
				        console.log('WebSocket connection will be closed after 7 days.');
			            console.log("지금:" + getCurrentTimeInMilliseconds());
			            console.log("마감일:" + endDate);
			            var time = endDate -  getCurrentTimeInMilliseconds() + 604800000;
			            console.log("타이머:" +  time);

				        ws.close();
				    }, 30); // 7일 후 */
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
					txt = evt.data.substring(index + 1);
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
		$(document).ready(
				function() {
					var currentUrl = window.location.pathname;
					 chatId = currentUrl.match(/\/chat\/(\d+)/)[1]; // 정규 표현식을 사용하여 숫자 부분 추출
					$('#btnConnect').attr('data-url',
							'/travelTogether/chatserver/' + chatId);

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

		           
					
//					var url = $(this).data('url');
					var url = '${path}/chatserver/' + chatId;
					console.log("ddddd"+url);
					connectWebSocket(url);
					
				});

		/*  window.onload = function() {
			var url = $(this).data('url');
			connectWebSocket(url);
		};
 */
		     $('#btnConnect').click(function() {
		      if ($('#user').val().trim() == '') {
		          alert('유저명을 입력하세요.'); $('#user').focus();
		      } else {
		          var url = $(this).data('url');
		          console.log(":::::"+url);
		          connectWebSocket(url);
		      }
		  }); 
 
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
			$('#chat').append(temp);
		}

		var isFirstMessage = {};
		function printOther(user, txt) {
			if (txt.trim() == '')
				return;
			let temp = '';
			if (!isFirstMessage[user]) {
				temp += '<div class="coming_user">';
				temp += "'" + user + "' 이(가) 접속했습니다.";
				temp += '</div>';
				isFirstMessage[user] = true;
			}
			temp += '<div class="yourChat_message">';
			temp += '🍟' + user;
			temp += '<div class="your_message_background">';
			temp += '<div class="your_message">' + txt + '</div>';
			temp += ' <span style="font-size:12px;color:#777;margin-bottom: 3px;">'
					+ new Date().toLocaleTimeString([], {
						hour : '2-digit',
						minute : '2-digit'
					}) + '</span>';
			temp += '</div>';
			temp += '</div>';
			$('#chat').append(temp);
		}

		$('#user').keydown(function(event) {
			if (event.keyCode == 13) {
				$('#btnConnect').click();
			}
		});

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

		$('#btnDisconnect').click(function() {
			ws.close();
			$('#user').attr('readonly', false);
			$('#user').val('');
			$('#btnConnect').attr('disabled', false);
			$('#btnDisconnect').attr('disabled', true);
			$('#msg').val('');
			$('#msg').attr('disabled', true);
		});

		function rand(min, max) {
			return Math.floor(Math.random() * (max - min + 1)) + min;
		}

		$(function() {
			var aa = rand(1, 8);
			$("#chat")
					.css(
							{
								"background-image" : `url("${path}/resources/images/sh_character_0\${aa}.png")`,
								"background-size" : "70%", // or "cover"
								"background-repeat" : "no-repeat"
							});
		});
	</script>
</body>
</html>
