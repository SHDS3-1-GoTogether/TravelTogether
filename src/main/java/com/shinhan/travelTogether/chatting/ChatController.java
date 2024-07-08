package com.shinhan.travelTogether.chatting;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.shinhan.travelTogether.funding.FundingDTO;
import com.shinhan.travelTogether.funding.FundingService;
import com.shinhan.travelTogether.member.MemberDTO;

@Controller
public class ChatController {

	@Autowired
	ChatService chatService;
	
	@Autowired
	FundingService fundingService;
	
	int fundId = 0;
	
	@GetMapping("/mypage/chatroom.do")
	public String chatroom(HttpSession session, Model model) {
		
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		int memberId = member.getMember_id();
		model.addAttribute("chatRoom", chatService.getChatRoom(memberId));
		return "mypage/chatroom";
	}
	
	@GetMapping(value="/chatroomList", produces="application/json")
	@ResponseBody
	public List<FundingDTO> chatroomList(HttpSession session) {
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		int memberId = member.getMember_id();
		return chatService.getChatRoom(memberId);
	}

	@GetMapping("/chat/{fundingId}")
	public String chat(@PathVariable("fundingId") int fundingId, Model model, HttpServletResponse response, HttpSession session) throws IOException {
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		List<Object> roomInfo = chatService.openRoomCheck(fundingId, member.getMember_id());
		System.out.println("************************"+roomInfo);
		if(!roomInfo.contains(fundingId)) {
			return "redirect:/mypage/chatroom.do";
			};
		model.addAttribute("beforeChat", chatService.getChatList(fundingId));
		fundId = fundingId;
		return "chat/chatting";
	}

	@PostMapping("/chat/{fundingId}/save.do")
	public void chatSave(@PathVariable("fundingId") int fundingId,
			@RequestParam("message_content") String message_content, HttpServletResponse response,
			HttpSession session) {
		MemberDTO member = (MemberDTO) session.getAttribute("member");
		chatService.submit(fundingId, message_content, member.getMember_id());
	}
	
	@GetMapping(value = "/getUsername", produces = MediaType.TEXT_PLAIN_VALUE + "; charset=UTF-8")
    @ResponseBody
    public String getUsername(HttpSession session) {
        MemberDTO member = (MemberDTO) session.getAttribute("member");
        if (member != null) {
            return member.getNickname();
        } else {
            return "Anonymous";
            // 익명 사용자 처리 추가
        }
    }
	
	/*
	 * @GetMapping(value = "/getFunding", produces = MediaType.TEXT_PLAIN_VALUE +
	 * "; charset=UTF-8")
	 * 
	 * @ResponseBody public void getFunding(Model model) { FundingDTO funding =
	 * fundingService.selectFundingById(fundId); funding.getEnd_date(); }
	 */
	
	@GetMapping(value = "/getFunding", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public Date getFunding(@RequestParam("fundId") int fundId) {
	    FundingDTO funding = fundingService.selectFundingById(fundId);
	    return funding.getEnd_date();
	}
}