package com.shinhan.travelTogether.member;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

//VO (Value Object)
//DTO(Data Transfer Object
@AllArgsConstructor
@NoArgsConstructor
@Getter@Setter
@ToString
public class MemberDTO {
	Integer member_id;
	String login_id;
	String login_pwd;
	String username;
	String nickname;
	String phone;
	String email;
	Integer gender; //boolean
	Date birth;
	Boolean is_manager;
	String token;
	Integer acc_amount;
	String membership_id;
}
