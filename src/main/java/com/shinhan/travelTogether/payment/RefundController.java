package com.shinhan.travelTogether.payment;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/refund")
public class RefundController {

	private static final Logger logger = LoggerFactory.getLogger(PaymentController.class);

	@Autowired
	RefundService refundService;
	
	
	@GetMapping("/cancel.do")
	public void showRefund() {
		logger.info("Handling /travel/payment request cancel");
	}

	@PostMapping("/cancel.do")
	public String refund(@RequestParam("reason") String reason,
						 @RequestParam("productId") String productId,
						 RedirectAttributes redirectAttributes) {
		logger.info("Handling /travel/payment request cancelPost");

		LocalDateTime dateTime = LocalDateTime.now(); // 현재 날짜와 시간
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String refundDate = dateTime.format(formatter);
		
		redirectAttributes.addFlashAttribute("reason", reason);
		redirectAttributes.addFlashAttribute("primaryKey", productId);
		redirectAttributes.addFlashAttribute("refundDate", refundDate);

		return "redirect:cancel.do";
	}
	
	@PostMapping("/saveinfo.do")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> processRefund(@RequestParam("payment_key") String paymentKey,
															@RequestParam("refund_reason") String refundReason) {
		Map<String, Object> response = new HashMap<>();
		
		// test
		//System.out.println(paymentKey);
		//System.out.println(refundReason);
		
		// DB 처리
		int result = refundService.insertRefundInfo(paymentKey, refundReason);
		
		if(result >= 0) {
			response.put("status", "ok");
			return ResponseEntity.ok(response);
		}else {
			response.put("status", "error");
			return ResponseEntity.badRequest().body(response);
		}
	}
	
	

	// TEST 윤철이 페이지 - 상품 환불하기
	@GetMapping(value = "/refundtest.do")
	public String testPage1() {
		return "refund/refundtest";
	}
}
