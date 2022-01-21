package com.project.federico;

import java.io.IOException;
import java.net.URL;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import service.ClientServiceImpl;
import service.FranchiseService;
import service.MenuServiceImpl;
import vo.CartVO;
import vo.ClientVO;
import vo.FranchiseVO;
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
	FranchiseService fcService;
	@Autowired
	PasswordEncoder passwordEncoder;

	
	
	
	
	
	
	
	// 카카오페이 결제요청
	/*
	 * @RequestMapping(value = "/kakaoPay") public String kakaoPay() { URL url = new
	 * URL("https://kapi.kakao.com");
	 * 
	 * return ""; }
	 */
	
	
	
	// 주문페이지 : 가맹점 선택
	@RequestMapping(value = "/selectarea")
	public ModelAndView selectarea(ModelAndView mv, @RequestParam("area") String area) {
		
		List<FranchiseVO> list = fcService.selectListbyArea(area);
		if (list != null && list.size() > 0) {
			log.info(list.get(0));
			mv.addObject("list", list);
			mv.addObject("success","success");
		} else {
			mv.addObject("success","fail");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 회원 주문화면으로 이동
	@RequestMapping(value = "/orderInfo")
	public ModelAndView orderInfo(ModelAndView mv, HttpSession session, ClientVO vo) {
		String uri = "client/orderInfo";
		
		// 회원일경우 이름,주소,전화번호 갖고가기, 비회원이면 로그인페이지로
		if (session.getAttribute("clientLoginID") != null) {
			vo.setClientId(session.getAttribute("clientLoginID").toString());
			String clientPhone = clientService.selectOne(vo).getClientPhone();
			clientPhone = clientPhone.substring(0, 3) + "-" + clientPhone.substring(3, 7) + "-" + clientPhone.substring(7);
			mv.addObject("clientAddress", clientService.selectOne(vo).getClientAddress());
			mv.addObject("clientPhone", clientPhone);
			mv.addObject("clientName", clientService.selectOne(vo).getClientName());
		} else {
			uri="client/clientLoginForm";
		}
		
		mv.setViewName(uri);
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
	public ModelAndView deleteCartM(ModelAndView mv, CartVO vo, HttpSession session) {
		
		if(clientService.deleteCart(vo) > 0) {
			mv.addObject("success", "success");
			session.setAttribute("listSize", Integer.parseInt(session.getAttribute("listSize").toString())-1);
		}
		else mv.addObject("success", "fail");
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 회원 장바구니페이지에서 수량변경 저장
	@RequestMapping(value = "/updateCartM")
	public ModelAndView updateCartM(ModelAndView mv, HttpSession session, CartVO vo) {
		
		if(clientService.updateCart(vo) > 0) mv.addObject("success", "success");
		else mv.addObject("success", "fail");
		mv.addObject("success", "success");
		
		mv.setViewName("jsonView");
		return mv;
	}	
	
	
	// 회원 장바구니 항목 추가
	@RequestMapping(value = "/addCartM")
	public ModelAndView addCartMember(ModelAndView mv, HttpSession session, CartVO vo, MenuVO menuVo) {
		vo.setMenuVo(menuVo);
		
		if(clientService.insertCart(vo) > 0) {
			mv.addObject("success","success");
			if (session.getAttribute("listSize") == null) {
			session.setAttribute("listSize", 1);
			} else {
				session.setAttribute("listSize", Integer.parseInt(session.getAttribute("listSize").toString())+1);
			}
		}
		else mv.addObject("success","fail"); 
		mv.addObject("success","success"); 
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 장바구니페이지로 이동(조회)
	@RequestMapping(value = "/cart")
	public ModelAndView cart(ModelAndView mv, HttpSession session, CartVO vo, MenuVO menuVo, @RequestParam("m") String m) {
		//회원일 경우 db에서 조회해서 session에 담아줌.
		if (! "n".equals(m)) {
			vo.setClientId((String)session.getAttribute("clientLoginID"));
			List<CartVO> list = clientService.selectCartbyClient(vo);
			if(list.size() > 0) {
				session.setAttribute("list", list);
				session.setAttribute("listSize", list.size());

			}
			else session.setAttribute("list", null);
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
	
	@RequestMapping(value = { "/", "/home" })
	public String clientHome() {
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
