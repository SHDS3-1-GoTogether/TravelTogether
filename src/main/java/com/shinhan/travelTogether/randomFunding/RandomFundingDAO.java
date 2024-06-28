package com.shinhan.travelTogether.randomFunding;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RandomFundingDAO {
	
	@Autowired
	SqlSession session;
	
	private final String namespace = "com.shinhan.travelTogether.randomfunding.";
	
	public List<String> getAmountAll(int id) {
		
//		List<Integer> amounts = session.selectList(namespace+"selectAmountAll", id);
//		if (amounts == null) {
//            throw new NullPointerException("Result list is null");
//        }
//		//System.out.println(amounts);

        return session.selectList(namespace+"selectAmountAll", id);
	}

}
