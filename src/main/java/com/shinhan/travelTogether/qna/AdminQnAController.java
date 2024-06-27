package com.shinhan.travelTogether.qna;

import java.io.UnsupportedEncodingException;
import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin")
public class AdminQnAController {
	
	@Autowired
	QnAService qnaService;
	
	@GetMapping("/qnaList.do")
	public void selectAllAdminQnA(Model model, 
							HttpSession session,
							@RequestParam(required = false) Integer category) {
		System.out.println(category);
		List<UserQnADTO> qnalist = null;
		if(category == null || category == -1) {
			qnalist = qnaService.selectAllAdminQnA();
			qnalist.forEach(adminQnA -> {
				String qna_category = null;
				switch(adminQnA.getQna_category()) {
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
				adminQnA.setQna_category(qna_category);
			});
			category = -1;
			
			if(session.getAttribute("updateResult") == null) {
				session.setAttribute("updateResult", -1);
			}
			
			session.setAttribute("category", category);
			model.addAttribute("qnalist", qnalist);
			
		}
		
	}
	@PostMapping("/qnaUpdate.do")
	public String updateAdminQnA(Model model,HttpServletRequest request, RedirectAttributes attr
			, HttpSession session, UserQnADTO qna) {
		//UserQnADTO qna = qnaDtoSetting(request);
		
		int result = qnaService.updateAdminQnA(qna);
		attr.addFlashAttribute("updateResult", result);
		
		return "redirect:qnaList.do";
	}
	

	private UserQnADTO qnaDtoSetting(HttpServletRequest request) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		int qna_id = Integer.parseInt(request.getParameter("qna_id"));
		String title = request.getParameter("title");
		String qna_category = request.getParameter("qna_category");
		Date create_date = Date.valueOf(request.getParameter("create_date"));
		System.out.println(request.getParameter("create_date"));
		System.out.println(create_date);
		String qna_content = request.getParameter("qna_content");
		String answer = request.getParameter("answer");
		Date answer_date = Date.valueOf(request.getParameter("answer_date"));
		int member_id = Integer.parseInt(request.getParameter("member_id"));
		UserQnADTO qna = new UserQnADTO(qna_id, title, qna_category, create_date, qna_content, answer, answer_date,
				member_id);
		return qna;
	}

}
