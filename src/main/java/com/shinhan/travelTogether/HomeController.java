package com.shinhan.travelTogether;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.shinhan.travelTogether.funding.FundingDTO;
import com.shinhan.travelTogether.funding.FundingService;
import com.shinhan.travelTogether.member.MemberDTO;
import com.shinhan.travelTogether.photo.PhotoDTO;
import com.shinhan.travelTogether.photo.PhotoService;
import com.shinhan.travelTogether.review.ReviewDTO;
import com.shinhan.travelTogether.review.ReviewService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	FundingService fService;
	
	@Autowired
	ReviewService rService;
	
	@Autowired
	PhotoService pService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, HttpSession session) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		MemberDTO member_id = (MemberDTO) session.getAttribute("member");
		if(member_id == null) {
			model.addAttribute("member", null);
		}
		
		List<FundingDTO> fundinglist = fService.selectPopular();
		List<ReviewDTO> reviewlist = rService.selectBestReview();
		List<Integer> reviewIdList = reviewlist.stream()
				.map(ReviewDTO::getReview_id)
				.collect(Collectors.toList());
		List<PhotoDTO> reviewphotolist = null;

		List<Integer> fundingIdList = fundinglist.stream()
				.map(FundingDTO::getFunding_id)
				.collect(Collectors.toList());
		List<PhotoDTO> fundingphotolist = null;
		
		if(reviewIdList.size() > 0 || fundingIdList.size() > 0) {
			reviewphotolist = pService.selecBestReviewPhoto(reviewIdList);
			fundingphotolist = pService.selectFundingPhoto(fundingIdList);
		}
		model.addAttribute("fundinglist", fundinglist);
		model.addAttribute("reviewlist", reviewlist);
		model.addAttribute("reviewphotolist", reviewphotolist);
		model.addAttribute("fundingphotolist", fundingphotolist);
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
}
