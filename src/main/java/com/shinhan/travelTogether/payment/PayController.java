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

		// �α��� ��� ������ ����
		int userId = 1;
		List<UserCouponDTO> couponlist = userCouponService.selectAllUserCoupon(userId);
		System.out.println(couponlist.toString());
		logger.info(couponlist.size() + "�� ��ȸ��");
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

			// JSON �������� �Ķ���� ���� ---> ���߿� �������������� �ش� ���� �����ͼ� ����
			String jsonInputString = "{" + "\"cid\": \"TC0ONETIME\"," + "\"partner_order_id\": \"partner_order_id\","
					+ "\"partner_user_id\": \"partner_user_id\"," + "\"item_name\": \"ȫ�ڻ�(ȫ����)�� ��õ�ϴ� ����\","
					+ "\"quantity\": 1," + "\"total_amount\": 2200," + "\"vat_amount\": 200,"
					+ "\"tax_free_amount\": 0," + "\"approval_url\": \"http://localhost:9090/travel/success.do\","
					+ "\"fail_url\": \"http://localhost:9090/travel/failure.do\","
					+ "\"cancel_url\": \"http://localhost:9090/travel/cancel.do\"" + "}";

			// ������ ����
			try (OutputStream os = serverConnect.getOutputStream()) {
				byte[] input = jsonInputString.getBytes("utf-8");
				os.write(input, 0, input.length);
			}

			int result = serverConnect.getResponseCode();

			InputStream recv = (result == 200) ? serverConnect.getInputStream() : serverConnect.getErrorStream();
			BufferedReader convertRead = new BufferedReader(new InputStreamReader(recv, "UTF-8"));
			return convertRead.readLine(); // ���� ������ ��ȯ
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

			// JSON �������� �Ķ���� ���� ---> ���߿� �������������� �ش� ���� �����ͼ� ����
			String jsonInputString = "{" + "\"cid\": \"TC0ONETIME\"," + "\"partner_order_id\": \"partner_order_id\","
					+ "\"partner_user_id\": \"partner_user_id\"," + "\"item_name\": \"ȫ�ڻ�(ȫ����)�� ��õ�ϴ� ����\","
					+ "\"quantity\": 1," + "\"total_amount\": 2200," + "\"vat_amount\": 200,"
					+ "\"tax_free_amount\": 0," + "\"approval_url\": \"http://localhost:9090/travel/success.do\","
					+ "\"fail_url\": \"http://localhost:9090/travel/failure.do\","
					+ "\"cancel_url\": \"http://localhost:9090/travel/cancel.do\"" + "}";

			// ������ ����
			try (OutputStream os = serverConnect.getOutputStream()) {
				byte[] input = jsonInputString.getBytes("utf-8");
				os.write(input, 0, input.length);
			}

			int result = serverConnect.getResponseCode();

			InputStream recv = (result == 200) ? serverConnect.getInputStream() : serverConnect.getErrorStream();
			BufferedReader convertRead = new BufferedReader(new InputStreamReader(recv, "UTF-8"));
			return convertRead.readLine(); // ���� ������ ��ȯ
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
//
//		return "test fail";
//	}
}
