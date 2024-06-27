package com.shinhan.travelTogether.notification;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

@RestController
public class NotificationController {
	
	private final ConcurrentHashMap<Integer, List<SseEmitter>> emitters = new ConcurrentHashMap<>();

	@Autowired
	NotificationService notificationService;
	
	Logger logger = LoggerFactory.getLogger(NotificationController.class);
	
	@GetMapping(value="/notifications/subscribe", produces = MediaType.TEXT_EVENT_STREAM_VALUE + "; charset=UTF-8")
	public SseEmitter subscribe(Integer member_id) {
		System.out.println("member_id="+member_id);
		SseEmitter emitter = new SseEmitter(60000L);
		emitters.computeIfAbsent(member_id, k -> new CopyOnWriteArrayList<>()).add(emitter);
		
		emitter.onCompletion(() -> emitters.get(member_id).remove(emitter));
		emitter.onTimeout(() -> emitters.get(member_id).remove(emitter));
		
		return emitter;
	}
	
	@GetMapping("/notifications/history")
    public List<NotificationDTO> getNotificationHistory(Integer member_id) {
        return notificationService.selectByMemberId(member_id);
    }
	
	public void sendNotification(NotificationDTO notification) {
		List<SseEmitter> sseEmitters = emitters.get(notification.getMember_id());
		
		if(sseEmitters != null) {
			for(SseEmitter emitter : sseEmitters) {
				try {
					logger.info("sending notification to member_id : {}, message : {}", notification.getMember_id(), notification.getMessage_content());
					//emitter.send(SseEmitter.event().name("notification").data(content.getBytes(StandardCharsets.UTF_8), MediaType.TEXT_PLAIN));
					emitter.send(SseEmitter.event().name("notification").data(notification));
				} catch (IOException e) {
					logger.error("Error sending notification", e);
					emitter.completeWithError(e);
					emitters.get(notification.getMember_id()).remove(emitter);
				}
			}
		}
	}
	
}
