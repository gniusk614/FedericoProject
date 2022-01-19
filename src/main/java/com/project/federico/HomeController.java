package com.project.federico;

import java.security.Principal;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = {"/home","/"}, method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		//Home -> PizzaMain 수정
		
		return "pizzaMain";
	}
	
	
	@RequestMapping(value = {"headoffice/headofficeMain","headofficeMain"}, method = RequestMethod.GET)
	public String headOfficeMain(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		//Home -> PizzaMain 수정
		
		return "headoffice/headofficeMain";
	}//headOfficeMain
	
	
	
	
	// 1) 403 오류 화면 처리
		@RequestMapping(value = "/accessError")
		public ModelAndView accessError(ModelAndView mv) {
			mv.setViewName("errorPage/exception_403");
			return mv;
		} // accessError
	
		@RequestMapping(value = "/ssLoginf")
		public ModelAndView ssLoginf(ModelAndView mv) {
			mv.addObject("message", "** Spring Security Login Test");
			return mv;
		} // ssLoginf
		
		@RequestMapping(value = "/sslogoutf")
		public ModelAndView sslogoutf(ModelAndView mv) {
			mv.addObject("message", "** Spring Security Login Test");
			mv.setViewName("securityJsp/ssLogoutForm");
			return mv;
		} // sslogoutf

		@RequestMapping(value = "/authSuccess")
		public ModelAndView authSuccess(ModelAndView mv) {
			mv.setViewName("securityJsp/authSuccessF");
			return mv;
		} // sslogoutf
		
		@RequestMapping(value = "/ssdetail")
		public ModelAndView ssdetail(ModelAndView mv, Principal principal) {
			
			System.out.println("** ssdetail principal.getName() => "+principal.getName());
			mv.setViewName("securityJsp/ssDetail");
			return mv;
		} // ssdetail
	
	
	
	
	
	
	
}
