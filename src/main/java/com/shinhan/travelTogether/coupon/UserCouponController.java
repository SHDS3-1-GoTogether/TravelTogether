package com.shinhan.travelTogether.coupon;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.shinhan.travelTogether.member.MemberDTO;

@Controller
@RequestMapping("/mypage")
public class UserCouponController {

	@Autowired
	CouponService userCouponService;
	
	Logger logger = LoggerFactory.getLogger(UserCouponController.class);
	
	@GetMapping("/couponList.do")
	public void userCouponList(Model model, HttpSession session){
		
		// 로그인 기능 구현시 수정
		int userId = ((MemberDTO) session.getAttribute("member")).getMember_id();
		List<UserCouponDTO> couponlist = userCouponService.selectAllUserCoupon(userId);
		System.out.println(couponlist.toString());
		logger.info(couponlist.size()+"건 조회됨");
		model.addAttribute("couponlist", couponlist);
	}
}
