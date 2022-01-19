package com.project.federico;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
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
	
	
	
	
	// 비회원 장바구니페이지로 이동(조회)
	@RequestMapping(value = "/cart")
	public ModelAndView cart(ModelAndView mv) {
		
		
		mv.setViewName("client/cart");
		return mv;
	}
	
	
	// 비회원 장바구니 담기
	@RequestMapping(value = "/addCartNoneMember")
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
			log.info("cart menu=>"+cartVo.getMenuVo().getMenuName());
			list.add(cartVo);  
			session.setAttribute("list", list);
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// flag에 따라 메뉴리스트 출력 
   @RequestMapping(value = "/menuList")
   public ModelAndView menuList(ModelAndView mv,MenuVO vo) {
      log.info("컨트롤러");
	   
      List<MenuVO> list = menuService.selectMenuListbyFlag(vo);
      if(list != null) {
         mv.addObject("list",list);
         mv.addObject("flag", vo.getMenuFlag());
      } else {
         mv.addObject("message","출력자료 없음.");
      }
      log.info("리스트"+list);
      mv.setViewName("client/menu");
      return mv;
   }
	
   
   @RequestMapping(value = {"/", "/home"})
   public String clientHome(ModelAndView mv,MenuVO vo) {
	   
      return "client/pizzaMain";
   }
   
	
	
}
