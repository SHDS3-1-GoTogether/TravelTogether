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
}
