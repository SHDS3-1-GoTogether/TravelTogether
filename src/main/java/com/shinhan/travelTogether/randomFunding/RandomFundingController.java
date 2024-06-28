package com.shinhan.travelTogether.randomFunding;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/randomFunding")
public class RandomFundingController {

	@Autowired
	RandomFundingService rfService;

	@GetMapping("/schedule.do")
	public void showSchedule() {
	}

	@PostMapping("/schedule.do")
	public String selectSchedule() {

		return "redirect:/randomFunding/schedule.do";
	}

	@GetMapping("/amount.do")
	public void showAmount() {
	}

	@PostMapping("/amount.do")
	public String selectAmount(RedirectAttributes redirectAttributes,int id, Model model) {

		// 회원 아이디 - 관리자
		//int id = 1;
		//System.out.println("test1");
		List<String> amount = rfService.getAmountAll(id);
		//System.out.println("test2");
		//System.out.println(amount);
		for(String test : amount) {
			System.out.println(test);
		}
		
		// 리다이렉트 하는 동안 일시적으로 값을 저장해놓으며 리다이렉트된 페이지에서 값을 사용할 수 있음
		redirectAttributes.addFlashAttribute("amount", amount);
		
		// 값을 모델에 저장해놓고 리디렉션할 경우 바로 뷰파일로 연결해줘야됨 그렇지 않으면 값이 사라지는 문제가 있음
		//model.addAttribute("amount", amount);

		
		return "redirect:/randomFunding/amount.do";
	}

	@GetMapping("/theme")
	public void showTheme() {
		
	}

	@PostMapping("/theme")
	public String selectTheme() {

		return "redirect:/randomFunding/theme.do";
	}
}
