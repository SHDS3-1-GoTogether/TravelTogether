package com.shinhan.travelTogether.coupon;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class AdminCouponDTO { 
	private int coupon_id;
	private String title;
	private int coupon_option;
	private int discount_rate;
	private int max_discount;
	private String membership_id;
}
