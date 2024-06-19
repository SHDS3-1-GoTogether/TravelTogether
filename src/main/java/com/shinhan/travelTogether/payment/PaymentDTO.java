package com.shinhan.travelTogether.payment;

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
public class PaymentDTO {
	private int payment_id;
	private Date date;
	private int price;
	private int refund;
	private String payment_method;
	private int classification;
	
	private int member_id;
	private int funding_id;
	private int coupon_record_id;

}
