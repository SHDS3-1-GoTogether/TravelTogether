package com.shinhan.travelTogether.payment;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.travelTogether.coupon.CouponService;
import com.shinhan.travelTogether.coupon.UserCouponDTO;

@Controller
@RequestMapping("/payment")
public class PaymentController {

	@Autowired
	CouponService userCouponService;
	
	@Autowired
	PaymentService pService;

	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);

	@GetMapping(value = "/test.do")
	public void showTest() {
		
	}
	
	
	@GetMapping(value = "/pay.do")
	public void showPaymentPage(Model model) {

		// �α��� ��� ������ ����
		List<UserCouponDTO> couponlist = userCouponService.selectAllUserCoupon(1);
		//System.out.println(couponlist.toString());
		logger.info(couponlist.size() + "�� ��ȸ��");
		model.addAttribute("couponlist", couponlist);
	}
	
	@PostMapping("/pay.do")
	public String fundingApplyPayment(Integer fundingId,
									   RedirectAttributes redirectAttributes,
									   HttpSession session) {
		
		//test
		System.out.println(fundingId);
		// userId�κп� �°� �޾ƿ���
		//Integer userId = (Integer) session.getAttribute("tt_id");
		
		PaymentFundingInfoDTO fundingInfo = pService.getFundingInfo(fundingId);
		
		System.out.println(fundingInfo.getTitle());
		System.out.println(fundingInfo.getPrice());
		System.out.println(fundingInfo.getApplicantNickname());
		
		redirectAttributes.addFlashAttribute("title",fundingInfo.getTitle());
		redirectAttributes.addFlashAttribute("price",fundingInfo.getPrice());
		redirectAttributes.addFlashAttribute("applicantNick",fundingInfo.getApplicantNickname());
		
		// �α��� ���� --> ���߿� ����
		redirectAttributes.addFlashAttribute("userId",1);
		
		return "redirect:/payment/pay.do";
	}
	

	@GetMapping(value = "/success.do")
	public void showSuccessPage() {
		logger.info("Handling /travel/payment request success");
	}

	@GetMapping("/fail.do")
	public void showFailurePage() {
		logger.info("Handling /travel/payment request failure");
	}

	// ����� ���� ���� ����
	@PostMapping("/save-coupon-id")
	public ResponseEntity<?> saveCouponId(HttpSession session, @RequestBody Map<String, Object> payload) {
		try {
			Integer couponId = (Integer) payload.get("couponId");
			session.setAttribute("couponId", couponId);
			return ResponseEntity.ok()
					.body("{\"status\": \"success\", \"message\": \"Coupon ID saved successfully.\"}");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body("{\"status\": \"error\", \"message\": \"Failed to save the coupon ID.\"}");
		}
	}

	// ���� ���� db����(���� ���� ���������� Ȩ���� ��ư Ŭ�� ��)
	@RequestMapping(value = "/savepayment.do", method = RequestMethod.POST)
	public String savePayment(@RequestBody Map<String, Object> payload, HttpSession session) {

		String orderId = (String) payload.get("orderId");
		String requestAt = (String) payload.get("requestAt"); // ISO8601 ���� -> jsp���� convert
		String totalAmount = (String) payload.get("totalAmount");
		String provider = (String) payload.get("provider");

		// paymentKey
		String paymentKey = (String) payload.get("paymentKey");

		//System.out.println(paymentKey);

		PaymentDTO payment = new PaymentDTO();
		payment.setPayment_id(orderId);		// �������� ��
		payment.setPayment_date(requestAt);	// ���� ���� ��¥ 
		payment.setPrice(Integer.parseInt(totalAmount));
		payment.setRefund(0); // - ������ 0 / ȯ�ҽ� 1
		payment.setPayment_method(provider);
		payment.setMember_id(1); // �ӽ�
		payment.setFunding_id(1); // �ӽ�
		payment.setPayment_key(paymentKey); // test

		// ���ǿ��� couponId ��������
		Integer couponId = (Integer) session.getAttribute("couponId");
		if (couponId != null) {
			payment.setCoupon_record_id(couponId);
		} else {
			payment.setCoupon_record_id(0); // ���� ID�� ������ 0���� ���� (�ʿ信 ���� ����)
		}
		int result = pService.insertPaymentInfo(payment);
		String message = result > 0 ? "success complete payment" : "fail complete payment";
		// ���� �� ���� �� �����̷�Ʈ ��� ����
		if (result > 0) {
			return "redirect:/payment/pay.do"; // ���� �������� �����̷�Ʈ
		} else {
			return "redirect:/payment/fail.do"; // ���� �������� �����̷�Ʈ
		}
	}

	// TEST ������ ������ - ��ǰ �󼼺���
	@GetMapping(value = "/reward.do")
	public String showRewardPage() {
		logger.info("Handling /travel/reward request");
		return "payment/reward";
	}
}
