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
		logger.info("<selectAllReview> "+reviewlist.size()+"�� �ı� ��ȸ");
		return reviewlist;
	}
	
	public List<ReviewDTO> selectMyreviewAll(int member_id) {
		List<ReviewDTO> reviewlist = sqlSession.selectList(namespace+"selectMyreviewAll", member_id);
		logger.info("<selectMyreviewAll>" + reviewlist.size()+"�� ��� �ı� ��ȸ");
		return reviewlist;
	}
	
	public int insertMyreview(ReviewDTO reviewDto) {
		int result = sqlSession.insert(namespace + "insertMyreview", reviewDto);
		logger.info(result==1 ? "** �ı��� ����" : "** �ı��� ���� **");
		return result;
	}
	
	public List<FundingDTO> selectMyWritableReview(int member_id) {
		List<FundingDTO> reviewlist2 = sqlSession.selectList(namespace+"selectMyWritableReview", member_id);
		logger.info("<selectMyWritableReview>" + reviewlist2.size() + "���� �ۼ������� �ı�");
		return reviewlist2;
	}
	
	// ����󼼺����� ���䳻�� �������� DAO
	public ReviewDTO selectAllMainReview(int review_id) {
		ReviewDTO reviewDetail = sqlSession.selectOne(namespace +"selectAllMainReview", review_id);
		System.out.println("!!!!����󼼺����ݵ�!!! "+reviewDetail);
		logger.info("<selectAllMainReview>" + review_id + "�� ��������� ������");
		return reviewDetail;
	}
	
	// ����󼼺����� �ݵ����� �������� DAO
	public FundingDTO selectAllMainFunding(int review_id){
		FundingDTO fundingDetail = sqlSession.selectOne(namespace+"selectAllMainFunding", review_id);
		System.out.println("!!!!����󼼺����ݵ�!!! "+fundingDetail);
		logger.info("<selectAllMainFunding>" + review_id + "�� �ݵ������� ������");
		return fundingDetail;
	}
	
	public List<ReviewDTO> selectBestReview(){
		return sqlSession.selectList(namespace+"selectBestReview");
	}
	
}
