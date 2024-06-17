package com.shinhan.travelTogether.funding;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.support.RequestContextUtils;

@Controller
@RequestMapping("/funding")
public class FundingController {
	
	@Autowired
	FundingService fService;
	
	@GetMapping("/fundingList.do") 
	public void selectAll(Model model, HttpServletRequest request) {
		model.addAttribute("fundlist", fService.selectAll());
		String result = "";
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if(flashMap != null) {
			result = (String)flashMap.get("fundResult");
			
		}
		model.addAttribute("fundResult", result);
	}

	@GetMapping("/fundingInput.do")
	public void inputPage(){
		
	}
	
	@PostMapping("/fundingInput.do") 
	public String inputFunding(FundingDTO fund) {
		System.out.println("Funding Input 확인 1 : " + fund);
		if(fund.traffic==null && fund.accommodation == null)
			fund.setConfirm_option(0);
		else if(fund.traffic != null && fund.accommodation != null) {
			fund.setConfirm_option(3);
		} else if(fund.accommodation !=null) {
			fund.setConfirm_option(1);
		} else {
			fund.setConfirm_option(2);
		}
		fund.setFunding_state(0);
		fund.setViews(0);
		fund.setMember_id(1);
		System.out.println("Funding Input 확인 2 : " + fund);
		int result = fService.insertFunding(fund);
		System.out.println(result + "건 입력");
		return "redirect:fundingList.do";
	}


}
