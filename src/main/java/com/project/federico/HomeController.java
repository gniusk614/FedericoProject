package com.project.federico;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.TimeZone;

import javax.annotation.PostConstruct;

import org.codehaus.plexus.component.annotations.Component;
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

	@PostConstruct
	public void setTIme() {
		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
	}
	
}

