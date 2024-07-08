package com.shinhan.travelTogether.qna;

import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.travelTogether.member.MemberDTO;

@Controller
@RequestMapping("/mypage")
public class UserQnAController {

	@Autowired
	QnAService qnaService;
	
	Logger logger = LoggerFactory.getLogger(UserQnAController.class);

	@GetMapping("/qnaList.do")
	public void selectAllUserQnA(Model model, HttpSession session, @RequestParam(required = false) Integer category) {
		// 로그인 기능 구현시 수정
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();
		// int userId = 1;
		System.out.println(category);
		List<UserQnADTO> qnalist = qnaService.selectAllUserQnA(member_id);
		System.out.println(qnalist.toString());
		logger.info(qnalist.size() + "건 조회됨");
		model.addAttribute("qnalist", qnalist);
		
		//List<UserQnADTO> qnalist = null;
		if(category == null || category == -1) {
			qnalist = qnaService.selectAllUserQnA(member_id);
		qnalist.forEach(userQnA -> {
			// System.out.println(userQnA.getQna_content());
			String qna_category = null;
			switch (userQnA.getQna_category()) {
			
			case "0": {
				qna_category = "[펀딩문의]";
				break;
			}
			case "1": {
				qna_category = "[결제문의]";
				break;
			}
			case "2": {
				qna_category = "[기타등등]";
				break;
			}
			}
			userQnA.setQna_category(qna_category);

			});
			category = -1;
		} else {
			qnalist = qnaService.selectAllUserQnA(category);
			}

		if (session.getAttribute("insertResult") == null) {
			session.setAttribute("insertResult", -1);
		}
		if (session.getAttribute("deleteResult") == null) {
			session.setAttribute("deleteResult", -1);
		}
		if (session.getAttribute("updateResult") == null) {
			session.setAttribute("updateResult", -1);
		}

		session.setAttribute("category", category);
		model.addAttribute("qnalist", qnalist);
	}

	@PostMapping("/qnaInsert.do")
	public String insertUserQnA(Model model, HttpServletRequest request, RedirectAttributes attr, HttpSession session,
			UserQnADTO qna) {
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();
		qna.setMember_id(member_id);
		int result = qnaService.insertUserQnA(qna);
		attr.addFlashAttribute("insertResult", result);

		return "redirect:qnaList.do";
	}

	@PostMapping("/qnaDelete.do")
	@ResponseBody
	public String deleteUserQnA(HttpServletRequest request) {
		int qna_id = Integer.parseInt(request.getParameter("qna_id"));
		System.out.println(qna_id);
		Integer result = qnaService.deleteUserQnA(qna_id);

		return result.toString();
	}

	@PostMapping("/qnaUpdate.do")
	public String updateUserQnA(Model model, HttpServletRequest request, RedirectAttributes attr, HttpSession session,
			UserQnADTO qna) {
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();
		// UserQnADTO qna = qnaDtoSetting(request);
		qna.setMember_id(member_id);
		int result = qnaService.updateUserQnA(qna);
		attr.addFlashAttribute("updateResult", result);

		return "redirect:qnaList.do";
	}

}
