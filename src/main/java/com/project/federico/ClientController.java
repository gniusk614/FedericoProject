package com.project.federico;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.mapping.ParameterMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.ParameterMapper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.log4j.Log4j;
import service.MenuServiceImpl;
import vo.CartVO;
import vo.MenuVO;

@RequestMapping(value = "/client")
@Log4j
@Controller
public class ClientController {

	@Autowired
	MenuServiceImpl menuService;
	
	
	
	
	//임시 로그인(장바구니 개발용) -> 추후삭제 -> nav에도 삭제해야댐
	@RequestMapping(value = "/imsiLogin")
	public ModelAndView login(ModelAndView mv, HttpSession session) {
		
		session.setAttribute("loginID", "imsiid");
		session.setAttribute("client", "Y");
		
		
		mv.setViewName("client/pizzaMain");
		return mv;
	}
	
	
	// 비회원 장바구니페이지 항목 삭제
	@RequestMapping(value = "/deleteCartNM")
	public ModelAndView deleteCartNoneMember(ModelAndView mv, HttpSession session, @RequestParam("index") int index) {
		
		List<CartVO> list = (List<CartVO>)session.getAttribute("list");
		list.remove(index);
		session.setAttribute("list", list);
		session.setAttribute("listSize", list.size());
			
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 비회원 장바구니페이지에서 수량변경 저장
	@RequestMapping(value = "/updateCartNM")
	public ModelAndView updateCartNM(ModelAndView mv, HttpSession session, CartVO vo, @RequestParam("index") int index) {
		if(session != null) {
			List<CartVO> list = (List<CartVO>) session.getAttribute("list");
			list.get(index).setMenuQty(vo.getMenuQty());
			session.setAttribute("list", list);
			session.setAttribute("listSize", list.size());
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 비회원 장바구니 항목 추가
	@RequestMapping(value = "/addCartNM")
	public ModelAndView addCartNoneMember(ModelAndView mv, HttpSession session, MenuVO menuVo, CartVO cartVo) {
		
		List<CartVO> list = null;
		if (session.getAttribute("list") != null) {
			list=(List<CartVO>) session.getAttribute("list");
		} else {
			list = new ArrayList<CartVO>();
		}
				
		menuVo = menuService.selectMenuOne(menuVo);
		if(menuVo != null) {
			cartVo.setMenuVo(menuVo);
			list.add(cartVo);  
			session.setAttribute("list", list);
			session.setAttribute("listSize", list.size());
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}	
	

	// 회원 장바구니에서 항목 삭제
	@RequestMapping(value = "/deleteCartM")
	public ModelAndView deleteCartM(ModelAndView mv, CartVO cartVo) {
		
//		if(service.deleteCart() > 0) mv.addObject("success", "success");
//		else mv.addObject("success", "fail");
		mv.addObject("success", "success");
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 회원 장바구니페이지에서 수량변경 저장
	@RequestMapping(value = "/updateCartM")
	public ModelAndView updateCartM(ModelAndView mv, HttpSession session, CartVO vo) {
		
//		if(service.updateCart(vo) > 0) mv.addObject("success", "success");
//		else mv.addObject("success", "fail");
		mv.addObject("success", "success");
		
		mv.setViewName("jsonView");
		return mv;
	}	
	
	
	// 회원 장바구니 항목 추가
	@RequestMapping(value = "/addCartM")
	public ModelAndView addCartMember(ModelAndView mv, HttpSession session, CartVO vo, MenuVO menuVo) {
		vo.setMenuVo(menuVo);
		
//		if(service.insertCart(vo) > 0) mv.addObject("success","success"); 
//		else mv.addObject("success","fail"); 
		mv.addObject("success","success"); 
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 장바구니페이지로 이동(조회)
	@RequestMapping(value = "/cart")
	public ModelAndView cart(ModelAndView mv, HttpSession session, CartVO vo, MenuVO menuVo, @RequestParam("m") String m) {
		//회원일 경우 db에서 조회해서 session에 담아줌.
		if (! "n".equals(m)) {
			List<CartVO> list = null;
//			list = service.selectCartbyClient(vo);
//			if(list.size() > 1) session.setAttribute("list", list);
		}
		mv.setViewName("client/cart");
		return mv;
	}	

	
	// flag에 따라 메뉴리스트 출력 
   @RequestMapping(value = "/menuList")
   public ModelAndView menuList(ModelAndView mv,MenuVO vo) {
      List<MenuVO> list = menuService.selectMenuListbyFlag(vo);
      if(list != null) {
         mv.addObject("list",list);
         mv.addObject("flag", vo.getMenuFlag());
      } 
      mv.setViewName("client/menu");
      return mv;
   }
	
   
   @RequestMapping(value = {"/", "/home"})
   public String clientHome() {
	   
      return "client/pizzaMain";
   }
   
	
	
}
