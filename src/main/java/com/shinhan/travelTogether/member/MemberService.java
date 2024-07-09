package com.shinhan.travelTogether.member;

import java.util.List;
import java.util.Map;

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
	
	public List<MemberDTO> selectAllNormal(){
		return memberDAO.selectAllNormal();
	}

	public int updateMember(MemberDTO member) {
		return memberDAO.updateMember(member);
	}
	
	public List<MemberDTO> searchByWord(String word) {
		return memberDAO.searchByWord(word);
	}

	public int countExistingNormalMember() {
		return memberDAO.countExistingNormalMember();
	}
	
	public int countMaleMember() {
		return memberDAO.countMaleMember();
	}
	
	public int countDeletedNormalMember() {
		return memberDAO.countDeletedNormalMember();
	}
	public int getMembershipNum(String membershipId) {
		return memberDAO.getMembershipNum(membershipId);
	}
	
	public int getMoney(){
		return memberDAO.getMoney();
	}
	
	public int getQnaNum() {
		return memberDAO.getQnaNum();
	}
	
	public List<Map<String, Object>> getFundingState() {
		return memberDAO.getFundingState();
	}
	
	public List<Map<String, Object>> getMonthAgoJoinedMemberNum() {
		return memberDAO.getMonthAgoJoinedMemberNum();
	}
	public List<Map<String, Object>> getMonthAgoDeletedMemberNum() {
		return memberDAO.getMonthAgoDeletedMemberNum();
	}
	public int deleteMember(Integer member_id) {
		return memberDAO.deleteMember(member_id);
	}
	
	public MemberDTO selectByMemberId(Integer member_id) {
		return memberDAO.selectByMemberId(member_id);
	}

}
