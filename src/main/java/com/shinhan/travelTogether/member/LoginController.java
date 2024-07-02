package com.shinhan.travelTogether.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/auth")
public class LoginController {
	
	@Autowired
	MemberService mService;
	
	Logger logger = LoggerFactory.getLogger(LoginController.class);
	
	@GetMapping("/login.do")
	public void loginDisplay() {
		logger.debug("login.do요청(debug)");
		logger.info("login.do요청(info)");
		logger.warn("login.do요청(warn)");
		logger.error("login.do요청(error)");
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:login.do";
	}
	
	@PostMapping("/login.do")
	public String loginCheck(@RequestParam("login_id") String login_id, @RequestParam("login_pwd") String login_pwd,
			HttpSession session, HttpServletRequest request) {
		System.out.println("로그인체크");
		MemberDTO member = mService.loginChk(login_id, login_pwd);
		if (member == null) {
			session.setAttribute("loginResult", "존재하지 않은 ID입니다.");
			return "redirect:login.do";			
		}else if(!member.getLogin_pwd().equals(login_pwd)) {
			session.setAttribute("loginResult", "password오류입니다.");
			return "redirect:login.do";			
		}else {
			//로그인 성공
			System.out.println("성공");
			session.setAttribute("loginResult", "login성공");
			session.setAttribute("member", member);
			String goPage;
			
			if(member.getIs_manager()) {	// 관리자가 로그인한 경우
				goPage = "/admin/dashboard.do";	// 관리자 페이지로 이동
			} else {	// 일반 회원 로그인한 경우
				String lastRequest = (String)session.getAttribute("lastRequest");
				
				if(lastRequest==null) {
					//처음부터 로그인 요청
					goPage = "../";
				}else {
					//로그인없이 다른 페이지를 요청
					int length = request.getContextPath().length();
					goPage = lastRequest.substring(length);
					String queryString = (String)session.getAttribute("queryString");
					if(queryString!=null) goPage = goPage + "?" + queryString;
				}
			}
			
			return "redirect:" + goPage;
		}
	}
}
