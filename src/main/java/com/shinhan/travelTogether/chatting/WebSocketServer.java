package com.shinhan.travelTogether.chatting;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

//@Service  ...필수아님
//@Service 어노테이션은 해당 클래스를 관리하며,웹 소켓 연결과 관련된 라이프사이클 이벤트를 처리하도록 하는데 필수적인 역할

//웹소켓을 통한 실시간 양방향 통신을 가능하게 하는 서버 사이드의 연결점
/*@ServerEndpoint("/chatserver") 
public class WebSocketServer {

	// 현재 채팅 서버에 접속한 클라이언트(WebSocket Session) 목록
	private static List<Session> list = new ArrayList<Session>();
	
	@OnOpen //웹 소켓이 연결되면 호출되는 이벤트
	public void handleOpen(Session session) {
		list.add(session); // 접속자 관리		 
	}
	@OnClose
	// 웹 소켓이 닫히면 호출되는 이벤트
	public void handleClose(Session session) {
	    list.remove(session);
	}
	@OnError
	//웹 소켓 에러가 나면 발생하는 이벤트
	public void handleError(Throwable t) {

	}

	@OnMessage //클라이언트에서 서버 측으로 메시지를 보내면 호출되는 이벤트
	public void handleMessage(String msg, Session session) {
		// 로그인할 때: 1#유저명
		// 대화 할 때: 2유저명#메세지
		int index = msg.indexOf("#", 2);
		String no = msg.substring(0, 1);
		String user = msg.substring(2, index);
		String txt = msg.substring(index + 1);
		System.out.println(no);
		System.out.println(user);
		System.out.println(txt);
		if (no.equals("1")) {
			// 누군가 접속 > 1#아무개
			for (Session s : list) {
				if (s != session) { // 현재 접속자가 아닌 나머지 사람들
					try {
						s.getBasicRemote().sendText("1#" + user + "#" +txt);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		} else if (no.equals("2")) {
			// 누군가 메세지를 전송
			for (Session s : list) {
				if (s != session) { // 현재 접속자가 아닌 나머지 사람들
					try {
						s.getBasicRemote().sendText("2#" + user + ":" + txt);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}	
}
 */

/*@ServerEndpoint("/chatserver/{fundId}")
public class WebSocketServer {

    private static Map<String, List<Session>> sessionsMap = new HashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("fundId") String fundId) {
        List<Session> sessions = sessionsMap.computeIfAbsent(fundId, k -> new ArrayList<>());
        sessions.add(session);
    }

    @OnClose
    public void onClose(Session session, @PathParam("fundId") String fundId) {
        List<Session> sessions = sessionsMap.get(fundId);
        if (sessions != null) {
            sessions.remove(session);
            if (sessions.isEmpty()) {
                sessionsMap.remove(fundId);
            }
        }
    }

    @OnError
    public void onError(Throwable error) {
        error.printStackTrace();
    }

    @OnMessage
    public void onMessage(String message, Session session, @PathParam("fundId") String fundId) {
        // Handle messages here
    }
}*/


@ServerEndpoint("/chatserver/{fundId}") 
public class WebSocketServer {

	// 현재 채팅 서버에 접속한 클라이언트(WebSocket Session) 목록
	private static Map<String, List<Session>> sessionsMap = new HashMap<>();
	
	@OnOpen //웹 소켓이 연결되면 호출되는 이벤트
	public void handleOpen(Session session, @PathParam("fundId") String fundId) {
		 // 해당 fundId에 대응하는 세션 목록을 가져오거나 새로 생성
        List<Session> sessions = sessionsMap.computeIfAbsent(fundId, k -> new ArrayList<>());
        sessions.add(session); // 새로 연결된 세션 추가		 
	}
	@OnClose
	// 웹 소켓이 닫히면 호출되는 이벤트
	public void handleClose(Session session, @PathParam("fundId") String fundId) {
		 // 해당 fundId에 대응하는 세션 목록에서 세션 제거
        List<Session> sessions = sessionsMap.get(fundId);
        if (sessions != null) {
            sessions.remove(session); // 세션 제거
            if (sessions.isEmpty()) {
                sessionsMap.remove(fundId); // 세션이 모두 닫혔을 경우 맵에서 제거
            }
        }
	}
	@OnError
	//웹 소켓 에러가 나면 발생하는 이벤트
	public void handleError(Throwable t) {
		t.printStackTrace();
	}

	@OnMessage //클라이언트에서 서버 측으로 메시지를 보내면 호출되는 이벤트
	public void handleMessage(String msg, Session session, @PathParam("fundId") String fundId) {
		
		List<Session> sessions = sessionsMap.get(fundId);
		// 로그인할 때: 1#유저명
		// 대화 할 때: 2유저명#메세지
		int index = msg.indexOf("#", 2);
		String no = msg.substring(0, 1);
		String user = msg.substring(2, index);
		String txt = msg.substring(index + 1);
		System.out.println(no);
		System.out.println(user);
		System.out.println(txt);
		if (no.equals("1")) {
			// 누군가 접속 > 1#아무개
			for (Session s : sessions) {
				if (s != session) { // 현재 접속자가 아닌 나머지 사람들
					try {
						s.getBasicRemote().sendText("1#" + user + "#" +txt + "#"+ fundId);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		} else if (no.equals("2")) {
			// 누군가 메세지를 전송
			for (Session s : sessions) {
				if (s != session) { // 현재 접속자가 아닌 나머지 사람들
					try {
						s.getBasicRemote().sendText("2#" + user + ":" + txt + "#"+ fundId);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}	
}