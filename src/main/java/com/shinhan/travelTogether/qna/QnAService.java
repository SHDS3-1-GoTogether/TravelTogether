package com.shinhan.travelTogether.qna;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QnAService {
	
	@Autowired
	QnADAO qnaDao;
	
	//사용자 QnA 리스트 조회
		public List<UserQnADTO> selectAllUserQnA(int userId){
			return qnaDao.selectAllUserQnA(userId);
		}
}
