package com.shinhan.travelTogether.notification;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NotificationDAO {

	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.shinhan.travelTogether.notification.";
	
	Logger logger = LoggerFactory.getLogger(NotificationDAO.class);
	
	public int insertNotification(NotificationDTO notification) {
		int notification_id = sqlSession.insert(namespace+"insertNotification", notification);
		logger.info("<insertNotification> "+notification_id+"�� insert �Ϸ�");
		return notification_id;
	}

	public List<NotificationDTO> selectAll() {
		List<NotificationDTO> notificationlist = sqlSession.selectList(namespace+"selectAllNotification");
		logger.info("selectAllNotification> " + notificationlist.size()+"�� ��ȸ �Ϸ�");
		return notificationlist;
	}
}
