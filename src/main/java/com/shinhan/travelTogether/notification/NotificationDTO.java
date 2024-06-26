package com.shinhan.travelTogether.notification;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class NotificationDTO {
	private Integer message_id;
	private String message_content;
	private Date send_date;
	private Integer member_id;
}
