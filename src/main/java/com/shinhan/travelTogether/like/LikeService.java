package com.shinhan.travelTogether.like;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikeService {
	
	@Autowired
	LikeDAO likeDao;
	
	public int likeReview(LikeDTO likeDto) {
		return likeDao.likeReview(likeDto);
	}
	
	public int unlikeReview(LikeDTO likeDto) {
		return likeDao.unlikeReview(likeDto);
	}
	
	public int checkLikeReview(LikeDTO likeDto) {
		return likeDao.checkLikeReview(likeDto);
		
	}
	
	public int countLikeReview(int review_id) {
		return likeDao.countLikeReview(review_id);
	}
}
