package com.shinhan.travelTogether;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.shinhan.travelTogether.funding.FundingAdminDTO;
import com.shinhan.travelTogether.funding.FundingDTO;
import com.shinhan.travelTogether.funding.FundingService;
import com.shinhan.travelTogether.member.MemberDTO;
import com.shinhan.travelTogether.member.MemberService;
import com.shinhan.travelTogether.notification.NotificationDTO;
import com.shinhan.travelTogether.notification.NotificationService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	FundingService fundingService;
	
	@Autowired
	NotificationService notificationService;
	
	@GetMapping("/dashboard.do")	// 관리자 - 대시보드 페이지
	public void dashboard() {
		
	}
	
	@GetMapping("/memberList.do")	// 관리자 - 회원관리 페이지
	public void memberList(Model model, 
			@RequestParam(value="word", required=false, defaultValue = "") String word) {
		List<MemberDTO> memberlist = null;
		if(word.equals("")) {			
			memberlist = memberService.selectAllNormal();
		} else {
			memberlist = memberService.searchByWord(word);
		}
		
		model.addAttribute("memberlist", memberlist);
	}
	
	@GetMapping("/fundingList.do")	// 관리자 - 펀딩관리 페이지
	public void fundingList(Model model) {
		
	}
	
	@GetMapping("/fundingListItem.do")
	public void fundingListItem(Model model) {
		List<FundingAdminDTO> fundinglist = fundingService.selectAllAdminFunding();
	    model.addAttribute("fundinglist", fundinglist);
	}
	
	@GetMapping("/fundingConfirm.do")
	public void fundingConfirmView(Model model, Integer id) {
		FundingDTO funding = fundingService.selectFundingById(id);
		model.addAttribute("funding", funding);
	}
	
	@PostMapping("/fundingConfirm.do")
	@ResponseBody
	public String fundingConfirm(
					@RequestParam Integer funding_id,
					@RequestParam Integer member_id,
					@RequestParam(value = "check", required = false) List<String> check,
					@RequestParam(value="etc_text", required = false) String etc_text) {
		Integer result = null;
		System.out.println(check);
		if(check != null && check.size() > 0) {	// 컨펌 반려
			result = fundingService.updateFundingState(funding_id, 2);
		} else {	// 컨펌 승인
			result = fundingService.updateFundingState(funding_id, 1);
		}
		String content = makeNotificationContent(check, etc_text);
		notificationService.insertNotification(new NotificationDTO(null, content, null, member_id));
		notificationService.notifyMessage(member_id);
		
		return result.toString();
	}

	private String makeNotificationContent(List<String> check, String etc_text) {
		StringBuilder message = new StringBuilder("<h3 class=\'notify-item-header\'>[컨펌 결과]</h3>\n");
		
		if(check != null && check.size() > 0) {	// 반려 메시지 작성
			message.append("<p>회원님이 등록하신 펀딩이 반려되었습니다.</p>\n"
			+ "<p>반려사유</p>\n<ul>");
			
			for(String c: check) {
				if(c.equals("1")) {
					message.append("<li>확인불가능한 교통편입니다.</li>");
				} else if(c.equals("2")) {
					message.append("<li>숙박 장소가 기준에 부합하지 않습니다.</li>");
				} else if(c.equals("3")) {
					message.append("<li>"+etc_text+"</li>");
				}
			}
		} else {
			message.append("<p>회원님이 등록하신 펀딩이 승인되었습니다.</p>\n");
		}
		
		return message.toString();
	}
}
