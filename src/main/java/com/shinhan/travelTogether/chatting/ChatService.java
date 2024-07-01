package com.shinhan.travelTogether.chatting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shinhan.travelTogether.funding.FundingDTO;
import com.shinhan.travelTogether.payment.PaymentDAO;
import com.shinhan.travelTogether.payment.PaymentDTO;

@Service
public class ChatService {
	
	@Autowired
	ChatDAO chatDao;
	
	public List<ChatDTO> getChatList(int fundingId) {
		return chatDao.getChatList(fundingId);
	}
	
	public List<ChatDTO> submit(int fundingId, String message_content, Integer member_id) {
		return chatDao.submit(fundingId, message_content, member_id);
	}
	
	public List<FundingDTO> getChatRoom(int memberId){
		return chatDao.getChatRoom(memberId);
	}
}
