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

		// 세션에 member_id, funding_id 추가
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();
		session.setAttribute("member_id", member_id);
		session.setAttribute("funding_id", funding_id);
		
		
		// 로그인 기능 구현시 수정
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

	// 적용된 쿠폰 세션 저장
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

	// 결제 정보 db저장(결제 성공 페이지에서 홈으로 버튼 클릭 시)
	@RequestMapping(value = "/savepayment.do", method = RequestMethod.POST)
	public void savePayment(@RequestBody Map<String, Object> payload, HttpSession session,
			HttpServletResponse response) {

		String orderId = (String) payload.get("orderId");
		String requestAt = (String) payload.get("requestAt"); // ISO8601 형식 -> jsp에서 convert
		String totalAmount = (String) payload.get("totalAmount");
		String provider = (String) payload.get("provider");

		// paymentKey
		String paymentKey = (String) payload.get("paymentKey");

		PaymentDTO payment = new PaymentDTO();
		payment.setPayment_id(orderId); // 중복결제 방지 난수
		payment.setPayment_date(requestAt); // 결제 성공 날짜
		payment.setPrice(Integer.parseInt(totalAmount)); // 총 결제 금액
		payment.setRefund(0); // - 결제시 0 / 환불시 1
		payment.setPayment_method(provider); // 결제 수단
		payment.setMember_id((Integer) session.getAttribute("member_id"));
		payment.setFunding_id((Integer) session.getAttribute("funding_id"));
		payment.setPayment_key(paymentKey); // 결제 키

		// 세션에서 couponId 가져오기
		Integer couponId = (Integer) session.getAttribute("couponId");
		if (couponId != null) {
			payment.setCoupon_record_id(couponId);
		} else {
			payment.setCoupon_record_id(null); // 쿠폰 ID가 없으면 0으로 설정 (필요에 따라 수정)
		}

		int result_payment = pService.insertPaymentInfo(payment);
		String message = result_payment > 0 ? "success complete payment" : "fail complete payment";

		// --------------------------------여기까지 결제 정보 DB 저장------------------------------------------

		Map<String, Object> info = pService.checkingFundingState(payment.getFunding_id());

		int people_num = ((Number) info.get("PEOPLE_NUM")).intValue();
		int participants = ((Number) info.get("PARTICIPANTS")).intValue();

		// test
		System.out.println("-------------------------펀딩 참여인원 비교----------------------");
		System.out.println("모집인원");
		System.out.println(people_num);
		System.out.println("참여인원");
		System.out.println(participants);
		System.out.println("-------------------------펀딩 참여인원 비교----------------------");

		if (people_num == participants) {
			// 펀딩 테이블 참여상태 변경 update 문 실행
			int result_fundingStatus = pService.updatePeopleNum(payment.getFunding_id());
			System.out.println("결과 : " + result_fundingStatus);
		}

		// 성공 및 실패 시 리다이렉트 경로 설정
		if (result_payment > 0) {
			System.out.println(message);
			response.setStatus(HttpServletResponse.SC_OK);
		} else {
			System.out.println(message);
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
		}
	}
}