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
	
	Logger logger = LoggerFactory.getLogger(ReviewDAO.class);
	String namespace = "com.shinhan.travelTogether.review.";
	
	public List<ReviewDTO> selectAllReview(){
		List<ReviewDTO> reviewlist = sqlSession.selectList(namespace+"selectAll");
		logger.info("<selectAllReview> "+reviewlist.size()+"건 후기 조회");
		return reviewlist;
	}
	
	public List<ReviewDTO> selectMyreviewAll(int member_id) {
		List<ReviewDTO> reviewlist = sqlSession.selectList(namespace+"selectMyreviewAll", member_id);
		logger.info("<selectMyreviewAll>" + reviewlist.size()+"건 모든 후기 조회");
		return reviewlist;
	}
	
	public List<ReviewDTO> selectMyreviewByFundingId() {
		List<ReviewDTO> reviewlist = sqlSession.selectList(namespace+"selectMyreviewByFundingId");
		logger.info("<selectMyreviewByFundingId>" + reviewlist.size()+"건의 나의 후기 조회");
		return reviewlist;
	}
	
	public int insertMyreview(ReviewDTO reviewDto) {
		int result = sqlSession.insert(namespace + "insertMyreview", reviewDto);
		logger.info(result==1 ? "** 후기등록 성공" : "** 후기등록 실패 **");
		return result;
	}
	
	public List<ReviewDTO> selectMyreviewByFundingName(ReviewDTO reviewDto) {
		List<ReviewDTO> reviewlist = sqlSession.selectList(namespace+"selectMyreviewByFundingName");
		logger.info("<selectMyreviewByFundingName>" + reviewlist.size() + "건의 나의 후기 title 조회");
		return reviewlist;
	}
	
	public List<ReviewDTO> selectMyWritableReview(int member_id) {
		List<ReviewDTO> reviewlist2 = sqlSession.selectList(namespace+"selectMyWritableReview", member_id);
		logger.info("<selectMyWritableReview>" + reviewlist2.size() + "건의 작성가능한 후기");
		return reviewlist2;
	}
	
}
