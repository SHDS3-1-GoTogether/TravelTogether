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
		// �α��� ��� ������ ����
		int userId = 1;
		List<UserCouponDTO> couponlist = userCouponService.selectAllUserCoupon(userId);
		System.out.println(couponlist.toString());
		logger.info(couponlist.size() + "�� ��ȸ��");
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

	
	// ���õ� ����id �������� ���ؼ� 
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
        String requestAt = (String) payload.get("requestAt");  //ISO8601 ����
        String totalAmount = (String) payload.get("totalAmount");
        String provider = (String) payload.get("provider");

        System.out.println("test1");

        PaymentDTO payment = new PaymentDTO();
        payment.setPayment_id(orderId);
        payment.setPayment_date(requestAt);
        payment.setPrice(Integer.parseInt(totalAmount));
        payment.setRefund(1);  // �ӽ�
        payment.setPayment_method(provider);
        payment.setClassification(1);  // �ӽ�
        payment.setMember_id(1);  // �ӽ�
        payment.setFunding_id(1);  // �ӽ�

        // ���ǿ��� couponId ��������
        Integer couponId = (Integer) session.getAttribute("couponId");
        if (couponId != null) {
            payment.setCoupon_record_id(couponId);
        } else {
            payment.setCoupon_record_id(0);  // ���� ID�� ������ 0���� ���� (�ʿ信 ���� ����)
        }

        int result = pService.insertPaymentInfo(payment);
        String message = result > 0 ? "success complete payment" : "fail complete payment";

        System.out.println("test3");

        System.out.println(message);

        // ���� �� ���� �� �����̷�Ʈ ��� ����
        if (result > 0) {
            return "redirect:/payment/pay.do";  // ���� �������� �����̷�Ʈ
        } else {
            return "redirect:/payment/failurePage.do";  // ���� �������� �����̷�Ʈ
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
//			// JSON �������� �Ķ���� ���� ---> ���߿� �������������� �ش� ���� �����ͼ� ����
//			String jsonInputString = "{" + "\"cid\": \"TC0ONETIME\"," + "\"partner_order_id\": \"partner_order_id\","
//					+ "\"partner_user_id\": \"partner_user_id\"," + "\"item_name\": \"ȫ�ڻ�(ȫ����)�� ��õ�ϴ� ����\","
//					+ "\"quantity\": 1," + "\"total_amount\": 2200," + "\"vat_amount\": 200,"
//					+ "\"tax_free_amount\": 0," + "\"approval_url\": \"http://localhost:9090/travel/success.do\","
//					+ "\"fail_url\": \"http://localhost:9090/travel/failure.do\","
//					+ "\"cancel_url\": \"http://localhost:9090/travel/cancel.do\"" + "}";
//
//			// ������ ����
//			try (OutputStream os = serverConnect.getOutputStream()) {
//				byte[] input = jsonInputString.getBytes("utf-8");
//				os.write(input, 0, input.length);
//			}
//
//			int result = serverConnect.getResponseCode();
//
//			InputStream recv = (result == 200) ? serverConnect.getInputStream() : serverConnect.getErrorStream();
//			BufferedReader convertRead = new BufferedReader(new InputStreamReader(recv, "UTF-8"));
//			return convertRead.readLine(); // ���� ������ ��ȯ
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
//		// ����ڵ�
//		try {
//			// api ������ request syntax Ȯ���Ͽ� host+post�� �ٿ��� �ּҸ� ����
//			URL urlPay = new URL("https://open-api.kakaopay.com/online/v1/payment/ready");
//			// ��û���ϴ� Ŭ���̾�Ʈ�� ��û�� �޴� īī������ ������ �����ϴ� ������ ��
//			HttpURLConnection serverConnect = (HttpURLConnection) urlPay.openConnection();
//			// ������ ����
//			serverConnect.setRequestMethod("POST");
//			// �������� ��û���� Ȯ�� -> admin key �ʿ�
//			serverConnect.setRequestProperty("Authorization", "DEV_SECRET_KEY DEV23FBE64E3F7ADB0820BCBD20A8C57B6F2197C");
//			// contentType
//			serverConnect.setRequestProperty("Content-Type", "application/json");
//			// ���� �������ٰ� �����ٰ��� �ִ� ��� setDoOutput�� true�� ����(default�� false�̱⿡ ���� ��������,
//			// cf.setDoInput�� default�� true��)
//			serverConnect.setDoOutput(true);
//
//			// �ʼ� �Ķ���� (api����� �ʼ������� ���ߵǴ� �����͵��� ����, ������ �Ķ���� ����)
//			String payParameter = "cid=TC0ONETIME&"
//					+ "partner_order_id=partner_order_id&"
//					+ "partner_user_id=partner_user_id&"
//					+ "item_name=��������&"
//					+ "quantity=1&"
//					+ "total_amount=2200&"
//					+ "vat_amount=200&"
//					+ "tax_free_amount=0&"
//					+ "approval_url=http://localhost:9090/travel/success.do&"
//					+ "fail_url=http://localhost:9090/travel/failure.do&"
//					+ "cancel_url=http://localhost:9090/travel/cancel.do";
//
//			// �ִ� �� ---> \outputstream�� �����͸� byte�������� �����
//			OutputStream send = serverConnect.getOutputStream();
//            
//			// data �ִ¾�
//			DataOutputStream dataSend = new DataOutputStream(send);
//			// �������� byte�� ����
//			dataSend.writeBytes(payParameter);
//			dataSend.flush(); // ����ִ� �����͸� ���� ��� (�����ϰ� ���� ���)
//			dataSend.close();
//
//			// ���� ����� �̷������ �κ�
//			int result = serverConnect.getResponseCode();
//
//			// ###�����͸� �޴� �κ�###
//			InputStream recv;
//			// �������
//			if (result == 200) {
//				recv = serverConnect.getInputStream();
//			} else {
//				recv = serverConnect.getErrorStream();
//			}
//
//			// �޾ƿ� �����͸� �д� �κ�
//			InputStreamReader recvRead = new InputStreamReader(recv);
//			// �о�� ������ ����ȯ
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
