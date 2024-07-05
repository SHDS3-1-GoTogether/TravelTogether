package com.shinhan.travelTogether.payment;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	public List<HashMap<String, Integer>> getConsumerCount() {
		return paymentDAO.getConsumerCount();
	}

	public List<Map<String, Object>> paymentRecipe(int userId){
		return paymentDAO.paymentRecipe(userId);
	}
}
