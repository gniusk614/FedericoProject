package com.project.federico;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;
import service.TestService;
import vo.TestVO;

@RequestMapping(value = "/test")
@Log4j
@Controller
public class TestController {

	@Autowired
	TestService service;
	
	
	@RequestMapping(value = "/datatest")
	public ModelAndView datatest(ModelAndView mv) {
		
		List<TestVO> list = new ArrayList<TestVO>();
		list = service.selectList();
		if(list != null && list.size()>0) mv.addObject("list", list);
		else mv.addObject("message", "에러");
		
		
		mv.setViewName("test/datatest");
		return mv;
	}
	
	@RequestMapping(value = "/tindexf")
	public ModelAndView tindexf(ModelAndView mv) {
		
		mv.setViewName("test/tindex");
		return mv;
	}
	
	
}//class
