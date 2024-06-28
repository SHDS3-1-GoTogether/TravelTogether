package com.shinhan.travelTogether.randomFunding;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RandomFundingService {
	
	@Autowired
	RandomFundingDAO rfDAO;
	
	public List<String> getAmountAll(int id){
		
		return rfDAO.getAmountAll(id);
	}

}
