package com.shinhan.travelTogether.coupon;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter@Setter@ToString
public class UserCouponDTO {
	private int coupon_record_id;
	private int available;
	private Date due_date;
	private int member_id;
	private String title;
	private int discount_rate;
	private int max_discount;
	private int coupon_id;
	private int count;
}
