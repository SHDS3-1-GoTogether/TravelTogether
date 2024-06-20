package com.shinhan.travelTogether.payment;

import java.sql.Timestamp;
import java.time.LocalDateTime;
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

	@GetMapping(value = "/reward.do")
	public String showRewardPage() {
		logger.info("Handling /travel/reward request");
		return "payment/reward";
	}

	@GetMapping(value = "/pay.do")
	public String testPaymentPage(Model model) {
		// 로그인 기능 구현시 수정
		int userId = 1;
		List<UserCouponDTO> couponlist = userCouponService.selectAllUserCoupon(userId);
		System.out.println(couponlist.toString());
		logger.info(couponlist.size() + "건 조회됨");
		model.addAttribute("couponlist", couponlist);
		return "payment/pay";
	}
	
	@PostMapping("/pay.do")
	public String insertPayment(PaymentDTO payment, RedirectAttributes redirectAttr) {
		int result = pService.insertPaymentInfo(payment);
		String message;
		if (result > 0) {
			message = "success complete payment";
		}else {
			message = "fail complete payment";
		}
		redirectAttr.addFlashAttribute("paymentResult", message);
		return "redirect:success.do";
	}

	@GetMapping(value = "/success.do")
	public String showSuccessPage() {
		logger.info("Handling /travel/payment request success");
		return "payment/success";
	}
	
	@GetMapping(value = "/va_callback.do")
	public String showSuccessPage2() {
		logger.info("Handling /travel/payment request success");
		return "payment/va_callback";
	}
	
	@GetMapping("/fail.do")
	public String showFailurePage() {
		logger.info("Handling /travel/payment request failure");
		return "payment/fail";
	}

	
	// 선택된 쿠폰id 가져오기 위해서 
	@PostMapping("/save-coupon-id")
    public ResponseEntity<?> saveCouponId(HttpSession session, @RequestBody Map<String, Object> payload) {
        try {
            Integer couponId = (Integer) payload.get("couponId");
            session.setAttribute("couponId", couponId);
            return ResponseEntity.ok().body("{\"status\": \"success\", \"message\": \"Coupon ID saved successfully.\"}");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("{\"status\": \"error\", \"message\": \"Failed to save the coupon ID.\"}");
        }
    }
	
	@RequestMapping(value = "/savepayment.do", method = RequestMethod.POST)
    public String savePayment(@RequestBody Map<String, Object> payload, HttpSession session) {
        
		String orderId = (String) payload.get("orderId");
        String requestAt = (String) payload.get("requestAt");  //ISO8601 형식
        String totalAmount = (String) payload.get("totalAmount");
        String provider = (String) payload.get("provider");

        System.out.println("test1");

        PaymentDTO payment = new PaymentDTO();
        payment.setPayment_id(orderId);
        payment.setPayment_date(requestAt);
        payment.setPrice(Integer.parseInt(totalAmount));
        payment.setRefund(1);  // 임시
        payment.setPayment_method(provider);
        payment.setClassification(1);  // 임시
        payment.setMember_id(1);  // 임시
        payment.setFunding_id(1);  // 임시

        // 세션에서 couponId 가져오기
        Integer couponId = (Integer) session.getAttribute("couponId");
        if (couponId != null) {
            payment.setCoupon_record_id(couponId);
        } else {
            payment.setCoupon_record_id(0);  // 쿠폰 ID가 없으면 0으로 설정 (필요에 따라 수정)
        }

        int result = pService.insertPaymentInfo(payment);
        String message = result > 0 ? "success complete payment" : "fail complete payment";

        System.out.println("test3");

        System.out.println(message);

        // 성공 및 실패 시 리다이렉트 경로 설정
        if (result > 0) {
            return "redirect:/payment/pay.do";  // 성공 페이지로 리다이렉트
        } else {
            return "redirect:/payment/failurePage.do";  // 실패 페이지로 리다이렉트
        }
    }
	
	
	// tossPayments API test
//		@RequestMapping(value = "/pay_test.do")
//		public String showNpayTest() {
//			return "payment/checkout";
//		}
//	@RequestMapping(value = "/processKakaopay.do")
//	@ResponseBody
//	public String kakaopay() {
//		logger.info("Starting payment process");
//
//		try {
//			URL urlPay = new URL("https://open-api.kakaopay.com/online/v1/payment/ready");
//			HttpURLConnection serverConnect = (HttpURLConnection) urlPay.openConnection();
//			serverConnect.setRequestMethod("POST");
//			serverConnect.setRequestProperty("Authorization",
//					"DEV_SECRET_KEY DEV23FBE64E3F7ADB0820BCBD20A8C57B6F2197C");
//			serverConnect.setRequestProperty("Content-Type", "application/json");
//			serverConnect.setDoOutput(true);
//
//			// JSON 형식으로 파라미터 생성 ---> 나중에 결제페이지에서 해당 정보 가져와서 적용
//			String jsonInputString = "{" + "\"cid\": \"TC0ONETIME\"," + "\"partner_order_id\": \"partner_order_id\","
//					+ "\"partner_user_id\": \"partner_user_id\"," + "\"item_name\": \"홍박사(홍정민)가 추천하는 여행\","
//					+ "\"quantity\": 1," + "\"total_amount\": 2200," + "\"vat_amount\": 200,"
//					+ "\"tax_free_amount\": 0," + "\"approval_url\": \"http://localhost:9090/travel/success.do\","
//					+ "\"fail_url\": \"http://localhost:9090/travel/failure.do\","
//					+ "\"cancel_url\": \"http://localhost:9090/travel/cancel.do\"" + "}";
//
//			// 데이터 전송
//			try (OutputStream os = serverConnect.getOutputStream()) {
//				byte[] input = jsonInputString.getBytes("utf-8");
//				os.write(input, 0, input.length);
//			}
//
//			int result = serverConnect.getResponseCode();
//
//			InputStream recv = (result == 200) ? serverConnect.getInputStream() : serverConnect.getErrorStream();
//			BufferedReader convertRead = new BufferedReader(new InputStreamReader(recv, "UTF-8"));
//			return convertRead.readLine(); // 응답 데이터 반환
//		} catch (MalformedURLException e) {
//			logger.error("MalformedURLException", e);
//		} catch (IOException e) {
//			logger.error("IOException", e);
//		}
//
//		return "Payment processing failed";
//	}

	// test
//		@RequestMapping(value = "/pay_test.do")
//		public String showPaymentPage_test(Model model, HttpServletRequest request) {
//			logger.info("Handling /travel/payment request");
//			return "payment/pay_test";
//}
//	@RequestMapping(value = "/processPayment.do")
//	@ResponseBody
	// public String kakaopay(@RequestParam("testMoney") String testMoney) {
//	public String kakaopay_test() {
//		
//		 logger.info("Starting payment process");
//		
//		// 통신코드
//		try {
//			// api 내부의 request syntax 확인하여 host+post를 붙여서 주소를 만듦
//			URL urlPay = new URL("https://open-api.kakaopay.com/online/v1/payment/ready");
//			// 요청을하는 클라이언트와 요청을 받는 카카오페이 서버를 연결하는 역할을 함
//			HttpURLConnection serverConnect = (HttpURLConnection) urlPay.openConnection();
//			// 연결방식 지정
//			serverConnect.setRequestMethod("POST");
//			// 인증받은 요청인지 확인 -> admin key 필요
//			serverConnect.setRequestProperty("Authorization", "DEV_SECRET_KEY DEV23FBE64E3F7ADB0820BCBD20A8C57B6F2197C");
//			// contentType
//			serverConnect.setRequestProperty("Content-Type", "application/json");
//			// 내가 서버에다가 전해줄것이 있는 경우 setDoOutput을 true로 설정(default가 false이기에 따로 설정했음,
//			// cf.setDoInput은 default가 true임)
//			serverConnect.setDoOutput(true);
//
//			// 필수 파라미터 (api연결시 필수적으로 들어가야되는 데이터들이 있음, 연습용 파라미터 연결)
//			String payParameter = "cid=TC0ONETIME&"
//					+ "partner_order_id=partner_order_id&"
//					+ "partner_user_id=partner_user_id&"
//					+ "item_name=초코파이&"
//					+ "quantity=1&"
//					+ "total_amount=2200&"
//					+ "vat_amount=200&"
//					+ "tax_free_amount=0&"
//					+ "approval_url=http://localhost:9090/travel/success.do&"
//					+ "fail_url=http://localhost:9090/travel/failure.do&"
//					+ "cancel_url=http://localhost:9090/travel/cancel.do";
//
//			// 주는 애 ---> \outputstream은 데이터를 byte형식으로 사용함
//			OutputStream send = serverConnect.getOutputStream();
//            
//			// data 주는애
//			DataOutputStream dataSend = new DataOutputStream(send);
//			// 전달형식 byte로 설정
//			dataSend.writeBytes(payParameter);
//			dataSend.flush(); // 들어있는 데이터를 비우는 기능 (전달하고 비우는 기능)
//			dataSend.close();
//
//			// 실제 통신이 이루어지는 부분
//			int result = serverConnect.getResponseCode();
//
//			// ###데이터를 받는 부분###
//			InputStream recv;
//			// 정상통신
//			if (result == 200) {
//				recv = serverConnect.getInputStream();
//			} else {
//				recv = serverConnect.getErrorStream();
//			}
//
//			// 받아온 데이터를 읽는 부분
//			InputStreamReader recvRead = new InputStreamReader(recv);
//			// 읽어온 데이터 형변환
//			BufferedReader convertRead = new BufferedReader(recvRead);
//			return convertRead.readLine();
//		} catch (MalformedURLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return "test fail";
//	}
}
