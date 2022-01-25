package com.project.federico;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	

	@RequestMapping(value = {"/home","/"})
	public String home() {
			System.out.println("거기있니?");
			System.out.println("Federico님이 입장하셨습니다.");
			return "redirect:client/home";
	}

	
}
