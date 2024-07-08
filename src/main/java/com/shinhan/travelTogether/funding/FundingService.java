package com.shinhan.travelTogether.funding;

import java.sql.Date;
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
	
	public List<FundingDTO> selectPopular() {
		return fundingDAO.selectPopular();
	}
	
	public List<FundingDTO> selectAll(String selectOption) {
		return fundingDAO.selectAll(selectOption);
	}
	
	public List<HashMap<Integer, String>> selectFudingTheme() {
		return fundingDAO.selectFudingTheme();
	}
	
	public List<FundingDTO> selectByCondition(String search_title, String search_area, int theme, Date search_start, Date search_end){
		return fundingDAO.selectByCondition(search_title, search_area, theme, search_start, search_end);
	}
	
	public int insertFunding(FundingDTO fund) {
		return fundingDAO.insertFunding(fund);
	}
	
	public int getFundingId() {
		return fundingDAO.getFundingId();
	}
	
	public FundingDTO selectFundingById(int funding_id) {
		return fundingDAO.selectFundingById(funding_id);
	}
	
	public int updateViews(int funding_id) {
		return fundingDAO.updateViews(funding_id);
	}

	public List<FundingAdminDTO> selectAllAdminFunding() {
		return fundingDAO.selectAllAdminFunding();
	}

	public int updateFundingState(int funding_id, int update_state) {
		return fundingDAO.updateFundingState(funding_id, update_state);
	}

	public List<FundingAdminDTO> selectByOption(Integer member_type, Integer funding_state) {
		return fundingDAO.selectByOption(member_type, funding_state);
	}
}
