package com.shinhan.travelTogether.review;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.shinhan.travelTogether.review.";
	
	Logger logger = LoggerFactory.getLogger(ReviewDAO.class);
	
	public List<ReviewDTO> selectAllReview(){
		List<ReviewDTO> reviewlist = sqlSession.selectList(namespace+"selectAll");
		logger.info("<selectAllReview> "+reviewlist.size()+"건 후기 조회");
		return reviewlist;
	}
}
