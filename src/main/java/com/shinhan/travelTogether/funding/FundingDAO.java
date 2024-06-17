package com.shinhan.travelTogether.funding;

import java.util.List;

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
			System.out.println("v");
			return sqlSession.selectList(namespace + "selectAllByViews");
		}
		case "selectAllByPriceDesc":  {
			System.out.println("pd");

			return sqlSession.selectList(namespace + "selectAllByPriceDesc");
		}
		case "selectAllByPriceAsc":  {
			System.out.println("pa");

			return sqlSession.selectList(namespace + "selectAllByPriceAsc");
		}
		default: {
			return sqlSession.selectList(namespace + "selectAllByDate");
		}}
	}


	public int insertFunding(FundingDTO fund) {
		int result = sqlSession.insert(namespace + "insertFunding", fund);
		return result;
	}


}
