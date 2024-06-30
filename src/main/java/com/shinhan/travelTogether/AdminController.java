package com.shinhan.travelTogether;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.shinhan.travelTogether.funding.FundingAdminDTO;
import com.shinhan.travelTogether.funding.FundingService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	FundingService fundingService;
	
	@GetMapping("/dashboard.do")	// ������ - ��ú��� ������
	public void dashboard() {
		
	}
	
	@GetMapping("/memberList.do")	// ������ - ȸ������ ������
	public void memberList() {
		
	}
	
	@GetMapping("/fundingList.do")	// ������ - �ݵ����� ������
	public void fundingList(Model model) {
		List<FundingAdminDTO> fundinglist = fundingService.selectAllAdminFunding();
		System.out.println("!!!!!!!!! "+fundinglist+"!!!!!!!!!!!!!!");
		ObjectMapper objectMapper = new ObjectMapper();
	    try {
	        String fundinglistAsJson = objectMapper.writeValueAsString(fundinglist);
	        model.addAttribute("fundinglist", fundinglist);
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	    }
	}
	
	@GetMapping("/fundingListItem.do")
	public void fundingListItem(Model model) {
		List<FundingAdminDTO> fundinglist = fundingService.selectAllAdminFunding();
	    model.addAttribute("fundinglist", fundinglist);
	}
}
