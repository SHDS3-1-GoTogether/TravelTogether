package com.shinhan.travelTogether;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shinhan.travelTogether.funding.FundingAdminDTO;
import com.shinhan.travelTogether.funding.FundingDTO;
import com.shinhan.travelTogether.funding.FundingService;
import com.shinhan.travelTogether.member.MemberDTO;
import com.shinhan.travelTogether.member.MemberService;
import com.shinhan.travelTogether.notification.NotificationDTO;
import com.shinhan.travelTogether.notification.NotificationService;
import com.shinhan.travelTogether.photo.PhotoService;
import com.shinhan.travelTogether.theme.ThemeService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	FundingService fundingService;
	
	@Autowired
	PhotoService photoService;
	
	@Autowired
	NotificationService notificationService;
	
	@GetMapping("/dashboard.do")	// ������ - ��ú��� ������
	public void dashboard(Model model) {
		int existingNormalMember = memberService.countExistingNormalMember();
		int maleMember = memberService.countMaleMember();
		int deletedNormalMember = memberService.countDeletedNormalMember();
		int walkerMember = memberService.getMembershipNum("walker");
		int bicycleMember = memberService.getMembershipNum("bicycle");
		int carMember = memberService.getMembershipNum("car");
		int money = memberService.getMoney();
		
		List<Map<String, Object>> monthAgoMember = memberService.getMonthAgoJoinedMemberNum();
		System.out.println("!!!!!!!!����"+monthAgoMember);
		List<String> monthList = monthAgoMember.stream()
	            .filter(x -> x.containsKey("JOIN_DATE"))
	            .map(m -> "\"" + m.get("JOIN_DATE").toString()+"\"")
	            .collect(Collectors.toList());
		List<Integer> numList = monthAgoMember.stream()
	            .filter(x -> x.containsKey("NUM"))
	            .map(m -> Integer.parseInt(m.get("NUM").toString()))
	            .collect(Collectors.toList());
		
        
		model.addAttribute("monthList",monthList);
		model.addAttribute("numList",numList);
		System.out.println("!!!!!!����"+monthList);
		
		List<Map<String, Object>> monthAgoMember2 = memberService.getMonthAgoDeletedMemberNum();
		System.out.println("!!!!!!!!����"+monthAgoMember);
		/*
		 * List<String> monthList2 = monthAgoMember2.stream() .filter(x ->
		 * x.containsKey("JOIN_DATE")) .map(m -> "\"" +
		 * m.get("JOIN_DATE").toString()+"\"") .collect(Collectors.toList());
		 */
		List<Integer> numList2 = monthAgoMember2.stream()
	            .filter(x -> x.containsKey("NUM"))
	            .map(m -> Integer.parseInt(m.get("NUM").toString()))
	            .collect(Collectors.toList());
		
        
		/* model.addAttribute("monthList2",monthList2); */
		model.addAttribute("numList2",numList2);
		
		
		
		
		
		
		model.addAttribute("existingNormalMember",existingNormalMember);
		model.addAttribute("maleMember", maleMember);
		model.addAttribute("deletedNormalMember",deletedNormalMember);
		
		model.addAttribute("walkerMember",walkerMember);
		model.addAttribute("bicycleMember",bicycleMember);
		model.addAttribute("carMember",carMember);
		model.addAttribute("money", money);
		
		int qna = memberService.getQnaNum();
		model.addAttribute("qnaNum",qna);
		

		List<Map<String, Object>> fund = memberService.getFundingState();
		System.out.println("ffffffffffffffffffff"+fund);

		List<String> fundState = fund.stream()
		        .map(m -> "\"" + m.get("FUNDING_STATE").toString() + "\"") // ���� �÷����� ���
		        .collect(Collectors.toList());

		List<Integer> fundNum = fund.stream()
				 .map(m -> Integer.parseInt(m.get("COUNT").toString()))
				 .collect(Collectors.toList());
		
		System.out.println(fundState);
		System.out.println(fundNum);

		model.addAttribute("fundState", fundState);
		model.addAttribute("fundNum", fundNum);
		// "FUNDING_STATE" Ű�� ���� ������ ���͸��Ͽ� ���ڿ� ����Ʈ�� ��ȯ
		/*
		 * List<String> fundState = fund.stream() .map(m ->
		 * m.get("FUNDING_STATE").toString()) .collect(Collectors.toList());
		 * 
		 * // "COUNT" Ű�� ���� ������ ���͸��Ͽ� ���� ����Ʈ�� ��ȯ List<Integer> fundNum = fund.stream()
		 * .map(m -> Integer.parseInt(m.get("COUNT").toString()))
		 * .collect(Collectors.toList());
		 * 
		 * model.addAttribute("fundState",fundState);
		 * model.addAttribute("fundNum",fundNum);
		 */
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
	
	@PostMapping("/memberDelete.do")
	@ResponseBody
	public String memberDelete(Model model, Integer member_id) {
		Integer result = memberService.deleteMember(member_id);
		System.out.println(result);
		return result.toString();
	}
	
	@GetMapping("/fundingList.do")	// ������ - �ݵ����� ������
	public void fundingList(Model model) {
		
	}
	
	@GetMapping("/fundingListItem.do")
	public void fundingListItem(Model model, 
			@RequestParam(value="member_type", required=false, defaultValue="-1") Integer member_type,
			@RequestParam(value="funding_state", required=false, defaultValue="-1") Integer funding_state){
		List<FundingAdminDTO> fundinglist = null;
		System.out.println("member_type="+member_type);
		System.out.println("funding_state="+funding_state);
		if(member_type == -1 && funding_state == -1) { // ���� ��ȸ���� ���� ��
			fundinglist = fundingService.selectAllAdminFunding();
			System.out.println("��ü��ȸ!! "+fundinglist);
		} else {
			fundinglist = fundingService.selectByOption(member_type, funding_state);
			System.out.println("������ȸ!! "+fundinglist);
		} 
		
	    model.addAttribute("fundinglist", fundinglist);
	}
	
	@GetMapping("/fundingInput.do")
	public void fundingInput() {
		
	}
	
	@GetMapping("/fundingDetail.do")
	public void fundingDetail(Model model, Integer funding_id) {
		model.addAttribute("fund", fundingService.selectFundingById(funding_id));
		model.addAttribute("pic", photoService.selectUserPhoto(funding_id));
		model.addAttribute("tlist", fundingService.selectFudingTheme());
	}
	
	@GetMapping("/fundingConfirm.do")
	public void fundingConfirmView(Model model, Integer id) {
		model.addAttribute("funding", fundingService.selectFundingById(id));
	}
	
	@PostMapping("/fundingConfirm.do")
	@ResponseBody
	public String fundingConfirm(
					@RequestParam Integer funding_id,
					@RequestParam Integer member_id,
					@RequestParam(value = "check", required = false) List<String> check,
					@RequestParam(value="etc_text", required = false) String etc_text) {
		Integer result = null;
		MemberDTO member = memberService.selectByMemberId(member_id);
		if(check != null && check.size() > 0) {	// ���� �ݷ�
			result = fundingService.updateFundingState(funding_id, 2);
		} else {	// ���� ����
			result = fundingService.updateFundingState(funding_id, 1);
		}
		if(member.getIs_manager() == false) {	// �Ϲ� ȸ�����Ը� �˸� ������
			String content = makeNotificationContent(check, etc_text);
			notificationService.insertNotification(new NotificationDTO(null, content, null, member_id, null));
			notificationService.notifyMessage(member_id);
		}
		
		return result.toString();
	}

	private String makeNotificationContent(List<String> check, String etc_text) {
		StringBuilder message = new StringBuilder("<h3 class=\'notify-item-header\'>[���� ���]</h3>\n");
		
		if(check != null && check.size() > 0) {	// �ݷ� �޽��� �ۼ�
			message.append("<p class='notify-item-content'>ȸ������ ����Ͻ� �ݵ��� �ݷ��Ǿ����ϴ�.</p>\n"
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
			message.append("<p class='notify-item-content'>ȸ������ ����Ͻ� �ݵ��� ���εǾ����ϴ�.</p>\n");
		}
		
		return message.toString();
	}
}
