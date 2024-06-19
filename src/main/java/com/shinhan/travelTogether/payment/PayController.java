package com.shinhan.travelTogether.payment;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shinhan.travelTogether.coupon.CouponService;
import com.shinhan.travelTogether.coupon.UserCouponDTO;

@Controller
public class PayController {
	
	@Autowired
	CouponService userCouponService;

	private static final Logger logger = LoggerFactory.getLogger(PayController.class);

	@RequestMapping(value = "/reward.do")
	public String showRewardPage() {
		logger.info("Handling /travel/reward request");
		return "payment/reward";
	}

	@RequestMapping(value = "/payment.do")
	public String showPaymentPage() {
		logger.info("Handling /travel/payment request");
		return "payment/pay";
	}

	@RequestMapping(value = "/payment2.do")
	public String testPaymentPage(Model model) {

		// 로그인 기능 구현시 수정
		int userId = 1;
		List<UserCouponDTO> couponlist = userCouponService.selectAllUserCoupon(userId);
		System.out.println(couponlist.toString());
		logger.info(couponlist.size() + "건 조회됨");
		model.addAttribute("couponlist", couponlist);
		return "payment/pay2";
	}

	@RequestMapping(value = "/pay_test.do")
	public String showNpayTest() {
		return "payment/checkout";
	}

//	@RequestMapping(value = "/success.do")
//	public String showSuccessPage() {
//		logger.info("Handling /travel/payment request success");
//		return "payment/success";
//	}
	@RequestMapping(value = "/success.do")
	public String showSuccessPage() {
		logger.info("Handling /travel/payment request success");
		return "payment/success";
	}

	@RequestMapping(value = "/failure.do")
	public String showFailurePage() {
		logger.info("Handling /travel/payment request failure");
		return "payment/fail";
	}

	@RequestMapping(value = "/cancel.do")
	public String showCancelPage() {
		logger.info("Handling /travel/payment request cancel");
		return "payment/cancel";
	}

	@RequestMapping(value = "/processKakaopay.do")
	@ResponseBody
	public String kakaopay() {
		logger.info("Starting payment process");

		try {
			URL urlPay = new URL("https://open-api.kakaopay.com/online/v1/payment/ready");
			HttpURLConnection serverConnect = (HttpURLConnection) urlPay.openConnection();
			serverConnect.setRequestMethod("POST");
			serverConnect.setRequestProperty("Authorization",
					"DEV_SECRET_KEY DEV23FBE64E3F7ADB0820BCBD20A8C57B6F2197C");
			serverConnect.setRequestProperty("Content-Type", "application/json");
			serverConnect.setDoOutput(true);

			// JSON 형식으로 파라미터 생성 ---> 나중에 결제페이지에서 해당 정보 가져와서 적용
			String jsonInputString = "{" + "\"cid\": \"TC0ONETIME\"," + "\"partner_order_id\": \"partner_order_id\","
					+ "\"partner_user_id\": \"partner_user_id\"," + "\"item_name\": \"홍박사(홍정민)가 추천하는 여행\","
					+ "\"quantity\": 1," + "\"total_amount\": 2200," + "\"vat_amount\": 200,"
					+ "\"tax_free_amount\": 0," + "\"approval_url\": \"http://localhost:9090/travel/success.do\","
					+ "\"fail_url\": \"http://localhost:9090/travel/failure.do\","
					+ "\"cancel_url\": \"http://localhost:9090/travel/cancel.do\"" + "}";

			// 데이터 전송
			try (OutputStream os = serverConnect.getOutputStream()) {
				byte[] input = jsonInputString.getBytes("utf-8");
				os.write(input, 0, input.length);
			}

			int result = serverConnect.getResponseCode();

			InputStream recv = (result == 200) ? serverConnect.getInputStream() : serverConnect.getErrorStream();
			BufferedReader convertRead = new BufferedReader(new InputStreamReader(recv, "UTF-8"));
			return convertRead.readLine(); // 응답 데이터 반환
		} catch (MalformedURLException e) {
			logger.error("MalformedURLException", e);
		} catch (IOException e) {
			logger.error("IOException", e);
		}

		return "Payment processing failed";
	}

	@RequestMapping(value = "/processNpay.do")
	@ResponseBody
	public String npay() {
		logger.info("Starting payment process");

		try {
			URL urlPay = new URL("https://open-api.kakaopay.com/online/v1/payment/ready");
			HttpURLConnection serverConnect = (HttpURLConnection) urlPay.openConnection();
			serverConnect.setRequestMethod("POST");
			serverConnect.setRequestProperty("Authorization",
					"DEV_SECRET_KEY DEV23FBE64E3F7ADB0820BCBD20A8C57B6F2197C");
			serverConnect.setRequestProperty("Content-Type", "application/json");
			serverConnect.setDoOutput(true);

			// JSON 형식으로 파라미터 생성 ---> 나중에 결제페이지에서 해당 정보 가져와서 적용
			String jsonInputString = "{" + "\"cid\": \"TC0ONETIME\"," + "\"partner_order_id\": \"partner_order_id\","
					+ "\"partner_user_id\": \"partner_user_id\"," + "\"item_name\": \"홍박사(홍정민)가 추천하는 여행\","
					+ "\"quantity\": 1," + "\"total_amount\": 2200," + "\"vat_amount\": 200,"
					+ "\"tax_free_amount\": 0," + "\"approval_url\": \"http://localhost:9090/travel/success.do\","
					+ "\"fail_url\": \"http://localhost:9090/travel/failure.do\","
					+ "\"cancel_url\": \"http://localhost:9090/travel/cancel.do\"" + "}";

			// 데이터 전송
			try (OutputStream os = serverConnect.getOutputStream()) {
				byte[] input = jsonInputString.getBytes("utf-8");
				os.write(input, 0, input.length);
			}

			int result = serverConnect.getResponseCode();

			InputStream recv = (result == 200) ? serverConnect.getInputStream() : serverConnect.getErrorStream();
			BufferedReader convertRead = new BufferedReader(new InputStreamReader(recv, "UTF-8"));
			return convertRead.readLine(); // 응답 데이터 반환
		} catch (MalformedURLException e) {
			logger.error("MalformedURLException", e);
		} catch (IOException e) {
			logger.error("IOException", e);
		}

		return "Payment processing failed";
	}

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
//
//		return "test fail";
//	}
}
