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

		return "redirect:client/home";
	}

	
}
