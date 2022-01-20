package com.project.federico;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import service.ClientServiceImpl;
import service.MenuServiceImpl;
import vo.CartVO;
import vo.ClientVO;
import vo.MenuVO;

@RequestMapping(value = "/client")
@Log4j
@Controller
public class ClientController {

	@Autowired
	MenuServiceImpl menuService;
	@Autowired
	ClientServiceImpl clientService;
	@Autowired
	PasswordEncoder passwordEncoder;

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
			list = (List<CartVO>) session.getAttribute("list");
		} else {
			list = new ArrayList<CartVO>();
		}

		menuVo = menuService.selectMenuOne(menuVo);
		if (menuVo != null) {
			cartVo.setMenuVo(menuVo);
			log.info("cart menu=>" + cartVo.getMenuVo().getMenuName());
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
	public ModelAndView menuList(ModelAndView mv, MenuVO vo) {
		log.info("컨트롤러");

		List<MenuVO> list = menuService.selectMenuListbyFlag(vo);
		if (list != null) {
			mv.addObject("list", list);
			mv.addObject("flag", vo.getMenuFlag());
		} else {
			mv.addObject("message", "출력자료 없음.");
		}
		log.info("리스트" + list);
		mv.setViewName("client/menu");
		return mv;
	}

	@RequestMapping(value = { "/", "/home" })
	public String clientHome(ModelAndView mv) {
		return "client/pizzaMain";
	}

	@RequestMapping(value = "clientLoginf")
	public String clientLoginf(ModelAndView mv) {
		return "client/clientLoginForm";
	}

// 로그인(강광훈)
	@RequestMapping(value = "/clientLogin")
	public ModelAndView clientLogin(HttpServletRequest request, HttpServletResponse response, ModelAndView mv,
			ClientVO vo) throws ServletException, IOException {

		// 정보 저장
		String password = vo.getClientPassword();
		String uri = "/client/clientLoginForm";

		System.out.println(vo.getClientPassword());
		System.out.println(vo.getClientId());

		vo = clientService.selectOne(vo);
		
		// 정보 확인
		if (vo != null) { // ID는 일치 -> Password 확인
			if (passwordEncoder.matches(password, vo.getClientPassword())) {
				// 로그인 성공 -> 로그인 정보 session에 보관, home
				request.getSession().setAttribute("clientLoginID", vo.getClientId());
				request.getSession().setAttribute("clientLoginName", vo.getClientName());
				uri = "redirect:home";
			} else {
				mv.addObject("message", "Password가 일치하지않습니다.");
			}
		} else {
			mv.addObject("message", "회원정보가 없습니다. ID를 확인해주세요.");
		} // if

		mv.setViewName(uri);

		return mv;
	}// login

	// 로그아웃 (강광훈)
	@RequestMapping(value = "/clientLogout")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response, ModelAndView mv,
			RedirectAttributes rttr) throws ServletException, IOException {

		// 1) request 처리
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession(false);

		// ** session 인스턴스 정의 후 삭제하기
		// => 매개변수: 없거나, true, false
		// => false : session 이 없을때 null 을 return;

		if (session != null)
			session.invalidate();
		String uri = "redirect:home";
		rttr.addFlashAttribute("message", "로그아웃 완료");

		// mv.addObject("message","~~~") -> forward
		// uri = "home" -> forward

		mv.setViewName(uri);

		return mv;
	}//logout
   
   
   
	
}//clientController
