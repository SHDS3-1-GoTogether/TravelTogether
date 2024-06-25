package com.shinhan.travelTogether.payment;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PaymentDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	SqlSession sqlsession;

	Logger logger = LoggerFactory.getLogger(PaymentDAO.class);
	String namespace = "com.shinhan.travelTogether.payment.";
	
	public int insertPaymentInfo(PaymentDTO payment) {
		
		return sqlSession.insert(namespace + "insertPaymentInfo", payment);
	}
}
