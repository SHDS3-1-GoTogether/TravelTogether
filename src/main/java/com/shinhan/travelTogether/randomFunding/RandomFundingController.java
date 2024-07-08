package com.shinhan.travelTogether.randomFunding;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/randomFunding")
public class RandomFundingController {

	@Autowired
	RandomFundingService rfService;

	@GetMapping("/schedule.do")
	public void showSchedule() {

	}

	// 랜덤펀딩 날짜 유효성 검사
	@PostMapping("/amount.do")
	public ResponseEntity<Map<String, Object>> checkDate(@RequestBody RandomFundingDTO randomgfundingDTO,
														 HttpSession session) {
		// 금액 선택
		List<String> amount = rfService.getAmountAll(randomgfundingDTO);
		
		Map<String, Object> response = new HashMap<>();
		if (amount.isEmpty()) {
			response.put("status", "fail");
			response.put("data", "원하시는 기간에 예정된 여행펀딩 상품이 없습니다.");
		} else {
			response.put("status", "ok");
			response.put("data", "amount.do");
		}
		return ResponseEntity.ok(response);
	}

	@GetMapping("/amount.do")
	public void showAmount(RandomFundingDTO randomgfundingDTO, Model model,
						   HttpSession session) {
		// 날짜 선택 및 저장
		System.out.println(randomgfundingDTO.getDeparture());
		System.out.println(randomgfundingDTO.getArrival());

		session.setAttribute("departure", randomgfundingDTO.getDeparture());
		session.setAttribute("arrival", randomgfundingDTO.getArrival());

		// 금액 선택
		List<String> amount = rfService.getAmountAll(randomgfundingDTO);
		amount.add("금액 무관");
		model.addAttribute("amount", amount);
	}

	@GetMapping("/themes.do")
	public void showTheme(@RequestParam("amount") String amount, HttpSession session, Model model) {
		// 금액 저장
		session.setAttribute("amount", amount);

		// DB 조회를 위한 parameterType 생성
		Map<String, Object> map = new HashMap<>();
		map.put("departure", session.getAttribute("departure"));
		map.put("arrival", session.getAttribute("arrival"));

		// 테마 선택
		List<String> theme = rfService.getThemeAll(map);
		theme.add("미정");
		model.addAttribute("theme", theme);
	}

	@GetMapping("/assignment.do")
	public ResponseEntity<Map<String, Object>> randomAssignment(@RequestParam("themes") List<String> themes,
			RedirectAttributes redirectAttributes, HttpSession session) {

		RandomFundingDTO randomFundingDTO = new RandomFundingDTO();
		Integer funding_id = 0;

		// 테마, 시작~종료 일자
		randomFundingDTO.setThemes(themes);
		randomFundingDTO.setDeparture((String) session.getAttribute("departure"));
		randomFundingDTO.setArrival((String) session.getAttribute("arrival"));

		// 가격 설정
		// data-parsing
		String getAmount = session.getAttribute("amount").toString();
		String cleanInput = getAmount.replaceAll("[^0-9~]", "");
		String[] amountSplit = cleanInput.split("~");

		if (amountSplit[0].isEmpty()) {
			// 금액무관
			randomFundingDTO.setPriceLow(null);
			randomFundingDTO.setPriceHigh(null);
			funding_id = rfService.freeAmount(randomFundingDTO);
		} else {
			if (amountSplit.length == 1) {
				// 100만원 이상
				randomFundingDTO.setPriceLow(Integer.parseInt(amountSplit[0]) * 10000);
				// randomFundingDTO.setPriceHigh(Integer.parseInt(amountSplit[0])*10000);
				funding_id = rfService.freeAmount(randomFundingDTO);
			} else {
				randomFundingDTO.setPriceLow(Integer.parseInt(amountSplit[0]) * 10000);
				randomFundingDTO.setPriceHigh(Integer.parseInt(amountSplit[1]) * 10000);
				funding_id = rfService.normalAmount(randomFundingDTO);
			}
		}

		Map<String, Object> response = new HashMap<>();

		if (funding_id == null) {
			response.put("status", "요청하신 조건에 맞는 펀딩이 없는 상황입니다.");
			response.put("funding_id", funding_id);
		} else {
			response.put("status", "랜덤펀딩 배정이 완료되었습니다.");
			response.put("funding_id", funding_id);
		}
		return ResponseEntity.ok(response);
	}
}
