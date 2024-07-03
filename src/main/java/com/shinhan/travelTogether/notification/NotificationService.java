package com.shinhan.travelTogether.notification;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

	public SseEmitter subscribe(Integer member_id, String lastEventId) {
		// 1. ���� Ŭ���̾�Ʈ�� ���� sseEmitter ��ü ����
		SseEmitter sseEmitter = new SseEmitter(Long.MAX_VALUE);
		String emitterId = member_id + "_" + System.currentTimeMillis();
		
		NotificationController.emitters.put(emitterId, sseEmitter);
		
		// ���� ���� ó��
		sseEmitter.onCompletion(() -> NotificationController.emitters.remove(emitterId));	// sseEmitter ������ �Ϸ�� ���
		sseEmitter.onTimeout(() -> NotificationController.emitters.remove(emitterId));	// sseEmitter ���ῡ Ÿ�Ӿƿ��� �߻��� ���
		sseEmitter.onError((e) -> NotificationController.emitters.remove(emitterId));	// sseEmitter ���ῡ ������ �߻��� ���
		
		// 2. ����
		try {
			String eventId = member_id + "_" + System.currentTimeMillis();
			sseEmitter.send(SseEmitter.event().id(eventId).name("connect"));
		} catch (IOException e) {
			e.printStackTrace();
			NotificationController.emitters.remove(emitterId);
		}
		
		if(!lastEventId.isEmpty()) {
			sendLostData(lastEventId, member_id, emitterId, sseEmitter);
		}
		
		// 3. ����
		
		
		return sseEmitter;
	}
	
	public void sendLostData(String lastEventId, Integer member_id, String emitterId, SseEmitter emitter) {
		Map<String, Object> eventCaches = NotificationController.eventCache.entrySet().stream()
													.filter(entry -> entry.getKey().startsWith(String.valueOf(member_id)))
													.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
		eventCaches.entrySet().stream()
				.filter(entry -> lastEventId.compareTo(entry.getKey()) < 0)
				.forEach(entry -> {
					try {
						emitter.send(SseEmitter.event()
									.id(entry.getKey())
									.name("notification")
									.data(entry.getValue()));
					} catch (IOException e) {
						NotificationController.emitters.remove(emitterId);
					}
				});
	}
	
	public void notifyMessage(Integer member_id) {
		NotificationDTO receiveNotification = notificationDao.selectFirstByMemberIdOrderBySendDateDesc(member_id);
		if(receiveNotification == null) {
			return;
		}
		
		String eventId = member_id + "_" + System.currentTimeMillis();
		Map<String, SseEmitter> emitters = NotificationController.emitters.entrySet().stream()
												.filter(entry -> entry.getKey().startsWith(String.valueOf(member_id)))
												.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
		// member_id�� �ش��ϴ� ��� emitter�� �˸� ������
		emitters.forEach(
				(emitterId, emitter) -> {
					NotificationController.eventCache.put(emitterId, receiveNotification);
					try {
						emitter.send(SseEmitter.event()
									.id(eventId)
									.name("notification")
									.data(receiveNotification));
					} catch (IOException e) {
						NotificationController.emitters.remove(emitterId);
					}
				}
		);
		
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
