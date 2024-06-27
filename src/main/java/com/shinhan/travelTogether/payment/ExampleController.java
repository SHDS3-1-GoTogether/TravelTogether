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
        // ������ ó�� ���� (��: �����ͺ��̽� ���� ��)
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);

        // ����� �𵨿� �߰��Ͽ� �信 ����
        model.addAttribute("message", "�����Ͱ� ���������� ����Ǿ����ϴ�.");

        // ��� �������� �̵�
        return "/payment/cancel";
    }
}