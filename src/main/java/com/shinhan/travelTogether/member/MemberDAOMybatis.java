package com.shinhan.travelTogether.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOMybatis {

	@Autowired
	SqlSession sqlSession;

	@Autowired
	@Qualifier("dataSource")
	DataSource ds;

	Connection conn;
	PreparedStatement pst;
	ResultSet rs;
	int result;

	String namespace = "com.shinhan.member.";

	Logger logger = LoggerFactory.getLogger(MemberDAOMybatis.class);

	public MemberDTO loginChk(String login_id, String login_pwd) {
		MemberDTO member = sqlSession.selectOne("com.shinhan.member.loginChk", login_id);
		logger.info(member == null ? "鈺곕똻�삺占쎈릭筌욑옙占쎈륫占쎈뮉占쎌돳占쎌뜚" : member.toString());
		return member;
	}

	public int insertMember(MemberDTO member) {
		logger.info("DeptDAOMybatis....memberInsert()");
		return sqlSession.insert(namespace + "memberInsert", member);
	}

	public MemberDTO idDupChk(String login_id) {
		MemberDTO member = sqlSession.selectOne("com.shinhan.member.loginChk", login_id);
		logger.info(member == null ? "鈺곕똻�삺占쎈릭筌욑옙占쎈륫占쎈뮉占쎌돳占쎌뜚=占쎄텢占쎌뒠揶쏉옙占쎈뮟" : member.toString());
		return member;
	}

	public List<MemberDTO> selectAllMember() {
		List<MemberDTO> memberlist = sqlSession.selectList(namespace + "selectAllMember");
		logger.info("<selectAllMember> " + memberlist.size() + "椰꾬옙 占쎌돳占쎌뜚 鈺곌퀬�돳 占쎌끏�뙴占�");
		return memberlist;
	}

	public List<MemberDTO> selectAllNormal() {
		List<MemberDTO> memberlist = sqlSession.selectList(namespace + "selectAllNormal");
		logger.info("<selectAllNormal> " + memberlist.size() + "紐� �쉶�썝 議고쉶 �셿猷�");
		return memberlist;
	}

	public int updateMember(MemberDTO member) {
		logger.info("DeptDAOMybatis....memberUpdate()");
		return sqlSession.insert(namespace + "memberUpdate", member);
	}

	public MemberDTO selectByMemberId(Integer member_id) {
		return sqlSession.selectOne(namespace + "selectByMemberId", member_id);
	}

	public List<MemberDTO> searchByWord(String word) {
		List<MemberDTO> memberlist = sqlSession.selectList(namespace + "searchByCondition", word);
		logger.info("<searchByCondition> " + memberlist.size() + "紐� �쉶�썝 議고쉶 �셿猷�");
		return memberlist;
	}

	public int countExistingNormalMember() {
		int num = sqlSession.selectOne(namespace + "countExistingNormalMember");
		return num;
	}

	public int countMaleMember() {
		int num = sqlSession.selectOne(namespace + "countMaleMember");
		return num;
	}

	public int countDeletedNormalMember() {
		int num = sqlSession.selectOne(namespace + "countDeletedNormalMember");
		return num;
	}

	public int getMembershipNum(String membershipId) {
		int num = sqlSession.selectOne(namespace + "getMembershipNum", membershipId);
		return num;
	}

	public int getMoney() {
		int num = sqlSession.selectOne(namespace + "getMoney");
		return num;
	}
	
	public int getQnaNum() {
		int num = sqlSession.selectOne(namespace + "getQnaNum");
		return num;
	}
	
	public List<Map<String, Object>> getFundingState() {
		List<Map<String, Object>> map = sqlSession.selectList(namespace + "getFundingState");
		return map;
	}

	public List<Map<String, Object>> getMonthAgoJoinedMemberNum() {
		 List<Map<String, Object>> map = sqlSession.selectList(namespace + "getMonthAgoJoinedMemberNum");
		return map;
	}
	
	public List<Map<String, Object>> getMonthAgoDeletedMemberNum() {
		List<Map<String, Object>> map = sqlSession.selectList(namespace + "getMonthAgoDeletedMemberNum");
		return map;
	}

}
