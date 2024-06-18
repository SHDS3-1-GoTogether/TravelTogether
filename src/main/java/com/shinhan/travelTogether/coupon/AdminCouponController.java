package com.shinhan.travelTogether.coupon;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		
		if(session.getAttribute("insertResult") == null) {
			session.setAttribute("insertResult", -1);
		}
		if(session.getAttribute("deleteResult") == null) {
			session.setAttribute("deleteResult", -1);
		}
		
		session.setAttribute("option", option);
		model.addAttribute("couponlist", couponlist);
	}
	
	@PostMapping("/couponInsert.do")
	public String couponInsert(Model model, HttpServletRequest request, RedirectAttributes attr) {
		try {
			request.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		int option = Integer.parseInt(request.getParameter("option"));
		String type = request.getParameter("type");
		String membership_id = option == 0 ? request.getParameter("membership_id") : null;
		String coupon_name = request.getParameter("coupon_name");
		int discount_rate = Integer.parseInt(request.getParameter("discount_rate"));
		int max_discount = Integer.parseInt(request.getParameter("max_discount"));
		int discount_price = Integer.parseInt(request.getParameter("discount_price"));
		System.out.println(type);
		AdminCouponDTO coupon = null;
		if(type.equals("rate")) {
			coupon = new AdminCouponDTO(0, coupon_name, option, discount_rate, max_discount, membership_id);
		} else if(type.equals("amount")) {
			coupon = new AdminCouponDTO(0, coupon_name, option, 0, discount_price, membership_id);
		} else {
				// 잘못된 type 선택
		}
		
		int result = couponService.insertAdminCoupon(coupon);	// 0이면 등록실패
		attr.addFlashAttribute("insertResult", result);
		
		return "redirect:couponList.do";
	}
	
	@PostMapping("/couponDelete.do")
	@ResponseBody
	public String couponDelete(HttpServletRequest request) {
		int coupon_id = Integer.parseInt(request.getParameter("coupon_id"));
		System.out.println(coupon_id);
		Integer result = couponService.deleteAdminCoupon(coupon_id);
		
		return result.toString();
	}
}
