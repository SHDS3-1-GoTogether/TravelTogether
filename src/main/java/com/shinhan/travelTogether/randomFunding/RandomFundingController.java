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

		// ȸ�� ���̵� - ������
		//int id = 1;
		//System.out.println("test1");
		List<String> amount = rfService.getAmountAll(id);
		//System.out.println("test2");
		//System.out.println(amount);
		for(String test : amount) {
			System.out.println(test);
		}
		
		// �����̷�Ʈ �ϴ� ���� �Ͻ������� ���� �����س����� �����̷�Ʈ�� ���������� ���� ����� �� ����
		redirectAttributes.addFlashAttribute("amount", amount);
		
		// ���� �𵨿� �����س��� ���𷺼��� ��� �ٷ� �����Ϸ� ��������ߵ� �׷��� ������ ���� ������� ������ ����
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
