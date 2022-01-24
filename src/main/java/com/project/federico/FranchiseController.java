package com.project.federico;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;
import paging.PageMaker;
import paging.SearchCriteria;
import service.FranchiseService;
import vo.FranchiseVO;

@RequestMapping(value = "/franchise")
@Log4j
@Controller
public class FranchiseController {

	@Autowired
	FranchiseService service;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	
	

}
// class