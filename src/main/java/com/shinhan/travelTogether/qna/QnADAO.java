package com.shinhan.travelTogether.qna;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class QnADAO {
	
	@Autowired
	SqlSession sqlSession;
	
	Logger logger = LoggerFactory.getLogger(QnADAO.class);
	String namespace = "com.shinhan.travelTogether.qna.";
	
	//사용자 QnA 리스트 조회
	public List<UserQnADTO> selectAllUserQnA(int userId){
		List<UserQnADTO> qnalist = sqlSession.selectList(namespace + "selectAllUserQnA", userId);
		logger.info("<selectAllUserQnA> " + qnalist.size() + "건 QnA 조회");
		return qnalist;
	}
	
}
