package com.shinhan.travelTogether.qna;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter @Setter @ToString
@AllArgsConstructor
@NoArgsConstructor
public class UserQnADTO {
	private int qna_id;
	private String title;
	private String qna_category;
	private Date create_date;
	private String qna_content;
	private String answer;
	private Date answer_date;
	private int member_id;
}
