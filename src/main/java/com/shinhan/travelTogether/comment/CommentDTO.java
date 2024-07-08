package com.shinhan.travelTogether.comment;

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
public class CommentDTO {
	private int comment_id;
	private String comment_content;
	private Date create_date;
	private int member_id;
	private int review_id;
	
	private String nickname;
}
