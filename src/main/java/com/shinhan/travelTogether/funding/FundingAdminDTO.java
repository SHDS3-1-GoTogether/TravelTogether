package com.shinhan.travelTogether.funding;

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
public class FundingAdminDTO {
	private int funding_id;
	private int member_id;
	private String nickname;
	private String title;
	private String area;
	private Date deadline;
	private int people_num;
	private int consumer_num;
	private int funding_state;
}
