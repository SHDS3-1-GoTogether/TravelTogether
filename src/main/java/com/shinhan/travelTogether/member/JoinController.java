package com.shinhan.travelTogether.member;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
 
@Controller
@RequestMapping("/auth")
public class JoinController {

	
	@Autowired
	MemberService mService;
	
	@Autowired
	MailService mailService;

	@GetMapping("/join.do")
	public void joinDisplay() {
	}

	@PostMapping("/join.do")
	@ResponseBody
	public Integer join(MemberDTO member) throws ParseException {
		Integer result = mService.insertMember(member);
		return result;
	}

	@GetMapping("/idCheck.do")
	public void memberIdCheck(@RequestParam("login_id") String login_id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MemberDTO member = mService.idDupChk(login_id);
		String message = "1";
		if (member == null) {
			message="0";
		}
		response.getWriter().append(message);
	}
	
	@GetMapping("/sendMail.do")
	@ResponseBody
	public ResponseEntity<?> sendMail(@RequestParam("email") String email, HttpSession session) {
		session.removeAttribute("eCode");
		int eCode = (int)(Math.random() * (900000)) + 100000;
		session.setAttribute("eCode", eCode);
		session.setMaxInactiveInterval(60*10); //10분
		System.out.println(eCode);
		
		mailService.sendMail(email, "Travel Together- 회원가입 인증번호 안내", "안녕하세요. 트래블투게더- 같이가조입니다.", eCode);
		System.out.println("메일 전송 완료");
		return ResponseEntity.ok("메일 전송 완료");
	}
	
	@GetMapping("/checkMail.do")
	public void mailCheck(@RequestParam("emailCode") String emailCode, HttpServletResponse response, HttpSession session) throws IOException {
		String val = session.getAttribute("eCode").toString();
		System.out.println(emailCode);
		System.out.println(val);
		String message = "0";
		if(emailCode.equals(val))
			message = "1";
		response.getWriter().append(message);
	}
}
