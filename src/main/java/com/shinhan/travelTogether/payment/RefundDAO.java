package com.shinhan.travelTogether.payment;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RefundDAO {

	@Autowired
	SqlSession sqlSession;
	
	Logger logger = LoggerFactory.getLogger(PaymentDAO.class);
	
	String nameSpace = "com.shinhan.travelTogether.refund.";
	
	public int insertRefundInfo(String paymentKey, String refundReason) {
		Map<String, Object> params = new HashMap<>();
		params.put("paymentKey", paymentKey);
		params.put("refundReason", refundReason);
		
		return sqlSession.insert(nameSpace + "insertRefundInfo", params);
	}
}
