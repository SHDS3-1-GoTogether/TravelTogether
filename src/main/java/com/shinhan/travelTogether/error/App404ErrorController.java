package com.shinhan.travelTogether.error;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/error")
public class App404ErrorController {
	
	@RequestMapping("/404")
	 public String handle404() {
        return "error/404";
    }

}
