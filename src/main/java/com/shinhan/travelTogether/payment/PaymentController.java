package com.shinhan.travelTogether.payment;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.travelTogether.coupon.CouponService;
import com.shinhan.travelTogether.coupon.UserCouponDTO;
import com.shinhan.travelTogether.member.MemberDTO;



@Controller
@RequestMapping("/payment")
public class PaymentController {

	@Autowired
	CouponService userCouponService;

	@Autowired
	PaymentService pService;

	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);

	@GetMapping(value = "/pay.do")
	public void showPaymentPage(@RequestParam("funding_id") Integer funding_id, Model model, HttpSession session) {

		PaymentFundingInfoDTO fundingInfo = pService.getFundingInfo(funding_id);

		model.addAttribute("title", fundingInfo.getTitle());
		model.addAttribute("price", fundingInfo.getPrice());
		model.addAttribute("applicantNick", fundingInfo.getApplicantNickname());

		// ���ǿ� member_id, funding_id �߰�
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();
		session.setAttribute("member_id", member_id);
		session.setAttribute("funding_id", funding_id);
		
		
		// �α��� ��� ������ ����
		List<UserCouponDTO> couponlist = userCouponService.selectAllUserCoupon((int)session.getAttribute("member_id"));
		model.addAttribute("couponlist", couponlist);
	}

	@PostMapping("/pay.do")
	public String fundingApplyPayment(Integer funding_id, RedirectAttributes redirectAttributes, HttpSession session) {
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
	public void savePayment(@RequestBody Map<String, Object> payload, HttpSession session,
			HttpServletResponse response) {

		String orderId = (String) payload.get("orderId");
		String requestAt = (String) payload.get("requestAt"); // ISO8601 ���� -> jsp���� convert
		String totalAmount = (String) payload.get("totalAmount");
		String provider = (String) payload.get("provider");

		// paymentKey
		String paymentKey = (String) payload.get("paymentKey");

		PaymentDTO payment = new PaymentDTO();
		payment.setPayment_id(orderId); // �ߺ����� ���� ����
		payment.setPayment_date(requestAt); // ���� ���� ��¥
		payment.setPrice(Integer.parseInt(totalAmount)); // �� ���� �ݾ�
		payment.setRefund(0); // - ������ 0 / ȯ�ҽ� 1
		payment.setPayment_method(provider); // ���� ����
		payment.setMember_id((Integer) session.getAttribute("member_id"));
		payment.setFunding_id((Integer) session.getAttribute("funding_id"));
		payment.setPayment_key(paymentKey); // ���� Ű

		// ���ǿ��� couponId ��������
		Integer couponId = (Integer) session.getAttribute("couponId");
		if (couponId != null) {
			payment.setCoupon_record_id(couponId);
		} else {
			payment.setCoupon_record_id(null); // ���� ID�� ������ 0���� ���� (�ʿ信 ���� ����)
		}

		int result_payment = pService.insertPaymentInfo(payment);
		String message = result_payment > 0 ? "success complete payment" : "fail complete payment";

		// --------------------------------������� ���� ���� DB ����------------------------------------------

		Map<String, Object> info = pService.checkingFundingState(payment.getFunding_id());

		int people_num = ((Number) info.get("PEOPLE_NUM")).intValue();
		int participants = ((Number) info.get("PARTICIPANTS")).intValue();

		// test
		System.out.println("-------------------------�ݵ� �����ο� ��----------------------");
		System.out.println("�����ο�");
		System.out.println(people_num);
		System.out.println("�����ο�");
		System.out.println(participants);
		System.out.println("-------------------------�ݵ� �����ο� ��----------------------");

		if (people_num == participants) {
			// �ݵ� ���̺� �������� ���� update �� ����
			int result_fundingStatus = pService.updatePeopleNum(payment.getFunding_id());
			System.out.println("��� : " + result_fundingStatus);
		}

		// ���� �� ���� �� �����̷�Ʈ ��� ����
		if (result_payment > 0) {
			System.out.println(message);
			response.setStatus(HttpServletResponse.SC_OK);
		} else {
			System.out.println(message);
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		}
	}
}