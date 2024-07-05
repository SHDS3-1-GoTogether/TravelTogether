package com.shinhan.travelTogether.funding;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("fundingDAO")
public class FundingDAO {

	@Autowired
	SqlSession sqlSession;
	String namespace = "com.shinhan.travelTogether.funding.";

	
	Logger logger = LoggerFactory.getLogger(FundingDAO.class);
	
	public List<FundingDTO> selectAll(String selectOption) {
		System.out.println("========");
		switch(selectOption) {
		case "selectAllByViews":  {
			return sqlSession.selectList(namespace + "selectAllByViews");
		}
		case "selectAllByPriceDesc":  {
			return sqlSession.selectList(namespace + "selectAllByPriceDesc");
		}
		case "selectAllByPriceAsc":  {
			return sqlSession.selectList(namespace + "selectAllByPriceAsc");
		}
		default: {
			return sqlSession.selectList(namespace + "selectAllByDate");
		}}
	}
	
	public List<HashMap<Integer, String>> selectFudingTheme() {
		return sqlSession.selectList(namespace + "selectFudingTheme");
	}
	
	public List<FundingDTO> selectByCondition(String search_title, String search_area, int theme, Date search_start, Date search_end) {
		Map<String, Object> option = new HashMap<>();
		option.put("search_title", search_title);
		option.put("search_area", search_area);
		option.put("theme", theme);
		option.put("search_start", search_start);
		option.put("search_end", search_end);
		
		List<FundingDTO> fund = sqlSession.selectList(namespace + "selectbyCondition", option);
		
		return fund;
	}


	public int insertFunding(FundingDTO fund) {
		int result = sqlSession.insert(namespace + "insertFunding", fund);
		return result;
	}
	
	public int getFundingId() {
		int result = sqlSession.selectOne(namespace + "getFundingId");
		return result;
	}

	public FundingDTO selectFundingById(int funding_id) {
		return sqlSession.selectOne(namespace + "selectFundingById", funding_id);
	}
	
	public int updateViews(int funding_id) {
		int result = sqlSession.update(namespace + "updateViews", funding_id);
		return result;
	}
	public List<FundingAdminDTO> selectAllAdminFunding() {
		return sqlSession.selectList(namespace+"selectAllAdminFunding");
	}

	public int updateFundingState(int funding_id, int update_state) {
		Map<String, Integer> map = new HashMap<>();
		map.put("funding_id", funding_id);
		map.put("update_state", update_state);
		return sqlSession.update(namespace+"updateFundingState", map);
	}

	public List<FundingAdminDTO> selectByOption(Integer member_type, Integer funding_state) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("member_type", member_type);
		map.put("funding_state", funding_state);
		return sqlSession.selectList(namespace+"selectAdminFundingByOption", map);
	}
}
