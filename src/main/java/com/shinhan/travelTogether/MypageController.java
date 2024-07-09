package com.shinhan.travelTogether;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.travelTogether.comment.CommentService;
import com.shinhan.travelTogether.coupon.CouponService;
import com.shinhan.travelTogether.coupon.UserCouponDTO;
import com.shinhan.travelTogether.funding.FundingDTO;
import com.shinhan.travelTogether.funding.FundingService;
import com.shinhan.travelTogether.member.MemberDTO;
import com.shinhan.travelTogether.member.MemberService;
import com.shinhan.travelTogether.notification.NotificationDTO;
import com.shinhan.travelTogether.notification.NotificationService;

import com.shinhan.travelTogether.payment.PaymentService;
import com.shinhan.travelTogether.photo.PhotoDTO;
import com.shinhan.travelTogether.photo.PhotoService;
import com.shinhan.travelTogether.review.ReviewDTO;
import com.shinhan.travelTogether.review.ReviewService;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);

	@Autowired
	CouponService userCouponService;

	@Autowired
	MemberService mService;

	@Autowired
	NotificationService notificationService;

	@Autowired
	ReviewService reviewService;

	@Autowired
	FundingService fundingService;

	@Autowired
	PaymentService paymentService;

	@Autowired
	CommentService commentService;
	
	@Autowired
	PhotoService pService;

	@GetMapping("/correction.do")
	public void correction(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);
	}

	@GetMapping("/correctionForm.do")
	public void correctionForm(@RequestParam("login_id") String login_id, @RequestParam("login_pwd") String login_pwd,
			HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws IOException, ServletException {
		System.out.println("testestsetstsetetse");
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		String message = "0";
		System.out.println(login_id);
		System.out.println(login_pwd);
		System.out.println(member.getLogin_id());
		System.out.println(member.getLogin_pwd());
		if (login_id.equals(member.getLogin_id()) && login_pwd.equals(member.getLogin_pwd())) {
			message = "1";
		}
		response.getWriter().append(message);
	}

	@PostMapping("/correction.do")
	public String join(MemberDTO member, RedirectAttributes redirectAttr, HttpSession session) throws ParseException {
		System.out.println(member);
		int result = mService.updateMember(member);
		String message;
		if (result > 0) {
			message = "update success";
			session.setAttribute("member", mService.loginChk(member.getLogin_id(), member.getLogin_pwd()));
		} else {
			message = "update fail";
		}

		return "redirect:correction.do";
	}

	@GetMapping("/couponList.do")
	public void userCouponList(Model model, HttpSession session) {

		// 로그인 기능 구현시 수정
		int userId = ((MemberDTO) session.getAttribute("member")).getMember_id();
		List<UserCouponDTO> couponlist = userCouponService.selectAllUserCoupon(userId);
		System.out.println("!!!!쿠폰리스트!!!! " + couponlist);

		List<UserCouponDTO> uniqueCouponlist = new ArrayList<UserCouponDTO>();

		Map<Integer, Long> couponCountMap = couponlist.stream()
				.collect(Collectors.groupingBy(UserCouponDTO::getCoupon_id, Collectors.counting()));

		// 각 쿠폰에 동일한 coupon_id의 개수를 설정

		int coupon_id = -1;
		int length = couponlist.size();
		for (int i = 0; i < length; i++) {
			System.out.println("index" + i);
			if(couponlist.get(i).getCoupon_id() != coupon_id) {
				coupon_id = couponlist.get(i).getCoupon_id();
				couponlist.get(i).setCount(couponCountMap.get(coupon_id).intValue());
				uniqueCouponlist.add(couponlist.get(i));
			}
		}

		System.out.println("!!!!수정후 쿠폰리스트!!!! " + uniqueCouponlist);
		model.addAttribute("couponlist", uniqueCouponlist);
	}

	@GetMapping("/notificationList.do")
	public void notificationList(Model model, HttpSession session) {
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();
		List<NotificationDTO> notificationlist = notificationService.selectByMemberId(member_id);
		model.addAttribute("notificationlist", notificationlist);
	}

	@GetMapping("/reviewList.do")
	public void reviewList(Model model, HttpSession session) {
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();
		List<ReviewDTO> reviewlist = reviewService.selectMyreviewAll(member_id);
		//System.out.println(reviewlist);
		//logger.info(reviewlist.size() + "건의 나의 후기 조회됨");
		model.addAttribute("reviewlist", reviewlist);

		// List<FundingDTO> fundinglist = fundingService.selectAll("selectAllByDate");
		// List<PaymentDTO> paymentlist = paymentService.selectAllPayment();
		List<FundingDTO> reviewlist2 = reviewService.selectMyWritableReview(member_id);
		// model.addAttribute("fundinglist", fundinglist);
		// model.addAttribute("patmentlist", paymentlist);
		model.addAttribute("reviewlist2", reviewlist2);
	}

	@GetMapping("/reviewInsert.do")
	public void reviewInsert(Model model, HttpSession session, Integer funding_id) {
		// model.addAttribute("", reviewService.);
		if (session.getAttribute("insertResult") == null) {
			session.setAttribute("insertResult", -1);
		}
		model.addAttribute("funding_id", funding_id);
	}

	@PostMapping("/reviewInsert.do")
	public String reviewInsert(Model model, HttpServletRequest request, RedirectAttributes attr, HttpSession session,
			@RequestParam(value="review_photo") List<MultipartFile> review_photo,
			@RequestParam("review_content") String review_content, Integer funding_id ) throws IOException {
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();
		//int funding_id = ((FundingDTO) session.getAttribute("funding_id")).getFunding_id();
		ReviewDTO review = new ReviewDTO();
		review.setMember_id(member_id);
		review.setFunding_id(funding_id);
		review.setReview_content(review_content);
		int result = reviewService.insertMyreview(review);
		attr.addFlashAttribute("insertResult", result);
		if(result == 1) {
			insertPhotoList(review_photo, "/review", funding_id);
		}
		//System.out.println("~~~~~여기여기여기!!!!!~~~~~~~~" + review_photo);
		return "redirect:reviewList.do";
	}

	public void insertPhotoList(List<MultipartFile> fileList, String detailPath, Integer funding_id) throws IOException {
		if(!fileList.isEmpty()) {
			for (MultipartFile mf : fileList) {
				
				if(mf.isEmpty())
					continue;
				
				String imgPath = pService.upload(mf, detailPath);
				
				
				PhotoDTO photo = new PhotoDTO();
				photo.setFunding_id(funding_id);
				photo.setPhoto_name(imgPath);
				photo.setPurpose(1);
				photo.setReview_id(reviewService.getReviewId());
				
				String photoResult = pService.insertPhoto(photo) + "개 db등록";
				System.out.println(photoResult);
			}
		}
	}
	
	@GetMapping("/paymentList.do")
	public void paymentList(Model model, HttpSession session) {
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();

		List<Map<String, Object>> paymentList = paymentService.paymentRecipe(member_id);

		logger.info(paymentList.size() + "건 결제내역 조회됨");

		for (Map<String, Object> map : paymentList) {
			System.out.println(map);
			;
		}

		model.addAttribute("paymentDetail", paymentList);
	}

	@GetMapping("/refundList.do")
	public String refundList(Model model, HttpSession session) {
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();

		List<Map<String, Object>> refundList = paymentService.refundRecipe(member_id);
		logger.info(refundList.size() + "건 환불내역 조회됨");

		// test
		for (Map<String, Object> map : refundList) {
			System.out.println(map);
			;
		}
		model.addAttribute("refundDetail", refundList);

		return "mypage/paymentList";
	}
	
	@GetMapping("/delete.do")
	public String delete(HttpSession session){
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();
		Integer result = mService.deleteMember(member_id);
		return "redirect:/auth/logout.do";
	}
	
	@GetMapping("/myFunding.do")
	public void myFunding(Model model, HttpSession session) {
		int member_id = ((MemberDTO) session.getAttribute("member")).getMember_id();
		
		List<FundingDTO> fundinglist = fundingService.selectAllByMemberId(member_id);
		model.addAttribute("fundinglist", fundinglist);
	}
}