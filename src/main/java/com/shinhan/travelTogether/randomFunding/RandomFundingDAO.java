package com.shinhan.travelTogether.randomFunding;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class RandomFundingDAO {
	
	@Autowired
	SqlSession session;
	
	private final String namespace = "com.shinhan.travelTogether.randomfunding.";
	
	public List<String> getAmountAll(RandomFundingDTO randomgfundingDTO) {

        return session.selectList(namespace+"selectAmountAll", randomgfundingDTO);
	}
	
	public List<String> getThemeAll(Map<String, Object> map){
		return session.selectList(namespace + "selectTheme", map);
	}
	
	public Integer freeAmount(RandomFundingDTO randomFundingDTO) {
		return session.selectOne(namespace+"freeAmount", randomFundingDTO);
	}
	
	public Integer normalAmount(RandomFundingDTO randomFundingDTO) {
		return session.selectOne(namespace+"normalAmount", randomFundingDTO);
	}

}
