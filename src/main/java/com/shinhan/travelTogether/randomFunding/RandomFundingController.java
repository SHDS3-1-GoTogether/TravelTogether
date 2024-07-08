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

	// �����ݵ� ��¥ ��ȿ�� �˻�
	@PostMapping("/amount.do")
	public ResponseEntity<Map<String, Object>> checkDate(@RequestBody RandomFundingDTO randomgfundingDTO,
														 HttpSession session) {
		// �ݾ� ����
		List<String> amount = rfService.getAmountAll(randomgfundingDTO);
		
		Map<String, Object> response = new HashMap<>();
		if (amount.isEmpty()) {
			response.put("status", "fail");
			response.put("data", "���Ͻô� �Ⱓ�� ������ �����ݵ� ��ǰ�� �����ϴ�.");
		} else {
			response.put("status", "ok");
			response.put("data", "amount.do");
		}
		return ResponseEntity.ok(response);
	}

	@GetMapping("/amount.do")
	public void showAmount(RandomFundingDTO randomgfundingDTO, Model model,
						   HttpSession session) {
		// ��¥ ���� �� ����
		System.out.println(randomgfundingDTO.getDeparture());
		System.out.println(randomgfundingDTO.getArrival());

		session.setAttribute("departure", randomgfundingDTO.getDeparture());
		session.setAttribute("arrival", randomgfundingDTO.getArrival());

		// �ݾ� ����
		List<String> amount = rfService.getAmountAll(randomgfundingDTO);
		amount.add("�ݾ� ����");
		model.addAttribute("amount", amount);
	}

	@GetMapping("/themes.do")
	public void showTheme(@RequestParam("amount") String amount, HttpSession session, Model model) {
		// �ݾ� ����
		session.setAttribute("amount", amount);

		// DB ��ȸ�� ���� parameterType ����
		Map<String, Object> map = new HashMap<>();
		map.put("departure", session.getAttribute("departure"));
		map.put("arrival", session.getAttribute("arrival"));

		// �׸� ����
		List<String> theme = rfService.getThemeAll(map);
		theme.add("����");
		model.addAttribute("theme", theme);
	}

	@GetMapping("/assignment.do")
	public ResponseEntity<Map<String, Object>> randomAssignment(@RequestParam("themes") List<String> themes,
			RedirectAttributes redirectAttributes, HttpSession session) {

		RandomFundingDTO randomFundingDTO = new RandomFundingDTO();
		Integer funding_id = 0;

		// �׸�, ����~���� ����
		randomFundingDTO.setThemes(themes);
		randomFundingDTO.setDeparture((String) session.getAttribute("departure"));
		randomFundingDTO.setArrival((String) session.getAttribute("arrival"));

		// ���� ����
		// data-parsing
		String getAmount = session.getAttribute("amount").toString();
		String cleanInput = getAmount.replaceAll("[^0-9~]", "");
		String[] amountSplit = cleanInput.split("~");

		if (amountSplit[0].isEmpty()) {
			// �ݾ׹���
			randomFundingDTO.setPriceLow(null);
			randomFundingDTO.setPriceHigh(null);
			funding_id = rfService.freeAmount(randomFundingDTO);
		} else {
			if (amountSplit.length == 1) {
				// 100���� �̻�
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
			response.put("status", "��û�Ͻ� ���ǿ� �´� �ݵ��� ���� ��Ȳ�Դϴ�.");
			response.put("funding_id", funding_id);
		} else {
			response.put("status", "�����ݵ� ������ �Ϸ�Ǿ����ϴ�.");
			response.put("funding_id", funding_id);
		}
		return ResponseEntity.ok(response);
	}
}
