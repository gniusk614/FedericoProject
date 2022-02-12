package com.project.federico;

import java.util.TimeZone;

import javax.annotation.PostConstruct;

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

	//어플리케이션 첫 구동시 timezone 설정
	@PostConstruct
	public void setTIme() {
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
	}
	
}

