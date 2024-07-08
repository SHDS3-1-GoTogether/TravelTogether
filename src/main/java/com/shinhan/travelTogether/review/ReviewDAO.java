package com.shinhan.travelTogether.review;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.travelTogether.funding.FundingDTO;

@Repository
public class ReviewDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	Logger logger = LoggerFactory.getLogger(ReviewDAO.class);
	String namespace = "com.shinhan.travelTogether.review.";
	
	public List<ReviewDTO> selectAllReview(){
		List<ReviewDTO> reviewlist = sqlSession.selectList(namespace+"selectAllReview");
		logger.info("<selectAllReview> "+reviewlist.size()+"건 후기 조회");
		return reviewlist;
	}
	
	public List<ReviewDTO> selectMyreviewAll(int member_id) {
		List<ReviewDTO> reviewlist = sqlSession.selectList(namespace+"selectMyreviewAll", member_id);
		logger.info("<selectMyreviewAll>" + reviewlist.size()+"건 모든 후기 조회");
		return reviewlist;
	}
	
	public int insertMyreview(ReviewDTO reviewDto) {
		int result = sqlSession.insert(namespace + "insertMyreview", reviewDto);
		logger.info(result==1 ? "** 후기등록 성공" : "** 후기등록 실패 **");
		return result;
	}
	
	public List<FundingDTO> selectMyWritableReview(int member_id) {
		List<FundingDTO> reviewlist2 = sqlSession.selectList(namespace+"selectMyWritableReview", member_id);
		logger.info("<selectMyWritableReview>" + reviewlist2.size() + "건의 작성가능한 후기");
		return reviewlist2;
	}
	
	// 리뷰상세보기의 리뷰내용 가져오는 DAO
	public ReviewDTO selectAllMainReview(int review_id) {
		ReviewDTO reviewDetail = sqlSession.selectOne(namespace +"selectAllMainReview", review_id);
		System.out.println("!!!!리뷰상세보기펀딩!!! "+reviewDetail);
		logger.info("<selectAllMainReview>" + review_id + "의 리뷰디테일 가져옴");
		return reviewDetail;
	}
	
	// 리뷰상세보기의 펀딩내용 가져오기 DAO
	public FundingDTO selectAllMainFunding(int review_id){
		FundingDTO fundingDetail = sqlSession.selectOne(namespace+"selectAllMainFunding", review_id);
		System.out.println("!!!!리뷰상세보기펀딩!!! "+fundingDetail);
		logger.info("<selectAllMainFunding>" + review_id + "의 펀딩디테일 가져옴");
		return fundingDetail;
	}
	
	public List<ReviewDTO> selectBestReview(){
		return sqlSession.selectList(namespace+"selectBestReview");
	}
	
}
