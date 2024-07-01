package com.shinhan.travelTogether;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.shinhan.travelTogether.funding.FundingAdminDTO;
import com.shinhan.travelTogether.funding.FundingDTO;
import com.shinhan.travelTogether.funding.FundingService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	FundingService fundingService;
	
	@GetMapping("/dashboard.do")	// 관리자 - 대시보드 페이지
	public void dashboard() {
		
	}
	
	@GetMapping("/memberList.do")	// 관리자 - 회원관리 페이지
	public void memberList() {
		
	}
	
	@GetMapping("/fundingList.do")	// 관리자 - 펀딩관리 페이지
	public void fundingList(Model model) {
		
	}
	
	@GetMapping("/fundingListItem.do")
	public void fundingListItem(Model model) {
		List<FundingAdminDTO> fundinglist = fundingService.selectAllAdminFunding();
	    model.addAttribute("fundinglist", fundinglist);
	}
	
	@GetMapping("/fundingConfirm.do")
	public void fundingConfirmView(Model model, Integer id) {
		FundingDTO funding = fundingService.selectFundingById(id);
		model.addAttribute("funding", funding);
	}
	
	@PostMapping("/fundingConfirm.do")
	@ResponseBody
	public String fundingConfirm(Integer funding_id) {
		System.out.println(funding_id);
		Integer result = fundingService.updateFundingState(funding_id, 1);
		
		return result.toString();
	}
}
