package com.shinhan.travelTogether.notification;

import java.net.http.HttpRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shinhan.travelTogether.member.MemberDTO;
import com.shinhan.travelTogether.member.MemberService;

@Controller
@RequestMapping("")
public class AdminNotificationController {

	@Autowired
	NotificationService notificationService;
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/admin/notificationList.do")
	public void selectAllNotification(Model model) {
		List<NotificationDTO> notificationlist = notificationService.selectAll();
		model.addAttribute("notificationlist", notificationlist);
	}
	
	@GetMapping("/admin/sendNotification.do")
	public String sendNotificationView() {
		
		return "notification/sendNotification";
	}
	
	@PostMapping("/admin/sendNotification.do")
	public String sendNotification(NotificationDTO notification, RedirectAttributes attr) {
		System.out.println("!!member_id = "+notification.getMember_id());
		System.out.println(notification.getMessage_content());
		
		int notification_id = notificationService.insertNotification(notification);
		if(notification_id > 0) { 
			attr.addFlashAttribute("insertResult",1); // 알림 등록 성공 
		} else { 
			attr.addFlashAttribute("insertResult", 0); // 알림 등록실패 
		}
		
		return "redirect:/admin/notificationList.do";
	}
	
	@GetMapping("notificationTest")
	public String notificationTest() {
		return "/common/notification";
	}
	
	@GetMapping("/admin/notificationInsert.do")
	public void insertNotificationView(Model model) {
		List<MemberDTO> memberlist = memberService.selectAllMember();
		model.addAttribute("memberlist", memberlist);
	}
	
	@PostMapping("/admin/notificationInsert.do")
	public String insertNotification(@RequestParam("selectedMembers") String selectedMembers,
            						@RequestParam("message_content") String message_content) {
		
		System.out.println("selectedMembers = "+ selectedMembers);
		String[] memberIdList = selectedMembers.split(",");
		ArrayList<Integer> resultlist = new ArrayList<>(); 
		for(String member_id : memberIdList) {
			System.out.println("member_id = "+member_id);
			int result = notificationService.insertNotification(new NotificationDTO(null, message_content, null, Integer.parseInt(member_id)));
			resultlist.add(result);
		}
		System.out.println("알림 전송 결과 = "+resultlist.toString());
		
		return "redirect:/admin/notificationList.do";
	}
}
