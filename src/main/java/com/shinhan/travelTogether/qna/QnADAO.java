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
	
	//����� QnA ����Ʈ ��ȸ
	public List<UserQnADTO> selectAllUserQnA(int userId){
		List<UserQnADTO> qnalist = sqlSession.selectList(namespace + "selectAllUserQnA", userId);
		logger.info("<selectAllUserQnA> " + qnalist.size() + "�� QnA ��ȸ");
		return qnalist;
	}
	
	//����� QnA ���
	public int insertUserQnA(UserQnADTO userQnADto) {
		int result = sqlSession.insert(namespace + "insertUserQnA", userQnADto);
		logger.info(result==1? "** QnA��� ���� **" : "** QnA��� ���� **");
		return result;
	}
	
	//����� QnA ����
	public int updateUserQnA(UserQnADTO userQnADto) {
		int result = sqlSession.update(namespace + "updateUserQnA", userQnADto);
		logger.info(result==1? "** QnA���� ���� **" : "** QnA���� ����**");
		return result;
	}
	
	//����� QnA ����
	public int deleteUserQnA(int qna_id) {
		int result = sqlSession.delete(namespace + "deleteUserQnA", qna_id);
		logger.info(result==1? " ** QnA���� ���� **" : "** QnA���� ���� **");
		return result;
	}
	
	//������ QnA ����Ʈ ��ȸ
	public List<UserQnADTO> selectAllAdminQnA() {
		List<UserQnADTO> qnalist = sqlSession.selectList(namespace + "selectAllAdminQnA");
		logger.info("<selectAllAdminQnA> " + qnalist.size() + "�� QnA ��ȸ");
		return qnalist;
	}
	
	//������ QnA ������Ʈ
	public int updateAdminQnA(UserQnADTO userQnADto) {
		int result = sqlSession.update(namespace + "updateAdminQnA", userQnADto);
		logger.info(result==1? "** Admin QnA������Ʈ ���� **" : "** Admin QnA������Ʈ ���� **");
		return result;
	}
}
