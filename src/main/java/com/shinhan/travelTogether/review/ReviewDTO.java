package com.shinhan.travelTogether.review;

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
public class ReviewDTO {
	private int review_id;
	private String review_content;
	private Date create_date;
	private int like_count;
	private int views;
	private int funding_id;
	private int member_id;
	private String nickname;
}
