package com.shinhan.travelTogether.randomFunding;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RandomFundingService {
	
	@Autowired
	RandomFundingDAO rfDAO;
	
	public List<String> getAmountAll(RandomFundingDTO randomgfundingDTO){
		
		return rfDAO.getAmountAll(randomgfundingDTO);
	}
	public List<String> getThemeAll(Map<String, Object> map){
		return rfDAO.getThemeAll(map);
	}
	
	public Integer freeAmount(RandomFundingDTO randomFundingDTO) {
		return rfDAO.freeAmount(randomFundingDTO);
	}
	
	public Integer normalAmount(RandomFundingDTO randomFundingDTO) {
		return rfDAO.normalAmount(randomFundingDTO);
	}
}
