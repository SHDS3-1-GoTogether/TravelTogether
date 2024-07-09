package com.shinhan.travelTogether.like;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LikeDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.shinhan.travelTogether.like.";
	
	public int likeReview(LikeDTO likeDto) {
		int result = sqlSession.insert(namespace + "likeReview", likeDto);
		return result;
	}
	
	public int unlikeReview(LikeDTO likeDto) {
		int result = sqlSession.delete(namespace + "unlikeReview", likeDto);
		return result;
	}
	
	public int checkLikeReview(LikeDTO likeDto) {
		return sqlSession.selectOne(namespace + "checkLikeReview", likeDto);
		
	}
	
	public int countLikeReview(int review_id) {
		return sqlSession.selectOne(namespace + "countLikeReview", review_id);
	}
	
	public void toggleLike(LikeDTO likeDto) {
		if(checkLikeReview(likeDto)>0) {
			unlikeReview(likeDto);
		} else {
			likeReview(likeDto);
		}
	}
}
