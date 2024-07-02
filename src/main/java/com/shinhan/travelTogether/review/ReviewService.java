package com.shinhan.travelTogether.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	public List<ReviewDTO> selectMyreviewByFundingId() { //X
		return reviewDao.selectMyreviewByFundingId();
	}
	
	public int insertMyreview(ReviewDTO reviewDto) { //X
		return reviewDao.insertMyreview(reviewDto);
	}
	
	public List<ReviewDTO> selectMyreviewByFundingName(ReviewDTO reviewDto) {
		return reviewDao.selectMyreviewByFundingName(reviewDto);
	}
	
	public List<ReviewDTO> selectMyWritableReview(int member_id) {
		return reviewDao.selectMyWritableReview(member_id);
	}
}
