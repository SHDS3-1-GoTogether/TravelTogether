package com.shinhan.travelTogether.coupon;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/mypage")
public class UserCouponController {

	@Autowired
	CouponService userCouponService;
	
	Logger logger = LoggerFactory.getLogger(UserCouponController.class);
	
	@GetMapping("/couponList.do")
	public void userCouponList(Model model){
		
		// �α��� ��� ������ ����
		int userId = 1;
		List<UserCouponDTO> couponlist = userCouponService.selectAllUserCoupon(userId);
		System.out.println(couponlist.toString());
		logger.info(couponlist.size()+"�� ��ȸ��");
		model.addAttribute("couponlist", couponlist);
	}
}