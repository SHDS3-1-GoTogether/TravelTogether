package com.shinhan.travelTogether.member;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service("mailService")
public class MailService {

	@Autowired
	private JavaMailSender mailSender;
	
	@Async
	public void sendMail(String to , String subject, String body, int eCode)
	{
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8"); 
			//메일 수신 시 표시될 이름 설정
			messageHelper.setFrom("testd6145@gmail.com","Travel_Together");
			messageHelper.setSubject(subject);
			messageHelper.setTo(to);
			body += "<h3>" + "아래의 인증 코드를 회원가입 페이지에 입력해주세요." + "</h3>";
			body += "<h1>" + eCode + "</h1>";
			messageHelper.setText(body,true);
			mailSender.send(message);
			
		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		
	}
}