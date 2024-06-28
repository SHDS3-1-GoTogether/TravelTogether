package com.shinhan.travelTogether.review;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shinhan.travelTogether.funding.FundingDTO;
import com.shinhan.travelTogether.funding.FundingService;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	ReviewService reviewService;
	
	@Autowired
	FundingService fundingService;
	
	@GetMapping("/reviewList.do")
	public void showAllReview(Model model) {
		List<ReviewDTO> reviewlist = reviewService.selectAllReview();
		List<FundingDTO> fundinglist = fundingService.selectAll("selectAllByDate");
		model.addAttribute("reviewlist", reviewlist);
		model.addAttribute("fundinglist", fundinglist);
	}
	
}
