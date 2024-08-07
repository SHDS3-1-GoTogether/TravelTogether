package com.shinhan.travelTogether.payment;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RefundDTO {
	private String payment_id;
	private String payment_date;
	private int price;
	private int refund;
	private String payment_method;
	private String payment_key;
	
	private int member_id;
	private int funding_id;
	private int coupon_record_id;

}
