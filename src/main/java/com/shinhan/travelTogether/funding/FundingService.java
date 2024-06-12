package com.shinhan.travelTogether.funding;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service
public class FundingService {
	
	@Autowired
	@Qualifier("fundingDAO")
	FundingDAO fundingDAO;
	
	public List<FundingDTO> selectAll() {
		return fundingDAO.selectAll();
	}

}
