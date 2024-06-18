package com.shinhan.travelTogether.member;

import java.io.IOException;
import java.text.ParseException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
 
@Controller
@RequestMapping("/auth")
public class JoinController {

	
	@Autowired
	MemberService mService;

	@GetMapping("/join.do")
	public void joinDisplay() {
	}

	@PostMapping("/join.do")
	public String join(MemberDTO member, RedirectAttributes redirectAttr) throws ParseException {
		int result = mService.insertMember(member);
		String message;
		if (result > 0) {
			message = "join success";
		} else {
			message = "join fail";
		}
		redirectAttr.addFlashAttribute("joinResult", message);

		return "redirect:join.do";
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
}
