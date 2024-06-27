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
		int notification_id = notificationDao.insertNotification(notification);
		NotificationDTO new_notification = selectById(notification_id);
		notificationController.sendNotification(new_notification);
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
}
