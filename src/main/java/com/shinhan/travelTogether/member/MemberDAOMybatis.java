package com.shinhan.travelTogether.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
		logger.info(member == null ? "존재하지않는회원" : member.toString());
		return member;
	}
	
	public int insertMember(MemberDTO member) {
		logger.info("DeptDAOMybatis....memberInsert()");
		return sqlSession.insert(namespace + "memberInsert", member);
	}
	
	public MemberDTO idDupChk(String login_id) {
		MemberDTO member = sqlSession.selectOne("com.shinhan.member.loginChk", login_id);
		logger.info(member == null ? "존재하지않는회원=사용가능" : member.toString());
		return member;
	}
	
	
}
