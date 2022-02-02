package com.project.federico;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import paging.PageMaker;
import paging.SearchCriteria;
import service.ClientServiceImpl;
import service.FranchiseService;
import service.MenuServiceImpl;
import service.OrderService;
import service.SendService;
import vo.CartVO;
import vo.ClientVO;
import vo.FranchiseVO;
import vo.MenuVO;
import vo.NoticeBoardVO;
import vo.OrderDetailListVO;
import vo.OrderListVO;
import vo.StaffVO;

@RequestMapping(value = "/client")
@Log4j
@Controller
public class ClientController {

	@Autowired
	SendService sendService;
	@Autowired
	MenuServiceImpl menuService;
	@Autowired
	ClientServiceImpl clientService;
	@Autowired
	OrderService orderService;
	@Autowired
	FranchiseService fcService;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	

	
	// 결제완료폼 이동 + 주문정보 인서트
	@RequestMapping(value = "/ordercomplete")
	public ModelAndView ordercomplete(ModelAndView mv, HttpServletRequest request, HttpSession session, ClientVO clientVo) {
		List<CartVO> list = (List<CartVO>)session.getAttribute("list");
		Map<String, Object> params = new HashMap<String, Object>();
		String fcId;
		String memo;
		
		
		// iampay 일 경우
		if("iam".equals(request.getParameter("iam"))){
			fcId = request.getParameter("fcId");
			memo = request.getParameter("memo");
		}else {
			fcId = (String)session.getAttribute("fcId");
			memo = (String)session.getAttribute("memo");
		}
		
		
		// map에 인서트할 값 세팅
		if(session.getAttribute("clientLoginID") != null) {
			clientVo.setClientId((String)session.getAttribute("clientLoginID"));
			clientVo = clientService.selectOne(clientVo);
			params.put("clientId", clientVo.getClientId());
			params.put("fcId", fcId);
			params.put("memo", memo);
			params.put("clientName", clientVo.getClientName());
			params.put("clientAddress", clientVo.getClientAddress());
			params.put("clientPhone", clientVo.getClientPhone());
			params.put("memberYN", "Y");
			params.put("orderNumber", null);
		} else {
			params.put("clientId", "NONE");
			params.put("fcId", fcId);
			params.put("memo", memo);
			params.put("clientName", (String)session.getAttribute("nonName"));
			params.put("clientAddress", (String)session.getAttribute("nonAddress"));
			params.put("clientPhone", (String)session.getAttribute("nonPhone"));
			params.put("memberYN", "N");
			params.put("orderNumber", null);
		}
		
		// 주문정보 인서트
		if (orderService.insertOrderList(params) > 0) {
			params.put("orderNumber", (int)params.get("orderNumber"));
			params.put("list", list);
			
			//해당가맹점 배달소요시간 조회
			String deliveryTime = fcService.selectDeliveryTimebyFcId(fcId);
			mv.addObject("deliveryTime", deliveryTime);
			
			
			// 주문상세정보 인서트
			if(orderService.insertOrderDetailList(params) > 0) {
				
				//결제완료 문자전송 추가
				String phone = "";
				if(session.getAttribute("clientLoginID") != null) {
					phone = clientVo.getClientPhone();
				}else {
					phone = (String)session.getAttribute("nonPhone");
				}
				sendService.orderCompeleteSmsSend(phone, deliveryTime, fcId);
				
				
				// 장바구니 비우기
				if ("Y".equals(params.get("memberYN"))) {
					clientService.deleteCartbyClientId(clientVo.getClientId());
				} 
				if(session.getAttribute("list") != null) {
					session.removeAttribute("list");
				}
				session.removeAttribute("listSize");
				session.removeAttribute("fcId");
			}
			
		}
		mv.setViewName("client/orderComplete");
		return mv;
	}
	
	
	// 카카오페이 결제요청
	  @RequestMapping(value = "/kakaoPay") 
	  @ResponseBody
	  public String kakaoPay(HttpServletRequest request) { 
		  if(request.getSession(false) != null) {
			  request.getSession(false).setAttribute("fcId", request.getParameter("fcId"));
			  request.getSession(false).setAttribute("memo", request.getParameter("memo"));
		  }
		  try {
			URL url = new URL("https://kapi.kakao.com/v1/payment/ready");
			HttpURLConnection connection = (HttpURLConnection)url.openConnection();
			connection.setRequestMethod("POST");
			connection.addRequestProperty("Authorization", "KakaoAK 6de9f6b2f650d7fdeeb0c99a8f9cb163");
			connection.addRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			connection.setDoOutput(true);
			String parameter = "cid=TC0ONETIME"
					+ "&partner_order_id="+request.getParameter("partner_order_id")
					+ "&partner_user_id="+request.getParameter("partner_user_id")
					+ "&item_name="+request.getParameter("item_name")
					+ "&quantity="+request.getParameter("quantity")
					+ "&total_amount="+request.getParameter("total_amount")
					+ "&tax_free_amount=0"
					+ "&approval_url=http://localhost:8080/federico/client/ordercomplete"
					+ "&cancel_url=http://localhost:8080/federico/client/home"
					+ "&fail_url=http://localhost:8080/federico/client/home";
			OutputStream Output = connection.getOutputStream();
			DataOutputStream dataOutput = new DataOutputStream(Output);
			dataOutput.writeBytes(parameter);
			dataOutput.close();
			
			int resultCode = connection.getResponseCode();
			InputStream input;
			if(resultCode == 200) {
				input = connection.getInputStream();
			} else {
				input = connection.getErrorStream();
			}
			InputStreamReader reader = new InputStreamReader(input, "UTF-8");
			BufferedReader bReader = new BufferedReader(reader);
			return bReader.readLine();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		  
		  return "{\"result\":\"NO\"}";
	  }
	  
	
	// 주문페이지 : 가맹점 선택
	@RequestMapping(value = "/selectarea")
	public ModelAndView selectarea(ModelAndView mv, @RequestParam("area") String area) {
		
		List<FranchiseVO> list = fcService.selectListbyArea(area);
		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.addObject("success","success");
		} else {
			mv.addObject("success","fail");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 주문페이지 이동 - 회원이거나 인증비회원일경우 이름,주소,전화번호 갖고가기, 비회원이면 로그인페이지로
	@RequestMapping(value = "/orderInfo")
	public ModelAndView orderInfo(ModelAndView mv, HttpServletRequest request, HttpSession session, ClientVO vo) {
		String uri = "client/orderInfo";
		
		if (session.getAttribute("clientLoginID") != null) {
			vo.setClientId(session.getAttribute("clientLoginID").toString());
			mv.addObject("clientAddress", clientService.selectOne(vo).getClientAddress());
			mv.addObject("clientPhone", clientService.selectOne(vo).getClientPhone());
			mv.addObject("clientName", clientService.selectOne(vo).getClientName());
		} else if(session.getAttribute("nonAddress") != null) {
			mv.addObject("clientAddress", (String)session.getAttribute("nonAddress"));
			mv.addObject("clientPhone", (String)session.getAttribute("nonPhone"));
			mv.addObject("clientName", (String)session.getAttribute("nonName"));
		} else if(session.getAttribute("nonName") != null) {
			uri = "client/nonOrderAddress";
		} else {
			uri="client/clientLoginForm";
		}
		
		mv.setViewName(uri);
		return mv;
	}	
	
	
	
	// 비회원 장바구니페이지 항목 삭제
	@RequestMapping(value = "/deleteCartNM")
	public ModelAndView deleteCartNoneMember(ModelAndView mv, HttpSession session, @RequestParam("index") int index) {

		List<CartVO> list = (List<CartVO>) session.getAttribute("list");
		list.remove(index);
		session.setAttribute("list", list);
		session.setAttribute("listSize", list.size());

		mv.setViewName("jsonView");
		return mv;
	}

	// 비회원 장바구니페이지에서 수량변경 저장
	@RequestMapping(value = "/updateCartNM")
	public ModelAndView updateCartNM(ModelAndView mv, HttpSession session, CartVO vo,
			@RequestParam("index") int index) {
		if (session != null) {
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
			list = (List<CartVO>) session.getAttribute("list");
		} else {
			list = new ArrayList<CartVO>();
		}
		
		menuVo = menuService.selectMenuOne(menuVo);
		if (menuVo != null) {
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

		if (clientService.deleteCart(vo) > 0) {
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

		if (clientService.updateCart(vo) > 0) {
			List<CartVO> list = clientService.selectCartbyClient(vo);
			session.setAttribute("list", list);
			mv.addObject("success", "success");
		}
		else {
			mv.addObject("success", "fail");
		}
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
	public ModelAndView cart(ModelAndView mv, HttpSession session, CartVO vo, MenuVO menuVo,
			@RequestParam("m") String m) {
		// 회원일 경우 db에서 조회해서 session에 담아줌.
		if (! "n".equals(m)) {
			vo.setClientId((String) session.getAttribute("clientLoginID"));
			List<CartVO> list = clientService.selectCartbyClient(vo);
			if (list.size() > 0) {
				session.setAttribute("list", list);
				session.setAttribute("listSize", list.size());

			} else
				session.setAttribute("list", null);
		}
		mv.setViewName("client/cart");
		return mv;
	}

	// flag에 따라 메뉴리스트 출력
	@RequestMapping(value = "/menuList")
	public ModelAndView menuList(ModelAndView mv, MenuVO vo, HttpServletRequest request, HttpSession session) {
		List<MenuVO> list = menuService.selectMenuListbyFlag(vo);
		if (list != null) {
			mv.addObject("list", list);   
			mv.addObject("flag", vo.getMenuFlag());
			session.setAttribute("listsize", list.size());
		}
		
		mv.setViewName("client/menu");
		return mv;
	}

	@RequestMapping(value = { "/", "/home" })
	public ModelAndView clientHome(ModelAndView mv, HttpSession session) {
		if(session.getAttribute("list") != null) {
			List<CartVO> list = (List<CartVO>)session.getAttribute("list");
			if(list.size() > 0) {
				mv.addObject("listSize", list.size());
			}
		}
		
		mv.setViewName("client/pizzaMain");
		return mv;
	}

	@RequestMapping(value = "clientLoginf")
	public String clientLoginf(ModelAndView mv) {
		return "client/clientLoginForm";
	}

// 로그인(강광훈)
	@RequestMapping(value = "/clientLogin")
	public ModelAndView clientLogin(HttpServletRequest request, HttpServletResponse response, ModelAndView mv,
			ClientVO vo, CartVO cartVo) throws ServletException, IOException {
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
		
		// 로그인 시 장바구니에 물건 있으면 nav에 숫자표시
		List<CartVO> list = clientService.selectCartbyClient(cartVo);
		if(list != null) {
			request.getSession(false).setAttribute("listSize", list.size());
		}
		
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
	}// logout

	// 문자전송 컨트롤러
	@GetMapping("/sendSms")
	public @ResponseBody ModelAndView sendSMS(ModelAndView mv, ClientVO vo) {

		
		String phoneNumber = vo.getClientPhone();
		vo = clientService.selectOnePhone(vo);
		
		if (vo != null) {
			mv.addObject("selectOne", vo);
		} else {
			Random rand = new Random();
			String numStr = "";
			for (int i = 0; i < 6; i++) {
				String ran = Integer.toString(rand.nextInt(10));
				numStr += ran;
			}
			System.out.println("수신자 번호 : " + phoneNumber);
			System.out.println("인증번호 : " + numStr);
			sendService.certifiedPhoneNumber(phoneNumber, numStr);
			mv.addObject("numStr", numStr);
		}
		mv.setViewName("jsonView");
		return mv;
	}

	
	// 비회원 주소 세션 저장
	@RequestMapping(value = "/nonaddress")
	public ModelAndView nonAddress(ModelAndView mv, HttpSession session, @RequestParam("nonAddress") String nonAddress) {
		
		session.setAttribute("nonAddress", nonAddress);
		mv.addObject("success","success");
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 비회원주문 주소입력창 이동
	@RequestMapping(value = "nonOrderf")
	public ModelAndView nonOrderf(ModelAndView mv, HttpSession session, HttpServletRequest request) {
		String uri = "client/nonOrderAddress";
		if(session.getAttribute("nonName") == null) {
			session.setAttribute("nonName", request.getParameter("nonName"));
			session.setAttribute("nonPhone", request.getParameter("nonPhone"));
		}
		
		mv.setViewName(uri);

		return mv;
	}
	
	
	
		// 회원가입창 이동
		@RequestMapping(value = "clientJoinf")
		public ModelAndView clientJoinf(ModelAndView mv) {
			String uri = "client/clientJoinForm";
			mv.setViewName(uri);
			return mv;
		}
		// 회원가입창 디테일 이동
		@RequestMapping(value = "clientJoin2ndf")
		public ModelAndView clientJoinf2ndf(ModelAndView mv, ClientVO vo) {
			mv.addObject("clientName", vo.getClientName());
			mv.addObject("clientPhone", vo.getClientPhone());
			mv.addObject("smsCheck", vo.getSmsCheck());
			mv.addObject("emailCheck", vo.getEmailCheck());
			
			String uri = "client/clientJoinFormDetail";
			mv.setViewName(uri);
			return mv;
		}
		
		//selectOne
		@RequestMapping(value = "/clientSelectOne")
		public ModelAndView clientSelectOne(ModelAndView mv, ClientVO vo) throws ServletException, IOException {
			vo = clientService.selectOne(vo);

			if (vo != null)
				mv.addObject("cleintDetail", vo); // MyBatis 에선 null , size()>0 으로 확인
			else
				mv.addObject("message", "정보가 없습니다.");
			mv.setViewName("jsonView");
			return mv;
		}
		
		//회원가입
		@RequestMapping(value = "clientJoin")
		public ModelAndView clientJoin(ModelAndView mv, ClientVO vo , RedirectAttributes rttr, HttpSession session, CartVO cartVo) {
			vo.setClientPassword(passwordEncoder.encode(vo.getClientPassword()));
			if (clientService.insertClient(vo) > 0) {
				rttr.addAttribute("message", "계정생성이 완료되었습니다.");
				// 회원가입 시 장바구니 있으면 회원장바구니에 추가
				if(session.getAttribute("list") != null) {
					List<CartVO> list = (List<CartVO>) session.getAttribute("list");
					if(list.size() > 0) {
						for(CartVO imsi : list) {
							imsi.setClientId(vo.getClientId());
							clientService.insertCart(imsi);
						}
					}
				}
			} else {
				rttr.addAttribute("message", "계정생성이 실패하였습니다");
			}
			mv.setViewName("redirect:clientLoginf");
			return mv;
		}// join
		

		//비회원주문조회
		@RequestMapping(value = "nonOrderDetail")
		public ModelAndView nonOrderDetail(ModelAndView mv,
				@RequestParam("nonName") String nonName, @RequestParam("nonPhone") String nonPhone, 
				OrderListVO ordervo, OrderDetailListVO orderDvom , ClientVO vo) throws IOException {
			mv.setViewName("client/nonOrderDetail");
			vo.setClientPhone(nonPhone);
			vo = clientService.selectOnePhone(vo);
			
			if (vo != null) {
				mv.addObject("selectOne", "가입회원입니다. 로그인 후 이용해주세요.");
			} else {
				ordervo.setClientPhone(nonPhone);
				ordervo = orderService.selectOrderbyPhone(ordervo);
				if (ordervo == null) {
					mv.addObject("message", "주문내역이 없습니다.");
				} else {
					List<OrderDetailListVO> list = orderService.selectDetailbyOrderNumber(ordervo.getOrderNumber());
					if (list != null) {
						mv.addObject("orderInfo", ordervo);
						mv.addObject("list", list);
					} else {
						mv.addObject("message", "주문내역이 없습니다.");
					}
				}
			}
			return mv;

		}
		
		//주문취소
		@RequestMapping(value = "orderCancel")
		public ModelAndView orderCancel(ModelAndView mv, OrderListVO vo) {
			if(orderService.orderCancel(vo)>0) {
				sendService.orderCancelSmsSend(vo.getClientPhone());
				mv.addObject("success", "성공");
			}else {
				mv.addObject("success", null);
			}
			mv.setViewName("jsonView");
			return mv;
		}
		
		@RequestMapping(value ="/fcSearch")
		public ModelAndView fcsearch (ModelAndView mv, FranchiseVO vo) {					
			
			mv.setViewName("client/fcSearch");
			return mv;
		}
		
		
		//고객센터이동
		@RequestMapping(value = "cscenterf")
		public ModelAndView cscenterf(ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
			cri.setSnoEno();
			
			List<NoticeBoardVO> selectList = clientService.selectNoticeBoard();
			List<NoticeBoardVO> searchList = clientService.searchNoticeBoard(cri);
			if (searchList != null && searchList.size() > 0) {
				if(selectList !=null && selectList.size()>0) {
					mv.addObject("noticeList",selectList);
				}
				mv.addObject("boardList", searchList);
			} else {
				mv.addObject("message", "출력할 자료가 없습니다.");
			}
			pageMaker.setCri(cri);
			pageMaker.setTotalRowCount(clientService.searchNoticeBoardRows(cri));
			
			mv.setViewName("client/csCenter");
			return mv;
		}
		
		//공지사항 디테일
		@RequestMapping(value ="/csNoticeDetail")
		public ModelAndView csNoticeDetail (ModelAndView mv ,NoticeBoardVO vo) {					
			vo = clientService.selectDetailNoticeBoard(vo);
			if(vo!=null) {
				clientService.countUpNoticeBoard(vo);
				mv.addObject("noticeDetail", vo);
			}else {
				mv.addObject("message", "출력할 글이 없습니다.");
			}
			mv.setViewName("client/csNoticeDetail");
			return mv;
		}
		
		
		
		
		
}// clientController
