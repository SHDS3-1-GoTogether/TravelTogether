package com.shinhan.travelTogether.notification;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class NotificationService {

	@Autowired
	NotificationDAO notificationDao;
	
	@Autowired
	NotificationController notificationController;
	
	public int insertNotification(NotificationDTO notification) {
		notificationController.sendNotification(notification.getMember_id(), notification.getMessage_content());
		int notification_id = notificationDao.insertNotification(notification);
		return notification_id;
	}

	public List<NotificationDTO> selectAll() {
		return notificationDao.selectAll();
	}
}
