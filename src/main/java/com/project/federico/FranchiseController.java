package com.project.federico;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;
import service.FranchiseService;
import service.OrderService;
import vo.FranchiseVO;
import vo.OrderDetailListVO;
import vo.OrderListVO;

@RequestMapping(value = "/franchise")
@Log4j
@Controller
public class FranchiseController {

	@Autowired
	FranchiseService service;
	@Autowired
	OrderService orderService;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	
	

	
	// 주문내역 상세조회 by orderNumber
	@RequestMapping(value = "/selectDetail")
	public ModelAndView selectDetail(ModelAndView mv, OrderDetailListVO detailVo, @RequestParam("orderNumber") int orderNumber) {
		List<OrderDetailListVO> detailList = new ArrayList<OrderDetailListVO>();
		detailList = orderService.selectDetailbyOrderNumber(orderNumber);
		if(detailList.size() > 0 && detailList != null) {
			mv.addObject("detailList",detailList);
			mv.addObject("success", "success");
		}else {
			mv.addObject("success","fail");
		}
		
		mv.setViewName("jsonView");
		return mv;	
	}
	
	// 배송소요시간 update
	@RequestMapping(value = "/updatedeliverytime")
	public ModelAndView updateDeliveryTime(ModelAndView mv, FranchiseVO vo) {
		if (service.updateDeliveryTime(vo) > 1) {
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	
	// 프랜차이즈 home + 해당가맹점 주문내역 조회
	@RequestMapping(value = "/home")
	public ModelAndView home(ModelAndView mv, HttpSession session, OrderListVO orderListVo){
			session.setAttribute("fcId", "#fc01");
		
		if (session.getAttribute("fcId") != null) {
			List<OrderListVO> list = new ArrayList<OrderListVO>();
			orderListVo.setCompleteYN("N"); //DB에서 default 처리해주기

			orderListVo.setFcId((String)session.getAttribute("fcId"));
			
			list = orderService.selectFcOrderbyFcId(orderListVo);
			
			if(list.size()>0 && list != null) {
			session.setAttribute("orderList", list);
		    }
			
			session.setAttribute("deliveryTime", service.selectDeliveryTimebyFcId((String)session.getAttribute("fcId")));
			
		}
		mv.setViewName("franchise/home");
		return mv;
	}
	
	
	
	
}
// class