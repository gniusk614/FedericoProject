package com.project.federico;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import service.ClientService;
import vo.CartVO;
import vo.ClientVO;


public class ClientLoginIntercepter extends HandlerInterceptorAdapter {

	@Autowired
	ClientService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		// ** Login 여부에 따른 인증 구현
		// 1) session 객체 가져오기
		HttpSession session = request.getSession(false);

		
		// 2) 로그인 확인하기
		// => 결과에 따라 true 또는 false 를 return
		if (session!=null && session.getAttribute("clientLoginID")!=null) {
			// Login 되어있음 -> Controller 진행
			return true;
		}else {
			// Login 되어있지 않음
			// => Login 유도 (loginForm 요청) 후 return false
//			request.setAttribute("message", "로그인 후 이용하세요");
			
			Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
			if(loginCookie != null) {
				String sessionId = loginCookie.getValue();
				ClientVO vo = service.checkUserWithSessionKey(sessionId);
				CartVO cartVo = new CartVO();
				cartVo.setClientId(vo.getClientId());
				if(vo != null) {
					session.setAttribute("clientLoginID",vo.getClientId());
					String url = "/WEB-INF/views/client/pizzaMain.jsp";
					
					// 로그인 시 장바구니에 물건 있으면 nav에 숫자표시
					List<CartVO> list = service.selectCartbyClient(cartVo);
					if(list != null) {
						request.getSession(false).setAttribute("listSize", list.size());
					}
					request.getRequestDispatcher(url).forward(request, response);
					return true;
				}
			}
			
			// 2.2) forward : loginForm 출력
			String url = "/WEB-INF/views/client/clientLoginForm.jsp";
			request.getRequestDispatcher(url).forward(request, response);			
			return false;
		}

	}// preHandle

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}// postHandle

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// => jsp에 출력안됨
	}// afterCompletion

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
	}// afterConcurrentHandlingStarted

}// class
