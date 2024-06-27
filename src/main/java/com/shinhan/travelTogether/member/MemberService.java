package com.shinhan.travelTogether.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberService {
	
	@Autowired
	MemberDAOMybatis memberDAO;
	
	public MemberDTO loginChk(String login_id, String login_pwd) {
		return memberDAO.loginChk(login_id, login_pwd);
	}
	
	public int insertMember(MemberDTO member) {
		return memberDAO.insertMember(member);
	}

	public MemberDTO idDupChk(String login_id) {
		return memberDAO.idDupChk(login_id);
	}
	
	public List<MemberDTO> selectAllMember(){
		return memberDAO.selectAllMember();
	}

	public int updateMember(MemberDTO member) {
		return memberDAO.updateMember(member);
	}

}
