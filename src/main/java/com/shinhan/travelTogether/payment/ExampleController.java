package com.shinhan.travelTogether.payment;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping(value = "/payment")
public class ExampleController {

    @PostMapping("/submitData.do")
    public String submitData(@RequestParam("name") String name, @RequestParam("email") String email, Model model) {
        // 데이터 처리 로직 (예: 데이터베이스 저장 등)
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);

        // 결과를 모델에 추가하여 뷰에 전달
        model.addAttribute("message", "데이터가 성공적으로 제출되었습니다.");

        // 결과 페이지로 이동
        return "/payment/cancel";
    }
}