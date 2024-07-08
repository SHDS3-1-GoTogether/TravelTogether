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
	
	@GetMapping("/dashboard.do")	// 관리자 - 대시보드 페이지
	public void dashboard(Model model) {
		int existingNormalMember = memberService.countExistingNormalMember();
		int maleMember = memberService.countMaleMember();
		int deletedNormalMember = memberService.countDeletedNormalMember();
		int walkerMember = memberService.getMembershipNum("walker");
		int bicycleMember = memberService.getMembershipNum("bicycle");
		int carMember = memberService.getMembershipNum("car");
		int money = memberService.getMoney();
		
		List<Map<String, Object>> monthAgoMember = memberService.getMonthAgoJoinedMemberNum();
		System.out.println("!!!!!!!!저기"+monthAgoMember);
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
		System.out.println("!!!!!!여기"+monthList);
		
		List<Map<String, Object>> monthAgoMember2 = memberService.getMonthAgoDeletedMemberNum();
		System.out.println("!!!!!!!!저기"+monthAgoMember);
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
		        .map(m -> "\"" + m.get("FUNDING_STATE").toString() + "\"") // 실제 컬럼명을 사용
		        .collect(Collectors.toList());

		List<Integer> fundNum = fund.stream()
				 .map(m -> Integer.parseInt(m.get("COUNT").toString()))
				 .collect(Collectors.toList());
		
		System.out.println(fundState);
		System.out.println(fundNum);

		model.addAttribute("fundState", fundState);
		model.addAttribute("fundNum", fundNum);
		// "FUNDING_STATE" 키를 가진 값들을 필터링하여 문자열 리스트로 변환
		/*
		 * List<String> fundState = fund.stream() .map(m ->
		 * m.get("FUNDING_STATE").toString()) .collect(Collectors.toList());
		 * 
		 * // "COUNT" 키를 가진 값들을 필터링하여 정수 리스트로 변환 List<Integer> fundNum = fund.stream()
		 * .map(m -> Integer.parseInt(m.get("COUNT").toString()))
		 * .collect(Collectors.toList());
		 * 
		 * model.addAttribute("fundState",fundState);
		 * model.addAttribute("fundNum",fundNum);
		 */
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
	
	@PostMapping("/memberDelete.do")
	@ResponseBody
	public String memberDelete(Model model, Integer member_id) {
		Integer result = memberService.deleteMember(member_id);
		System.out.println(result);
		return result.toString();
	}
	
	@GetMapping("/fundingList.do")	// 관리자 - 펀딩관리 페이지
	public void fundingList(Model model) {
		
	}
	
	@GetMapping("/fundingListItem.do")
	public void fundingListItem(Model model, 
			@RequestParam(value="member_type", required=false, defaultValue="-1") Integer member_type,
			@RequestParam(value="funding_state", required=false, defaultValue="-1") Integer funding_state){
		List<FundingAdminDTO> fundinglist = null;
		System.out.println("member_type="+member_type);
		System.out.println("funding_state="+funding_state);
		if(member_type == -1 && funding_state == -1) { // 조건 조회하지 않을 때
			fundinglist = fundingService.selectAllAdminFunding();
			System.out.println("전체조회!! "+fundinglist);
		} else {
			fundinglist = fundingService.selectByOption(member_type, funding_state);
			System.out.println("조건조회!! "+fundinglist);
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
		if(check != null && check.size() > 0) {	// 컨펌 반려
			result = fundingService.updateFundingState(funding_id, 2);
		} else {	// 컨펌 승인
			result = fundingService.updateFundingState(funding_id, 1);
		}
		if(member.getIs_manager() == false) {	// 일반 회원에게만 알림 보내기
			String content = makeNotificationContent(check, etc_text);
			notificationService.insertNotification(new NotificationDTO(null, content, null, member_id, null));
			notificationService.notifyMessage(member_id);
		}
		
		return result.toString();
	}

	private String makeNotificationContent(List<String> check, String etc_text) {
		StringBuilder message = new StringBuilder("<h3 class=\'notify-item-header\'>[컨펌 결과]</h3>\n");
		
		if(check != null && check.size() > 0) {	// 반려 메시지 작성
			message.append("<p class='notify-item-content'>회원님이 등록하신 펀딩이 반려되었습니다.</p>\n"
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
			message.append("<p class='notify-item-content'>회원님이 등록하신 펀딩이 승인되었습니다.</p>\n");
		}
		
		return message.toString();
	}
}
