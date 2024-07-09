package com.shinhan.travelTogether.qna;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnAService {

	@Autowired
	QnADAO qnaDao;

	// ����� QnA ����Ʈ ��ȸ
	public List<UserQnADTO> selectAllUserQnA(int userId) {
		return qnaDao.selectAllUserQnA(userId);
	}

	// ����� QnA ���
	public int insertUserQnA(UserQnADTO userQnADto) {
		return qnaDao.insertUserQnA(userQnADto);
	}

	// ����� QnA ����
	public int updateUserQnA(UserQnADTO userQnADto) {
		return qnaDao.updateUserQnA(userQnADto);
	}

	// ����� QnA ����
	public int deleteUserQnA(int qna_id) {
		return qnaDao.deleteUserQnA(qna_id);
	}

	// ������ QnA ����Ʈ ��ȸ
	public List<UserQnADTO> selectAllAdminQnA() {
		return qnaDao.selectAllAdminQnA();
	}

	// ������ QnA ������Ʈ
	public int updateAdminQnA(UserQnADTO userQnADto) {
		return qnaDao.updateAdminQnA(userQnADto);
	}
}
