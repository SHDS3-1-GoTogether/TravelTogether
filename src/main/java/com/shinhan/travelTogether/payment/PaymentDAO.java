package com.shinhan.travelTogether.payment;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.travelTogether.funding.FundingDTO;

@Repository
public class PaymentDAO {
	
	@Autowired
	SqlSession sqlSession;

	Logger logger = LoggerFactory.getLogger(PaymentDAO.class);
	String namespace = "com.shinhan.travelTogether.payment.";
	
	public int insertPaymentInfo(PaymentDTO payment) {
		
		return sqlSession.insert(namespace + "insertPaymentInfo", payment);
	}
	
	public PaymentFundingInfoDTO getFundingInfo(int fundingId) {

		return sqlSession.selectOne(namespace + "getFundingInfo", fundingId);
	}
	
	public List<PaymentDTO> selectAllPayment() {
		List<PaymentDTO> paymentlist = sqlSession.selectList(namespace + "selectAllPayment");
		logger.info("<selectAllPayment>" + paymentlist.size() + "건의 결제 조회");
		return paymentlist;
	}
}
