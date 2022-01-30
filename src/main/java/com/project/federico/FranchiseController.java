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
import net.sf.json.JSONArray;
import paging.PageMaker;
import paging.SearchCriteria;
import service.FranchiseService;
import service.HeadOfficeServiceImpl;
import service.OrderService;
import vo.CartVO;
import vo.ChartVO;
import vo.FcClientRegVO;
import vo.FcOrderDetailVO;
import vo.FcOrderVO;
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
	@Autowired
	HeadOfficeServiceImpl headOfficeService;

	
	
	// 가맹점 고객관리 삭제
	@RequestMapping(value = "/fcclientregdelete")
	public ModelAndView fcClientRegSDelete (ModelAndView mv, FcClientRegVO vo) {
		
		if(service.deleteFcClientReg(vo) > 0) {
			mv.addObject("success","success");
		} else {
			mv.addObject("success","fail");
		}
		mv.setViewName("jsonView");
		return mv;
	}	
	
	// 가맹점 고객관리 수정
	@RequestMapping(value = "/fcclientregupdate")
	public ModelAndView fcClientRegUpdate (ModelAndView mv, FcClientRegVO vo) {
		
		if(service.updateFcClientReg(vo) > 0) {
			mv.addObject("success","success");
		} else {
			mv.addObject("success","fail");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 가맹점 고객관리 등록 by 전화번호, 주소
	@RequestMapping(value = "/fcclientreg")
	public ModelAndView fcClientReg (ModelAndView mv, FcClientRegVO vo) {
		
		if(service.insertFcClient(vo) > 0) {
			mv.addObject("success","success");
			mv.addObject("vo",vo);
		} else {
			mv.addObject("success","fail");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 홈화면 우하단 차트용 통계자료
	@RequestMapping(value = "/fcchartsevenday")
	public ModelAndView fcChartSevenDay(ModelAndView mv, HttpSession session) {
		if(session.getAttribute("fcId") != null) {
			String fcId = (String)session.getAttribute("fcId");
			List<ChartVO> chartList = service.fcLastSevenDaysSalesPerDay(fcId);
			mv.addObject("charData", chartList);
			for (ChartVO cvo: chartList){
				log.info(cvo.getChartCount());
				log.info(cvo.getChartLabel());
			};
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 가맹점 발주내역 상세보기(발주번호 별로) return json
	@RequestMapping(value = "/fcorderdetail")
	public ModelAndView fcorderdetail(ModelAndView mv, FcOrderDetailVO vo, ItemInfoVO ivo) {
		vo.setItemInfoVO(ivo);
		List<FcOrderDetailVO> list = headOfficeService.selectFcOrderDetailbyOrderNumber(vo);
		if (list.size() > 0) {
			mv.addObject("list", list);
		} else {
			mv.addObject("message", "조회할 자료가 없습니다.");
		}

		mv.setViewName("jsonView");
		return mv;
	}
	
	//가맹점 자재발주 검색 및 조회
	@RequestMapping(value = "/selectfcorder")
	public ModelAndView selectFcOrder(ModelAndView mv, HttpServletRequest request, HttpSession session , PageMaker pageMaker, SearchCriteria cri, FcOrderVO vo) {
		if(session.getAttribute("fcId") != null) {	
			vo.setFcId((String)session.getAttribute("fcId"));
			Map<String, Object> params = new HashMap<String, Object>();
			
			if (request.getParameter("minDate") != null) {
				params.put("minDate", request.getParameter("minDate").replaceAll("/", ""));
				params.put("maxDate", request.getParameter("maxDate").replaceAll("/", ""));
			}
			
			cri.setSnoEno();
	
			params.put("cri", cri);
			params.put("vo", vo);
			List<FcOrderVO> list = service.searchItemOrderListFc(params);
	
			if (list != null && list.size() > 0) {
				mv.addObject("fcOrderList", list);
			} 
			pageMaker.setCri(cri);
			pageMaker.setTotalRowCount(service.searchItemOrderListRows(params));
			
			mv.addObject("flaG", vo.getFcOrderFlag());
			mv.setViewName("franchise/itemOrderList");
		} else {
			mv.setViewName("franchise/fcLoginForm");
		}
		return mv;
	}
	
	
	
	//가맹점 자재발주등록
	@RequestMapping(value = "/insertfcorder")
	public ModelAndView insertfcorder(ModelAndView mv, HttpServletRequest request, FcOrderVO orderVo,
			@RequestParam("sendData") String sendData) {
		
		
		if(headOfficeService.insertFcOrder(orderVo) > 0) {
			List<FcOrderDetailVO> list = new ArrayList<FcOrderDetailVO>();
			
			JSONArray jsonArray = JSONArray.fromObject(sendData);
			for(int i=0; i<jsonArray.size(); i++) {
				net.sf.json.JSONObject obj = jsonArray.getJSONObject(i); 
				FcOrderDetailVO detailVo = new FcOrderDetailVO();
				detailVo.setItemIndex(Integer.parseInt(obj.get("itemIndex").toString()));
				detailVo.setItemQty(Integer.parseInt(obj.get("itemQty").toString()));
				detailVo.setFcOrderSeq(orderVo.getFcOrderSeq());
				list.add(detailVo);
			}
			if(headOfficeService.insertFcOrderDetail(list)> 0) {
				mv.addObject("success", "success");
			}
			mv.addObject("success", "fail");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}	
	
	
	// 가맹점 자재발주 item고르면 정보조회
	@RequestMapping(value = "/getiteminfo")
	public ModelAndView getItemInfo(ModelAndView mv, ItemInfoVO vo) {
		vo = headOfficeService.selectOneItem(vo);
		if(vo != null) {
			mv.addObject("vo", vo);
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 가맹점 자재발주 동적 select option
	@RequestMapping(value = "/getitemlist")
	public ModelAndView getItemList(ModelAndView mv, ItemInfoVO vo) {
		List<ItemInfoVO> list = new ArrayList<ItemInfoVO>();
		list = headOfficeService.selectItembyFlag(vo);
		if(list != null && list.size() > 0) {
			mv.addObject("itemList", list);
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 가맹점 자재발주 페이지 이동
	@RequestMapping(value = "/itemorderf")
	public ModelAndView itemOrderf(ModelAndView mv) {
		
		mv.setViewName("franchise/itemOrder");
		return mv;
	}
	
	
	
	// 주문내역 상세조회 by orderNumber
	@RequestMapping(value = "/selectDetail")
	public ModelAndView selectDetail(ModelAndView mv, OrderDetailListVO detailVo, @RequestParam("orderNumber") int orderNumber, FcClientRegVO fcClientVo) {
		List<OrderDetailListVO> detailList = new ArrayList<OrderDetailListVO>();
		detailList = orderService.selectDetailbyOrderNumber(orderNumber);
		if(detailList.size() > 0 && detailList != null) {
			//단골고객 관련
			fcClientVo = service.selectFcClientOne(fcClientVo);
			if(fcClientVo != null) {
				mv.addObject("fcClient","T");
				mv.addObject("fcClientVo",fcClientVo);
			} else {
				mv.addObject("fcClient","F");
			}
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
	@RequestMapping(value = "/completeorder")
	public ModelAndView completeOrder(ModelAndView mv, HttpServletRequest request, HttpSession session, SearchCriteria cri, PageMaker pageMaker, FranchiseVO fcVo) {
		if (session.getAttribute("fcId") != null) {
			Map<String, Object> params = new HashMap<String, Object>();
			
			if (request.getParameter("minDate") != null) {
				params.put("minDate", request.getParameter("minDate").replaceAll("/", ""));
				params.put("maxDate", request.getParameter("maxDate").replaceAll("/", ""));
			}
			
			cri.setSnoEno();
			fcVo.setFcId((String)session.getAttribute("fcId"));
			params.put("vo", fcVo);
			params.put("cri", cri);
			List<OrderListVO> list = orderService.searchCompleteOrder(params);
			
			if (list != null && list.size() > 0) {
				mv.addObject("completeList", list);
			} else {
				mv.addObject("message", "조회된 자료가 없습니다.");
			}
			
			pageMaker.setCri(cri);
			pageMaker.setTotalRowCount(orderService.searchCompleteOrderRows(params));
			
			if(request.getParameter("minDate") != null) {
				mv.addObject("minDate", request.getParameter("minDate"));
				mv.addObject("maxDate", request.getParameter("maxDate"));
			}
			
			mv.setViewName("franchise/searchOrderCompleteY");
		} else {
			mv.setViewName("franchise/fcLoginForm");
		}
		return mv;
	}

	
	
	
		// 로그인폼이동 (김민석)
		@RequestMapping(value = "/loginf") // client/footer -> 가맹점 전용 페이지 
		public ModelAndView loginf(ModelAndView mv) {
			mv.setViewName("franchise/fcLoginForm");
			return mv;
		}// loginf-> 폼으로 이동시켜줌
		
		// 로그인 및 프랜차이즈 홈 이동
		@RequestMapping(value ="/login")
		public ModelAndView login(HttpServletRequest request,HttpServletResponse response,ModelAndView mv,			
				HeadOfficeVO hvo, FranchiseVO vo, HttpSession session, OrderListVO orderListVo, ChartVO cVo) {
			String fcId;
			
			// franchise 페이지 내에서 메인대쉬보드 클릭 (fcid 세션있어야함) OR fcid세션가지고 들어옴
			if("home".equals(request.getParameter("home")) && session.getAttribute("fcId") != null || session.getAttribute("fcId") != null) {
				fcId = (String)session.getAttribute("fcId");
				List<OrderListVO> list = new ArrayList<OrderListVO>();
				orderListVo.setCompleteYN("N"); //DB에서 default 처리해주기
				
				orderListVo.setFcId(fcId);
				
				list = orderService.selectFcOrderbyFcId(orderListVo);
				
				session.setAttribute("orderList", list);
				// 배달시간 불러오기
				session.setAttribute("deliveryTime", service.selectDeliveryTimebyFcId(fcId));
				
				// 홈화면 통계자료
				cVo = service.fcThisMonthSales(fcId);
				mv.addObject("fcThisMonthSales", cVo==null ? 0 : cVo.getChartCount());
				cVo = service.fcTodaySales(fcId);
				mv.addObject("fcTodaySales", cVo==null ? 0 : cVo.getChartCount());
				cVo = service.fcYesterdaySales(fcId);
				mv.addObject("fcYesterdaySales", cVo==null ? 0 : cVo.getChartCount());
				cVo = service.fcThisMonthOrderSum(fcId);
				mv.addObject("fcThisMonthOrderSum", cVo==null ? 0 : cVo.getChartCount());
				
				
				mv.setViewName("franchise/home");
				
			} else {
			
				
				
				// 각정보 저장
				// login 성공시 이동화면
				// 가맹점게시판 현재 : null
				// login 비밀번호 저장
				fcId=vo.getFcId();
				String password =vo.getFcPassword();
				String uri="/franchise/fcLoginForm";
				
				// 세션종료시 로그인페이지로 보내기
				if(vo.getFcId() == null) {
					mv.setViewName(uri);
					return mv;
				}
				
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
							
							// 홈화면 좌하단 통계자료
							cVo = service.fcThisMonthSales(fcId);
							mv.addObject("fcThisMonthSales", cVo==null ? 0 : cVo.getChartCount());
							cVo = service.fcTodaySales(fcId);
							mv.addObject("fcTodaySales", cVo==null ? 0 : cVo.getChartCount());
							cVo = service.fcYesterdaySales(fcId);
							mv.addObject("fcYesterdaySales", cVo==null ? 0 : cVo.getChartCount());
							cVo = service.fcThisMonthOrderSum(fcId);
							mv.addObject("fcThisMonthOrderSum", cVo==null ? 0 : cVo.getChartCount());
							

							
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
			}
			return mv;
			}
		
		@RequestMapping(value = "/home")
		public ModelAndView home(ModelAndView mv) {
			mv.setViewName("franchise/home");
			return mv;
		}// 
		
		
}// class
