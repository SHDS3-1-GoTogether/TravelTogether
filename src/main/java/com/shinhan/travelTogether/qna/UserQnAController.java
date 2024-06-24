package com.shinhan.travelTogether.qna;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shinhan.travelTogether.member.MemberDTO;

@Controller
@RequestMapping("/mypage")
public class UserQnAController {

	@Autowired
	QnAService userQnAService;

	Logger logger = LoggerFactory.getLogger(UserQnAController.class);

	@GetMapping("/qnaList.do")
	public void userCouponList(Model model, HttpSession session) {

		// 로그인 기능 구현시 수정
		//int userId = ((MemberDTO) session.getAttribute("member")).getMember_id();
		int userId = 1;
		List<UserQnADTO> qnalist = userQnAService.selectAllUserQnA(userId);
		System.out.println(qnalist.toString());
		logger.info(qnalist.size() + "건 조회됨");
		model.addAttribute("qnalist", qnalist);
	}
}
