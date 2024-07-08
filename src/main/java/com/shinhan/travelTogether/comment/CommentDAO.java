package com.shinhan.travelTogether.comment;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class CommentDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	String namespace = "com.shinhan.travelTogether.comment.";
	
	public List<CommentDTO> selectAllComment(int review_id) {
		List<CommentDTO> commentlist = sqlSession.selectList(namespace+"selectAllComment", review_id);
		return commentlist;
	}
	
	public int insertComment(CommentDTO commentDto) {
		int result = sqlSession.insert(namespace + "insertComment", commentDto);
		return result;
	}
	
	public  int updateComment(CommentDTO commentDto) {
		int result = sqlSession.update(namespace + "updateComment", commentDto);
		return result;
	}
	
	public int deleteComment(int comment_id) {
		int result = sqlSession.delete(namespace + "deleteComment", comment_id);
		return result;
	}

}
