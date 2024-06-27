package com.shinhan.travelTogether.payment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.travelTogether.funding.FundingDTO;

@Service
public class PaymentService {
	
	@Autowired
	PaymentDAO paymentDAO;
	
	public int insertPaymentInfo(PaymentDTO payment) {
		return paymentDAO.insertPaymentInfo(payment);
	}
	
	public PaymentFundingInfoDTO getFundingInfo(int fundingId) {
		
		return paymentDAO.getFundingInfo(fundingId);
	}
}
