package com.shinhan.travelTogether.chatting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.shinhan.travelTogether.funding.FundingDTO;

@Repository
public class ChatDAO {
	@Autowired
	SqlSession sqlSession;
	
	Logger logger = LoggerFactory.getLogger(ChatDAO.class);
	String namespace = "com.shinhan.travelTogether.chatting.";
	
	public List<ChatDTO> getChatList(int fundingId) {
		return sqlSession.selectList(namespace + "getChatList", fundingId);
	}
	
	public List<ChatDTO> submit(int fundingId, String message_context, Integer member_id) {
		Map<String, Object> params = new HashMap<>();
        params.put("funding_id", fundingId);
        params.put("content", message_context);
        params.put("member_id", member_id);
        
		return sqlSession.selectList(namespace + "submit", params);
	}
	

	public List<FundingDTO> getChatRoom(int memberId){
		return sqlSession.selectList(namespace + "getChatRoom", memberId);
	}
	
	public List<Object> openRoomCheck(int fundId, int memId) {
		Map<String, Object> params = new HashMap<>();
	    params.put("fundId", fundId);
	    params.put("memId", memId);
		return sqlSession.selectList(namespace + "openRoomCheck", params);
	}
}
