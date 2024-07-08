package com.shinhan.travelTogether.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentService {
	
	@Autowired
	CommentDAO commentDao;
	
	public List<CommentDTO> selectAllComment(int review_id) {
		return commentDao.selectAllComment(review_id);
	}
	
	public int insertComment(CommentDTO commentDto) {
		return commentDao.insertComment(commentDto);
	}
	
	public  int updateComment(CommentDTO commentDto) {
		return commentDao.updateComment(commentDto);
	}
	
	public int deleteComment(int comment_id) {
		return commentDao.deleteComment(comment_id);
	}
}
