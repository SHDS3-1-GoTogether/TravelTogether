package com.shinhan.travelTogether.payment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PaymentService {
	
	@Autowired
	PaymentDAO paymentDAO;
	
	public int insertPaymentInfo(PaymentDTO payment) {
		return paymentDAO.insertPaymentInfo(payment);
	}
}
