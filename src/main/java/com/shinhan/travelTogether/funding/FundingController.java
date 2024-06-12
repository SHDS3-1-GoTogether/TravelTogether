package com.shinhan.travelTogether.funding;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	public void insertFunding() {
		
	}


}
