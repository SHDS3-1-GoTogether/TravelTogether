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
	
	@GetMapping("/dashboard.do")	// ������ - ��ú��� ������
	public void dashboard() {
		
	}
	
	@GetMapping("/memberList.do")	// ������ - ȸ������ ������
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
	
	@GetMapping("/fundingList.do")	// ������ - �ݵ����� ������
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
		if(check != null && check.size() > 0) {	// ���� �ݷ�
			result = fundingService.updateFundingState(funding_id, 2);
		} else {	// ���� ����
			result = fundingService.updateFundingState(funding_id, 1);
		}
		String content = makeNotificationContent(check, etc_text);
		notificationService.insertNotification(new NotificationDTO(null, content, null, member_id));
		notificationService.notifyMessage(member_id);
		
		return result.toString();
	}

	private String makeNotificationContent(List<String> check, String etc_text) {
		StringBuilder message = new StringBuilder("<h3 class=\'notify-item-header\'>[���� ���]</h3>\n");
		
		if(check != null && check.size() > 0) {	// �ݷ� �޽��� �ۼ�
			message.append("<p>ȸ������ ����Ͻ� �ݵ��� �ݷ��Ǿ����ϴ�.</p>\n"
			+ "<p>�ݷ�����</p>\n<ul>");
			
			for(String c: check) {
				if(c.equals("1")) {
					message.append("<li>Ȯ�κҰ����� �������Դϴ�.</li>");
				} else if(c.equals("2")) {
					message.append("<li>���� ��Ұ� ���ؿ� �������� �ʽ��ϴ�.</li>");
				} else if(c.equals("3")) {
					message.append("<li>"+etc_text+"</li>");
				}
			}
		} else {
			message.append("<p>ȸ������ ����Ͻ� �ݵ��� ���εǾ����ϴ�.</p>\n");
		}
		
		return message.toString();
	}
}
