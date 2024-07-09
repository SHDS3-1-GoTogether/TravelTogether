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
		logger.debug("login.do��û(debug)");
		logger.info("login.do��û(info)");
		logger.warn("login.do��û(warn)");
		logger.error("login.do��û(error)");
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:login.do";
	}
	
	@PostMapping("/login.do")
	public String loginCheck(@RequestParam("login_id") String login_id, @RequestParam("login_pwd") String login_pwd,
			HttpSession session, HttpServletRequest request) {
		System.out.println("�α���üũ");
		MemberDTO member = mService.loginChk(login_id, login_pwd);
		if (member == null) {
			session.setAttribute("loginResult", "�������� ���� ID�Դϴ�.");
			return "redirect:login.do";			
		}else if(!member.getLogin_pwd().equals(login_pwd)) {
			session.setAttribute("loginResult", "password�����Դϴ�.");
			return "redirect:login.do";			
		}else {
			//�α��� ����
			System.out.println("����");
			session.setAttribute("loginResult", "login����");
			session.setAttribute("member", member);
			String goPage;
			
			if(member.getIs_manager()) {	// �����ڰ� �α����� ���
				goPage = "/admin/dashboard.do";	// ������ �������� �̵�
			} else {	// �Ϲ� ȸ�� �α����� ���
				String lastRequest = (String)session.getAttribute("lastRequest");
				
				if(lastRequest==null) {
					//ó������ �α��� ��û
					goPage = "../";
				}else {
					//�α��ξ��� �ٸ� �������� ��û
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
