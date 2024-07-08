package com.shinhan.travelTogether.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.travelTogether.funding.FundingDTO;

@Service
public class ReviewService {

	@Autowired
	ReviewDAO reviewDao;
	
	public List<ReviewDTO> selectAllReview(){
		return reviewDao.selectAllReview();
	}
	
	public List<ReviewDTO> selectMyreviewAll(int member_id) {
		return reviewDao.selectMyreviewAll(member_id);
	}
	
	public int insertMyreview(ReviewDTO reviewDto) {
		return reviewDao.insertMyreview(reviewDto);
	}
	
	public List<FundingDTO> selectMyWritableReview(int member_id) {
		return reviewDao.selectMyWritableReview(member_id);
	}
	
	/////////////////////////////////////////////////////////////////
	
	public ReviewDTO selectAllMainReview(int review_id) {
		return reviewDao.selectAllMainReview(review_id);
	}
	
	public FundingDTO selectAllMainFunding(int review_id){
		return reviewDao.selectAllMainFunding(review_id);
	}
}
