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
	
	int funding_id;
	String title;
	String funding_content;
	Date create_date;
	String area;
	Date start_date;
	Date end_date;
	Date deadline;
	int price;
	String departure;
	String traffic;
	String accommodation;
	int people_num;
	int funding_state;
	int confirm_option;
	int views;
	int member_id;

}
