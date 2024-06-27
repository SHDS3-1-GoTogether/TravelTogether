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
public class PaymentFundingInfoDTO {
	
	private String title;
	private int price;
	private String applicantNickname;
}
