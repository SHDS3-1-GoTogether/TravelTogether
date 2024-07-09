package com.shinhan.travelTogether.notification;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.shinhan.travelTogether.member.MemberDTO;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class NotificationController {
	
	public static ConcurrentHashMap<String, SseEmitter> emitters = new ConcurrentHashMap<>();
	public static final Map<String, Object> eventCache = new ConcurrentHashMap<>();

	@Autowired
	NotificationService notificationService;
	
	@GetMapping(value="/notifications/subscribe", produces=MediaType.TEXT_EVENT_STREAM_VALUE)
	public SseEmitter subscribe(
			HttpSession session,
			@RequestHeader(value="Last-Event-ID", required=false, defaultValue="") String lastEventId) {
		Integer member_id = ((MemberDTO)session.getAttribute("member")).getMember_id();
		SseEmitter sseEmitter = notificationService.subscribe(member_id, lastEventId);
		
		return sseEmitter;
	}
	
	// 이전 알림 불러오기
	@GetMapping("/notifications/history")
    public List<NotificationDTO> getNotificationHistory(Integer member_id) {
        return notificationService.selectByMemberId(member_id);
    }

	
}
