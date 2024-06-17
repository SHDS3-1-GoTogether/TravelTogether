package com.shinhan.travelTogether.coupon;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/admin")
public class AdminCouponController {
	
	@Autowired
	CouponService couponService;
	
	@GetMapping("/couponList.do")
	public void couponList(Model model, 
							HttpSession session,
							@RequestParam(required = false) Integer option) {
		System.out.println(option);
		List<AdminCouponDTO> couponlist = null;
		if(option == null || option == -1) {
			couponlist = couponService.selectAllAdminCoupon();
			couponlist.forEach(adminCoupon -> {
				String title = null;
				switch(adminCoupon.getCoupon_option()) {
					case 0: {
						title = "[정기] " + adminCoupon.getTitle();
						break;
					}
					case 1: {
						title = "[특별] " + adminCoupon.getTitle();
						break;
					}
					case 2: {
						title = "[일반] " + adminCoupon.getTitle();
						break;
					}
					
				}
				adminCoupon.setTitle(title);
			});
			option = -1;
		} else {
			couponlist = couponService.selectAdminCouponByOption(option);
		}
		
		session.setAttribute("option", option);
		model.addAttribute("couponlist", couponlist);
	}
}
