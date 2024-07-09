package com.shinhan.travelTogether.funding;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter @Setter
public class FundingDTO {
	
	private int funding_id;
	private String title;
	private String funding_content;
	private Date create_date;
	private String area;
	private Date start_date;
	private Date end_date;
	private Date deadline;
	private int price;
	private String departure;
	private String traffic;
	private String accommodation;
	private int people_num;
	private int funding_state;
	private int confirm_option;
	private int views;
	private int member_id;
	private int consumer_num;
}
