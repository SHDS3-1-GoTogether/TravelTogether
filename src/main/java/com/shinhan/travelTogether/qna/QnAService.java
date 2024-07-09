package com.shinhan.travelTogether.qna;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnAService {

	@Autowired
	QnADAO qnaDao;

	// 사용자 QnA 리스트 조회
	public List<UserQnADTO> selectAllUserQnA(int userId) {
		return qnaDao.selectAllUserQnA(userId);
	}

	// 사용자 QnA 등록
	public int insertUserQnA(UserQnADTO userQnADto) {
		return qnaDao.insertUserQnA(userQnADto);
	}

	// 사용자 QnA 수정
	public int updateUserQnA(UserQnADTO userQnADto) {
		return qnaDao.updateUserQnA(userQnADto);
	}

	// 사용자 QnA 삭제
	public int deleteUserQnA(int qna_id) {
		return qnaDao.deleteUserQnA(qna_id);
	}

	// 관리자 QnA 리스트 조회
	public List<UserQnADTO> selectAllAdminQnA() {
		return qnaDao.selectAllAdminQnA();
	}

	// 관리자 QnA 업데이트
	public int updateAdminQnA(UserQnADTO userQnADto) {
		return qnaDao.updateAdminQnA(userQnADto);
	}
}
