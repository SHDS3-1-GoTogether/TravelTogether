package com.shinhan.travelTogether.chatting;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Chat2DTO {
	private int message_id;
	private String message_content;
	private String nickname;
	private String send_date;
	private String send_time;
	private int member_id;
	private int funding_id; 
}