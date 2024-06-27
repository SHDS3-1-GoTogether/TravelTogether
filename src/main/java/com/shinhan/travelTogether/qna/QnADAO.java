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
	
	//사용자 QnA 등록
	public int insertUserQnA(UserQnADTO userQnADto) {
		int result = sqlSession.insert(namespace + "insertUserQnA", userQnADto);
		logger.info(result==1? "** QnA등록 성공 **" : "** QnA등록 실패 **");
		return result;
	}
	
	//사용자 QnA 수정
	public int updateUserQnA(UserQnADTO userQnADto) {
		int result = sqlSession.update(namespace + "updateUserQnA", userQnADto);
		logger.info(result==1? "** QnA수정 성공 **" : "** QnA수정 실패**");
		return result;
	}
	
	//사용자 QnA 삭제
	public int deleteUserQnA(int qna_id) {
		int result = sqlSession.delete(namespace + "deleteUserQnA", qna_id);
		logger.info(result==1? " ** QnA삭제 성공 **" : "** QnA삭제 실패 **");
		return result;
	}
	
	//관리자 QnA 리스트 조회
	public List<UserQnADTO> selectAllAdminQnA() {
		List<UserQnADTO> qnalist = sqlSession.selectList(namespace + "selectAllAdminQnA");
		logger.info("<selectAllAdminQnA> " + qnalist.size() + "건 QnA 조회");
		return qnalist;
	}
	
	//관리자 QnA 업데이트
	public int updateAdminQnA(UserQnADTO userQnADto) {
		int result = sqlSession.update(namespace + "updateAdminQnA", userQnADto);
		logger.info(result==1? "** Admin QnA업데이트 성공 **" : "** Admin QnA업데이트 실패 **");
		return result;
	}
}
