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
		logger.info("<selectAllReview> "+reviewlist.size()+"�� �ı� ��ȸ");
		return reviewlist;
	}
	
	public List<ReviewDTO> selectMyreviewAll(int member_id) {
		List<ReviewDTO> reviewlist = sqlSession.selectList(namespace+"selectMyreviewAll", member_id);
		logger.info("<selectMyreviewAll>" + reviewlist.size()+"�� ��� �ı� ��ȸ");
		return reviewlist;
	}
	
	public List<ReviewDTO> selectMyreviewByFundingId() {
		List<ReviewDTO> reviewlist = sqlSession.selectList(namespace+"selectMyreviewByFundingId");
		logger.info("<selectMyreviewByFundingId>" + reviewlist.size()+"���� ���� �ı� ��ȸ");
		return reviewlist;
	}
	
	public int insertMyreview(ReviewDTO reviewDto) {
		int result = sqlSession.insert(namespace + "insertMyreview", reviewDto);
		logger.info(result==1 ? "** �ı��� ����" : "** �ı��� ���� **");
		return result;
	}
	
	public List<ReviewDTO> selectMyreviewByFundingName(ReviewDTO reviewDto) {
		List<ReviewDTO> reviewlist = sqlSession.selectList(namespace+"selectMyreviewByFundingName");
		logger.info("<selectMyreviewByFundingName>" + reviewlist.size() + "���� ���� �ı� title ��ȸ");
		return reviewlist;
	}
	
	public List<ReviewDTO> selectMyWritableReview(int member_id) {
		List<ReviewDTO> reviewlist2 = sqlSession.selectList(namespace+"selectMyWritableReview", member_id);
		logger.info("<selectMyWritableReview>" + reviewlist2.size() + "���� �ۼ������� �ı�");
		return reviewlist2;
	}
	
}
