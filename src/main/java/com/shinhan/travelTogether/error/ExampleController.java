package com.shinhan.travelTogether.error;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ExampleController {
	
	// Error Test
	@RequestMapping("/causeError")
	public String causeError() throws Exception{
		throw new Exception("This is a test exception for 500 error");
	}
	
	// NullpointError Test
	@RequestMapping("/causeNullPointerError")
    public String causeNullPointerError() {
        String str = null;
        str.length();  // NullPointerException ¹ß»ý
        return "home";
    }
}
