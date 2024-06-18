package com.shinhan.travelTogether.funding;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class FundingService {
	
	@Autowired
	@Qualifier("fundingDAO")
	FundingDAO fundingDAO;
	
	public List<FundingDTO> selectAll(String selectOption) {
		return fundingDAO.selectAll(selectOption);
	}
	
	public List<HashMap<Integer, String>> selectFudingTheme() {
		return fundingDAO.selectFudingTheme();
	}
	
	public int insertFunding(FundingDTO fund) {
		return fundingDAO.insertFunding(fund);
	}

}
