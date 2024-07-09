package com.shinhan.travelTogether.error;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {
	
	@ExceptionHandler(Exception.class)
    public String handleException(Exception ex, Model model) {
        model.addAttribute("statusCode", "500");
        model.addAttribute("message", ex.getMessage());
        return "error/500";
    }

}
