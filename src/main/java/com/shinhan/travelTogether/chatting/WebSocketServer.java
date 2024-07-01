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

//@Service  ...�ʼ��ƴ�
//@Service ������̼��� �ش� Ŭ������ �����ϸ�,�� ���� ����� ���õ� ����������Ŭ �̺�Ʈ�� ó���ϵ��� �ϴµ� �ʼ����� ����

//�������� ���� �ǽð� ����� ����� �����ϰ� �ϴ� ���� ���̵��� ������
/*@ServerEndpoint("/chatserver") 
public class WebSocketServer {

	// ���� ä�� ������ ������ Ŭ���̾�Ʈ(WebSocket Session) ���
	private static List<Session> list = new ArrayList<Session>();
	
	@OnOpen //�� ������ ����Ǹ� ȣ��Ǵ� �̺�Ʈ
	public void handleOpen(Session session) {
		list.add(session); // ������ ����		 
	}
	@OnClose
	// �� ������ ������ ȣ��Ǵ� �̺�Ʈ
	public void handleClose(Session session) {
	    list.remove(session);
	}
	@OnError
	//�� ���� ������ ���� �߻��ϴ� �̺�Ʈ
	public void handleError(Throwable t) {

	}

	@OnMessage //Ŭ���̾�Ʈ���� ���� ������ �޽����� ������ ȣ��Ǵ� �̺�Ʈ
	public void handleMessage(String msg, Session session) {
		// �α����� ��: 1#������
		// ��ȭ �� ��: 2������#�޼���
		int index = msg.indexOf("#", 2);
		String no = msg.substring(0, 1);
		String user = msg.substring(2, index);
		String txt = msg.substring(index + 1);
		System.out.println(no);
		System.out.println(user);
		System.out.println(txt);
		if (no.equals("1")) {
			// ������ ���� > 1#�ƹ���
			for (Session s : list) {
				if (s != session) { // ���� �����ڰ� �ƴ� ������ �����
					try {
						s.getBasicRemote().sendText("1#" + user + "#" +txt);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		} else if (no.equals("2")) {
			// ������ �޼����� ����
			for (Session s : list) {
				if (s != session) { // ���� �����ڰ� �ƴ� ������ �����
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

	// ���� ä�� ������ ������ Ŭ���̾�Ʈ(WebSocket Session) ���
	private static Map<String, List<Session>> sessionsMap = new HashMap<>();
	
	@OnOpen //�� ������ ����Ǹ� ȣ��Ǵ� �̺�Ʈ
	public void handleOpen(Session session, @PathParam("fundId") String fundId) {
		 // �ش� fundId�� �����ϴ� ���� ����� �������ų� ���� ����
        List<Session> sessions = sessionsMap.computeIfAbsent(fundId, k -> new ArrayList<>());
        sessions.add(session); // ���� ����� ���� �߰�		 
	}
	@OnClose
	// �� ������ ������ ȣ��Ǵ� �̺�Ʈ
	public void handleClose(Session session, @PathParam("fundId") String fundId) {
		 // �ش� fundId�� �����ϴ� ���� ��Ͽ��� ���� ����
        List<Session> sessions = sessionsMap.get(fundId);
        if (sessions != null) {
            sessions.remove(session); // ���� ����
            if (sessions.isEmpty()) {
                sessionsMap.remove(fundId); // ������ ��� ������ ��� �ʿ��� ����
            }
        }
	}
	@OnError
	//�� ���� ������ ���� �߻��ϴ� �̺�Ʈ
	public void handleError(Throwable t) {
		t.printStackTrace();
	}

	@OnMessage //Ŭ���̾�Ʈ���� ���� ������ �޽����� ������ ȣ��Ǵ� �̺�Ʈ
	public void handleMessage(String msg, Session session, @PathParam("fundId") String fundId) {
		
		List<Session> sessions = sessionsMap.get(fundId);
		// �α����� ��: 1#������
		// ��ȭ �� ��: 2������#�޼���
		int index = msg.indexOf("#", 2);
		String no = msg.substring(0, 1);
		String user = msg.substring(2, index);
		String txt = msg.substring(index + 1);
		System.out.println(no);
		System.out.println(user);
		System.out.println(txt);
		if (no.equals("1")) {
			// ������ ���� > 1#�ƹ���
			for (Session s : sessions) {
				if (s != session) { // ���� �����ڰ� �ƴ� ������ �����
					try {
						s.getBasicRemote().sendText("1#" + user + "#" +txt + "#"+ fundId);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		} else if (no.equals("2")) {
			// ������ �޼����� ����
			for (Session s : sessions) {
				if (s != session) { // ���� �����ڰ� �ƴ� ������ �����
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