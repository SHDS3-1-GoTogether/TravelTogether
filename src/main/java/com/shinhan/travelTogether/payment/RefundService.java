package com.shinhan.travelTogether.payment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RefundService {
	
	@Autowired
	RefundDAO refundDAO;
	
	public int insertRefundInfo(String paymentKey, String refundReason) {
		return refundDAO.insertRefundInfo(paymentKey, refundReason);
	}
}
