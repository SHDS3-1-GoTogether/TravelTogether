package com.shinhan.travelTogether.notification;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.shinhan.travelTogether.member.MemberDAOMybatis;

@Service
public class NotificationService {

	@Autowired
	MemberDAOMybatis memebrDao;
	
	@Autowired
	NotificationDAO notificationDao;
	
	@Autowired
	NotificationController notificationController;
	
	public int insertNotification(NotificationDTO notification) {
		int notification_id = notificationDao.insertNotification(notification);
		System.out.println(notification_id);
		//NotificationDTO new_notification = selectById(notification_id);
		//notificationController.sendNotification(new_notification);
		return notification_id;
	}

	private NotificationDTO selectById(int notification_id) {
		return notificationDao.selectById(notification_id);
	}

	public List<NotificationDTO> selectAll() {
		return notificationDao.selectAll();
	}

	public List<NotificationDTO> selectByMemberId(Integer member_id) {
		return notificationDao.selectByMemberId(member_id);
	}

	public SseEmitter subscribe(Integer member_id) {
		// 1. ���� Ŭ���̾�Ʈ�� ���� sseEmitter ��ü ����
		SseEmitter sseEmitter = new SseEmitter(Long.MAX_VALUE);
		
		// 2. ����
		try {
			sseEmitter.send(SseEmitter.event().name("connect"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// 3. ����
		NotificationController.emitters.put(member_id, sseEmitter);
		
		// 4. ���� ���� ó��
		sseEmitter.onCompletion(() -> NotificationController.emitters.remove(member_id));	// sseEmitter ������ �Ϸ�� ���
		sseEmitter.onTimeout(() -> NotificationController.emitters.remove(member_id));	// sseEmitter ���ῡ Ÿ�Ӿƿ��� �߻��� ���
		sseEmitter.onError((e) -> NotificationController.emitters.remove(member_id));	// sseEmitter ���ῡ ������ �߻��� ���
		
		return sseEmitter;
	}
	
	public void notifyMessage(Integer member_id) {
		NotificationDTO receiveNotification = notificationDao.selectFirstByMemberIdOrderBySendDateDesc(member_id);
		if(receiveNotification == null) {
			return;
		}
		
		if(NotificationController.emitters.containsKey(member_id)) {
			SseEmitter sseEmitterReceiver = NotificationController.emitters.get(member_id);
			// �˸� �޽��� ���� �� ��ü
			try {
				Map<String, Object> eventData = new HashMap<>();
				eventData.put("send_date", receiveNotification.getSend_date());
				eventData.put("message_content", receiveNotification.getMessage_content());
				sseEmitterReceiver.send(SseEmitter.event().name("notification").data(eventData));
			} catch (IOException e) {
				NotificationController.emitters.remove(member_id);
			}
		}
	}
}
