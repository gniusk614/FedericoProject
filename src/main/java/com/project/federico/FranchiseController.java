package com.project.federico;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;
import paging.PageMaker;
import paging.SearchCriteria;
import service.FranchiseService;
import service.OrderService;
import vo.FranchiseVO;
import vo.HeadOfficeVO;
import vo.ItemInfoVO;
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
	
	// 주문 완료처리
	@RequestMapping(value = "/ordercomplete")
	public ModelAndView orderComplete(ModelAndView mv, OrderListVO vo) {
		log.info("dfsfsfsdf"+vo.getOrderNumber());
		if (orderService.orderComplete(vo) > 0) {
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 완료주문 조회
	@RequestMapping(value = "/completeOrder")
	public ModelAndView completeOrder(ModelAndView mv, HttpSession session, SearchCriteria cri, PageMaker pageMaker, FranchiseVO fcVo) {
		if (session.getAttribute("fcId") != null) {
			Map<String, Object> parmas = new HashMap<String, Object>();
			cri.setSnoEno();
			fcVo.setFcId((String)session.getAttribute("fcId"));
			parmas.put("vo", fcVo);
			parmas.put("cri", cri);
			List<OrderListVO> list = orderService.searchCompleteOrder(parmas);
			
			if (list != null && list.size() > 0) {
				mv.addObject("completeList", list);
			} else {
				mv.addObject("message", "조회된 자료가 없습니다.");
			}
			
			pageMaker.setCri(cri);
			pageMaker.setTotalRowCount(orderService.searchCompleteOrderRows(parmas));
			
			mv.setViewName("franchise/searchOrderCompleteY");
		} else {
			mv.setViewName("franchise/loginf");
		}
		return mv;
	}


	
	
	
	
	
	
	
	
	
	
	
	
	
	// 로그인폼이동 (김민석)
		@RequestMapping(value = "/loginf") // client/footer -> 가맹점 전용 페이지 
		public ModelAndView loginf(ModelAndView mv) {
			mv.setViewName("franchise/fcLoginForm");
			return mv;
		}// loginf-> 폼으로 이동시켜줌
		
		@RequestMapping(value ="/login")
		public ModelAndView login(HttpServletRequest request,HttpServletResponse response,ModelAndView mv,			
				HeadOfficeVO hvo, FranchiseVO vo, HttpSession session, OrderListVO orderListVo) {

			// 각정보 저장
			// login 성공시 이동화면
			 // 가맹점게시판 현재 : null
			// login 비밀번호 저장
			String fcId=vo.getFcId();
			String password =vo.getFcPassword();
			String uri="/franchise/fcLoginForm";

			
			// 프랜차이즈 정보 vo에 담기
			vo=service.selectFcOne(vo);
			
			if(vo!=null) { // vo가 null이 아니면 = login이 성공하면 session에 보관			
				if (passwordEncoder.matches(password, vo.getFcPassword())) {
//				if(vo.getFcPassword().equals(password)) {
					
					mv.addObject("success","T");
					request.getSession().setAttribute("fcId",fcId);
					request.getSession().setAttribute("fcloginName",vo.getFcName());
					
					
					// 해당가맹점 주문정보 조회
					if (fcId != null) {
						List<OrderListVO> list = new ArrayList<OrderListVO>();
						orderListVo.setCompleteYN("N"); //DB에서 default 처리해주기

						orderListVo.setFcId(fcId);
						
						list = orderService.selectFcOrderbyFcId(orderListVo);
					    
						session.setAttribute("orderList", list);
						// 배달시간 불러오기
						session.setAttribute("deliveryTime", service.selectDeliveryTimebyFcId(fcId));
						uri="franchise/home";
						
					}
					
				}else {
					//mv.addObject("success","Password Fail");
					mv.addObject("message","Password가 일치하지 않습니다.");
				}
				
			}else {// id오류
				//mv.addObject("success","ID Fail");
				mv.addObject("message","회원정보가 없습니다. ID를 확인해주세요.");
			}
			
			mv.setViewName(uri);
					
			return mv;
			}
		
		
		
}// class
