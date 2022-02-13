package com.project.federico;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import paging.PageMaker;
import paging.SearchCriteria;
import service.ClientService;
import service.FranchiseService;
import service.HeadOfficeService;
import service.MenuService;
import vo.ChartVO;
import vo.ComplainBoardVO;
import vo.ComplainCommentVO;
import vo.EventBoardVO;
import vo.FcOrderDetailVO;
import vo.FcOrderVO;
import vo.FranchiseVO;
import vo.HeadOfficeVO;
import vo.ItemInfoVO;
import vo.MenuVO;
import vo.NoticeBoardVO;
import vo.StaffVO;

@RequestMapping(value = "/headoffice")
@Log4j
@Controller
public class HeadOfficeController {

	@Autowired
	FranchiseService fservice;
	@Autowired
	HeadOfficeService service;
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	MenuService menuService;
	@Autowired
	ClientService cservice;
	
	
	// 회원 연령대 조회
	@RequestMapping(value = "/statsmemberagegroup")
	public ModelAndView statsMemberAgeGroup(ModelAndView mv, HttpServletRequest request) {
		List<ChartVO> list = new ArrayList<ChartVO>();
		
		list = service.selectMemberAgeGroup();
		if(list != null && list.size() > 0) {
			mv.addObject("chartData",list);
			mv.addObject("success","success");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 연령대별 메뉴 판매량 by 지점
	@RequestMapping(value = "/statsagegroupmenusales")
	public ModelAndView statsAgeGroupMenuSales(ModelAndView mv, HttpServletRequest request) {
		List<ChartVO> list = new ArrayList<ChartVO>();
		Map<String, Object> params = new HashMap<String, Object>();
		String ageGroup = request.getParameter("ageGroup");
		String fcId = null;
		if(request.getParameter("fcId") != null) {
			fcId = request.getParameter("fcId");
		}
		params.put("ageGroup", ageGroup);
		params.put("fcId", fcId);
		
		list = service.selectStatsAgeGroupMenuSales(params);
		if(list != null && list.size() > 0) {
			mv.addObject("chartData",list);
			mv.addObject("success","success");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 연령대별 매출 by 년도 and 지점
	@RequestMapping(value = "/statsagegroupsales")
	public ModelAndView statsAgeGroupSales(ModelAndView mv, HttpServletRequest request) {
		List<ChartVO> list = new ArrayList<ChartVO>();
		Map<String, Object> params = new HashMap<String, Object>();
		String baseDay = request.getParameter("baseDay");
		String fcId = null;
		if(request.getParameter("fcId") != null) {
			fcId = request.getParameter("fcId");
		}
		params.put("baseDay", baseDay);
		params.put("fcId", fcId);
		
		list = service.selectStatsAgeGroupSales(params);
		if(list != null && list.size() > 0) {
			mv.addObject("chartData",list);
			mv.addObject("success","success");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	//메뉴별 판매량 where 월별 and 지점별, 월별 안넣으면 전체기간
	@RequestMapping(value = "/statsmenusales")
	public ModelAndView statsMenuSales(ModelAndView mv, HttpServletRequest request, HttpSession session) {
			List<ChartVO> list = new ArrayList<ChartVO>();
			Map<String, Object> params = new HashMap<String, Object>();
			String fcId = request.getParameter("fcId");
		
			String baseDay;
			if("".equals(request.getParameter("baseDay"))) {
				baseDay = null;
			} else {
				baseDay = request.getParameter("baseDay");
				baseDay = baseDay.replaceAll("/", "");
			}
			
			params.put("fcId", fcId);
			params.put("baseDay", baseDay);
			list = fservice.selectFCStatsMenuSales(params);
			if(list != null && list.size()>0) {
				mv.addObject("chartData",list);
				mv.addObject("success","success");
			} 
		mv.setViewName("jsonView");
		return mv;
	}	
	
	
	//시간대별 매출 where orderdate and fcid and 전체
		@RequestMapping(value = "/statstimesales")
		public ModelAndView statsTimeSales(ModelAndView mv, HttpServletRequest request, HttpSession session) {
				List<ChartVO> list = new ArrayList<ChartVO>();
				Map<String, Object> params = new HashMap<String, Object>();
				String fcId = request.getParameter("fcId");
			
				String selectDate;
				if("".equals(request.getParameter("selectDate"))) {
					selectDate = null;
				} else {
					selectDate = request.getParameter("selectDate");
					selectDate = selectDate.replaceAll("/", "");
				}
				
				params.put("fcId", fcId);
				params.put("selectDate", selectDate);
				list = fservice.selectFCStatsTimeSales(params);
				if(list != null && list.size()>0) {
					if(selectDate != null) {
						selectDate = selectDate.substring(0,2)+"/"+selectDate.substring(2,4)+"/"+selectDate.substring(4);
					}
					mv.addObject("chartData",list);
					mv.addObject("selectDate", selectDate);
					mv.addObject("success","success");
				} 
				
			mv.setViewName("jsonView");
			return mv;
		}	
	
	// 가맹점별 월별 매출 조회 - parameter로 전체조회도 가능
	@RequestMapping(value = "/statsmonthlysales")
	public ModelAndView statsMonthlySales(ModelAndView mv, HttpServletRequest request, HttpSession session) {
		List<ChartVO> list = new ArrayList<ChartVO>();
		Map<String, Object> params = new HashMap<String, Object>();
		String fcId = request.getParameter("fcId");
		
		//기준일구하기
		String baseDay;
		if(request.getParameter("baseDay") == null) {
			SimpleDateFormat format = new SimpleDateFormat("YYYYMMdd");
			Date today = new Date();
			baseDay = format.format(today);
		} else {
			baseDay = request.getParameter("baseDay");
		}
		
		params.put("fcId", fcId);
		params.put("baseDay", baseDay);
		list = fservice.selectFcStatsMonthlySales(params);
		if(list != null && list.size()>0) {
			mv.addObject("chartData",list);
			mv.addObject("success","success");
		} 
		
		mv.setViewName("jsonView");
		return mv;
	}	
	
	// 연간 매출(월별, 지점별)
	@RequestMapping(value = "/statsannualsales")
	public ModelAndView statsAnuualSales(ModelAndView mv, HttpServletRequest request, HttpSession session) {
		if(! "".equals(request.getParameter("baseDay"))) {
			List<ChartVO> list = new ArrayList<ChartVO>();
			Map<String, Object> params = new HashMap<String, Object>();
			String fcId = request.getParameter("fcId");
			String baseDay =  request.getParameter("baseDay");
			log.info("fcid  => "+fcId);
			
			params.put("fcId", fcId);
			params.put("baseDay", baseDay);
			list = fservice.selectFCStatsAnnualSales(params);
			if(list != null && list.size()>0) {
				mv.addObject("chartData",list);
				mv.addObject("success","success");
			}
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 지점List select ajax
	@RequestMapping(value = "/selectFcId")
	public ModelAndView selectFcId(ModelAndView mv) {
		
		List<FranchiseVO> list = fservice.selectFc();
		if(list != null && list.size()>0) {
			mv.addObject("fcList", list);
			mv.addObject("success", "success");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// chartsales 페이지 들어가기
	@RequestMapping(value = "/chartsales")
	public ModelAndView chart1(ModelAndView mv, HttpServletRequest request) {
		
		if(request.getParameter("key") == null) {
			mv.addObject("key", null);
		} else if("2".equals(request.getParameter("key"))) {
			mv.addObject("key", "2");
		} else if("3".equals(request.getParameter("key"))) {
			mv.addObject("key", "3");
		} else if("4".equals(request.getParameter("key"))) {
			mv.addObject("key", "4");
		} 	
		
		
		mv.setViewName("headoffice/chartsales");
		return mv;
	}
	
	
	// chartamember 페이지 들어가기
	@RequestMapping(value = "/chartagegroup")
	public ModelAndView chartAgeGroup(ModelAndView mv, HttpServletRequest request) {
		
		if(request.getParameter("key") == null) {
			mv.addObject("key", null);
		} else if("2".equals(request.getParameter("key"))) {
			mv.addObject("key", "2");
		} else if("3".equals(request.getParameter("key"))) {
			mv.addObject("key", "3");
		} 
		
		
		mv.setViewName("headoffice/chartagegroup");
		return mv;
	}

	// 가맹점 발주내역 상세보기(발주번호 별로) return json
	@RequestMapping(value = "/fcorderdetail")
	public ModelAndView fcorderdetail(ModelAndView mv, FcOrderDetailVO vo, ItemInfoVO ivo) {
		vo.setItemInfoVO(ivo);
		List<FcOrderDetailVO> list = service.selectFcOrderDetailbyOrderNumber(vo);
		if (list.size() > 0) {
			mv.addObject("list", list);
		} else {
			mv.addObject("message", "조회할 자료가 없습니다.");
		}

		mv.setViewName("jsonView");
		return mv;
	}

	// 가맹점 발주내역 처리완료로 변경
	@RequestMapping(value = "/fcordersequpdate")
	public ModelAndView fcOrderSeqUpdate(ModelAndView mv, FcOrderVO vo, @RequestParam("flag") String flag) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("flag", flag);
		param.put("vo", vo);

		if (service.fcOrderSeqUpdate(param) > 0) {
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		mv.setViewName("jsonView");
		return mv;
	}

	// 발주내역 서치,페이징 + 폼 이동(강현구)
	// 요청에 쿼리스트링으로 구분
	// flag = Y -> 처리완료
	// flag = N -> 미러치
	// 쿼리스트링X -> 전체조회?(미구현)
	@RequestMapping(value = "/fcorder")
	public ModelAndView fcorder(ModelAndView mv, FcOrderVO vo, @RequestParam("flag") String flag, PageMaker pageMaker,
			SearchCriteria cri) {

		String uri = "headoffice/headofficeMain";
		if ("Y".equals(flag))
			uri = "headoffice/fcOrderY";
		else if ("N".equals(flag))
			uri = "headoffice/fcOrderN";

		cri.setSnoEno();

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("flag", flag);
		params.put("cri", cri);

		List<FcOrderVO> list = service.searchFcOrder(params);

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
		} else {
			mv.addObject("message", "조회할 자료가 없습니다.");
		}
		pageMaker.setCri(cri);
		pageMaker.setTotalRowCount(service.searchFcOrderRows(params));

		mv.setViewName(uri);
		return mv;
	};

	// 본사: 자재 삭제 (강현구)
	@RequestMapping(value = "/itemdelete")
	public ModelAndView itemdelete(ModelAndView mv, ItemInfoVO vo) {

		if (service.itemdelete(vo) > 0) {
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		mv.setViewName("jsonView");
		return mv;
	}

	// 본사: 자재 상세수정 (강현구)
	@RequestMapping(value = "/itemupdate")
	public ModelAndView itemupdate(ModelAndView mv, ItemInfoVO vo) {

		if (service.itemUpdate(vo) > 0) {
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		mv.setViewName("jsonView");
		return mv;
	}

	// 본사: 자재 상세조회 (강현구)
	@RequestMapping(value = "/itemdetail")
	public ModelAndView itemdetail(ModelAndView mv, ItemInfoVO vo) {
		vo = service.selectOneItem(vo);
		if (vo != null) {
			mv.addObject("vo", vo);
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		mv.setViewName("jsonView");

		return mv;
	}

	// 본사: 자재입력기능 (강현구)
	@RequestMapping(value = "/iteminsert")
	public ModelAndView iteminsert(ModelAndView mv, ItemInfoVO vo) {

		if (service.iteminsert(vo) > 0) {
			mv.addObject("message", vo.getItemName() + " 입력이 완료되었습니다.");
			mv.addObject("success", "success");
		} else {
			mv.addObject("message", vo.getItemName() + " 입력이 실패하였습니다.");
			mv.addObject("success", "fail");
		}
		mv.setViewName("jsonView");

		return mv;
	}

	// 본사: 자재리스트 서치 + 조회 + 자재조회폼 이동 (강현구)
	@RequestMapping(value = "/itemselect")
	public ModelAndView iteminsertf(ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {

		cri.setSnoEno();
		List<ItemInfoVO> list = service.searchItemList(cri);

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.setViewName("headoffice/itemselectf");
		} else {
			mv.setViewName("headoffice/itemselectf");
			mv.addObject("message", "조회된 자료가 없습니다.");
		}
		pageMaker.setCri(cri);
		pageMaker.setTotalRowCount(service.searchItemRows(cri));

		return mv;
	}

//=========================< 본사 계정 관리 >=========================	

	// 로그인폼이동 (강광훈)
	@RequestMapping(value = "/loginf")
	public ModelAndView loginf(ModelAndView mv) {
		mv.setViewName("headoffice/loginForm");
		return mv;
	}// loginf-> 폼으로 이동시켜줌

	// 로그인(강광훈)
	@RequestMapping(value = "/login")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, ModelAndView mv,
			HeadOfficeVO headOfficeVo, StaffVO staffVo, ChartVO cVo, HttpSession session) throws ServletException, IOException {
		String uri = "/headoffice/loginForm";
		// 이미 로그인 한 경우
		if(session.getAttribute("loginID") != null) {
			// 홈화면에 나타낼 정보 처리(좌상단 통계)
			String fcId = null;
			cVo = fservice.fcThisMonthSales(fcId);
			mv.addObject("thisMonthSales", cVo==null ? 0 : cVo.getChartCount());
			cVo = fservice.fcTodaySales(fcId);
			mv.addObject("todaySales", cVo==null ? 0 : cVo.getChartCount());
			cVo = fservice.fcYesterdaySales(fcId);
			mv.addObject("yesterdaySales", cVo==null ? 0 : cVo.getChartCount());
			cVo = fservice.fcLastMonthSales(fcId);
			mv.addObject("lastMonthSales", cVo==null ? 0 : cVo.getChartCount());
			
			cVo = service.selectNumberOfFranchise("");
			mv.addObject("numberOfAllFranchise", cVo==null ? 0 : cVo.getChartCount());
			cVo = service.selectNumberOfFranchise("NEW");
			mv.addObject("numberOfNewFranchise", cVo==null ? 0 : cVo.getChartCount());
			
			List<FcOrderVO> list = new ArrayList<FcOrderVO>();
			list = service.selectFcOrderSumPirce();
			if(list != null && list.size()>0) {
				mv.addObject("orderList",list);
			}
			
			uri = "headoffice/headofficeMain";
		} else {
			// 정보 저장
			String password = headOfficeVo.getHoPassword();
			
			
			
			System.out.println(headOfficeVo.getHoPassword());
			System.out.println(staffVo.getStaffCode());
			
			
			
			// 로그인서비스처리
			staffVo = service.selectOne(staffVo);
			
			if (staffVo != null) {
				headOfficeVo.setStaffVo(staffVo);
				headOfficeVo = service.loginSelectOne(headOfficeVo);
				
				// 정보 확인
				if (headOfficeVo != null) { // ID는 일치 -> Password 확인
					if (passwordEncoder.matches(password, headOfficeVo.getHoPassword())) {
						// if (headOfficeVo.getHoPassword().equals(password)) {
						
						headOfficeVo.setStaffVo(staffVo);// 굳이 이걸왜 한번 더 해야하는지모르겠는데 이거해야 밑에 널포인트 안뜸 ...
						// 로그인 성공 -> 로그인 정보 session에 보관
						request.getSession().setAttribute("loginID", headOfficeVo.getStaffVo().getStaffCode());
						request.getSession().setAttribute("loginName", headOfficeVo.getStaffVo().getStaffName());
						uri = "headoffice/headofficeMain";
						
						// 로그인 후 홈화면에 나타낼 정보 처리(좌상단 통계)
						String fcId = null;
						cVo = fservice.fcThisMonthSales(fcId);
						mv.addObject("thisMonthSales", cVo==null ? 0 : cVo.getChartCount());
						cVo = fservice.fcTodaySales(fcId);
						mv.addObject("todaySales", cVo==null ? 0 : cVo.getChartCount());
						cVo = fservice.fcYesterdaySales(fcId);
						mv.addObject("yesterdaySales", cVo==null ? 0 : cVo.getChartCount());
						cVo = fservice.fcLastMonthSales(fcId);
						mv.addObject("lastMonthSales", cVo==null ? 0 : cVo.getChartCount());
						
						cVo = service.selectNumberOfFranchise("");
						mv.addObject("numberOfAllFranchise", cVo==null ? 0 : cVo.getChartCount());
						cVo = service.selectNumberOfFranchise("NEW");
						mv.addObject("numberOfNewFranchise", cVo==null ? 0 : cVo.getChartCount());
						
						List<FcOrderVO> list = new ArrayList<FcOrderVO>();
						list = service.selectFcOrderSumPirce();
						if(list != null && list.size()>0) {
							mv.addObject("orderList",list);
						}
						
						
					} else {
						mv.addObject("message", "Password가 일치하지않습니다.");
					}
				} else {
					mv.addObject("message", "회원정보가 없습니다. ID를 확인해주세요.");
				} // if
			} else {
				mv.addObject("message", "회원정보가 없습니다. ID를 확인해주세요.");
			} // if(staffVo null)
		}
		mv.setViewName(uri);

		return mv;
	}// login

	// 본사 홈화면 최근7일 매출 차트데이터
	@RequestMapping(value = "/allFcchartsevenday")
	public ModelAndView allFcChartSevenDay(ModelAndView mv) {
		String fcId = null;
		List<ChartVO> chartList = new ArrayList<ChartVO>();
		
		chartList = fservice.fcLastSevenDaysSalesPerDay(fcId);
		if(chartList != null && chartList.size()>0) {
			mv.addObject("charData", chartList);
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		
		mv.addObject("charData", chartList);
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 로그아웃 (강광훈)
	@RequestMapping(value = "/logout")
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
		String uri = "redirect:/headoffice/loginf";
		rttr.addFlashAttribute("message", "로그아웃 완료");

		// mv.addObject("message","~~~") -> forward
		// uri = "home" -> forward

		mv.setViewName(uri);

		return mv;
	} // logout

	// 비번변경폼이동 (강광훈)
	@RequestMapping(value = "/passwordReset")
	public ModelAndView passwordReset(ModelAndView mv) {
		mv.setViewName("headoffice/passwordResetForm");
		return mv;
	}// passwordResetf-> 폼으로 이동시켜줌

	// staff 리스트
	@RequestMapping(value = "/staffList")
	public ModelAndView staffList(ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
		cri.setSnoEno();

		List<StaffVO> list = service.searchStaffList(cri);

		if (list != null && list.size() > 0) {
			mv.addObject("staffList", list);
		} else {
			mv.addObject("message", "출력할 자료가 없습니다.");
		}
		mv.setViewName("headoffice/headofficeStaffList");
		pageMaker.setCri(cri);
		pageMaker.setTotalRowCount(service.searchStaffRows(cri));

		return mv;
	}// staff 목록 리스트

	// staff 디테일 (강광훈)
	@RequestMapping(value = "/staffDetail")
	public ModelAndView staffDetail(HttpServletResponse response, ModelAndView mv, StaffVO vo) {

		vo = service.selectOne(vo);

		if (vo != null)
			mv.addObject("staffDetail", vo); // MyBatis 에선 null , size()>0 으로 확인
		else
			mv.addObject("message", "정보가 없습니다.");
		mv.setViewName("jsonView");

		return mv;
	}// staffDetail

	@RequestMapping(value = "/staffJoinf") // 멤버계정생성폼 이동 (강광훈)
	public ModelAndView staffJoinf(ModelAndView mv) {
		mv.setViewName("headoffice/headofficeJoinForm");
		return mv;
	}// joinf

	// staffJoin -> Insert (강광훈)
	@RequestMapping(value = "/staffJoin")
	public ModelAndView staffJoin(ModelAndView mv, StaffVO svo, HeadOfficeVO hvo) {

		hvo.setHoPassword(passwordEncoder.encode(hvo.getHoPassword()));

		if (service.staffInsert(svo) > 0) {
			hvo.setStaffVo(svo);
			if (service.headOfficeInsert(hvo) > 0) {
				mv.addObject("message", "계정생성이 완료되었습니다.");
				mv.addObject("success", "success");
			} else {
				mv.addObject("message", "계정생성이 실패하였습니다.");
				mv.addObject("success", "fail");
			}
		} else {
			mv.addObject("message", " 계정생성이 실패하였습니다.");
			mv.addObject("success", "fail");
		}

		mv.setViewName("jsonView");
		return mv;
	}// join

	// staff 정보 업데이트
	@RequestMapping(value = "/staffUpdate")
	public ModelAndView staffUpdate(ModelAndView mv, StaffVO svo) {
		if (service.staffUpdate(svo) > 0) {
			mv.addObject("message", "정보수정이 완료되었습니다.");
			mv.addObject("success", "success");
		} else {
			mv.addObject("message", "정보수정이 실패하였습니다.");
			mv.addObject("success", "fail");
		}

		mv.setViewName("jsonView");
		return mv;
	}// join

	// ** staff 삭제
	@RequestMapping(value = "/staffDelete")
	public ModelAndView staffDelete(HttpServletRequest request, HttpServletResponse response, ModelAndView mv,
			StaffVO svo, HeadOfficeVO hvo, RedirectAttributes rttr) {
		hvo.setStaffVo(svo);
		if (service.headOfficeDelete(hvo) > 0) {
			if (service.staffDelete(svo) > 0) {
				mv.addObject("success", "success");
			} else {
				mv.addObject("success", "fail");
			}
		} else {
			mv.addObject("success", "fail");
		}
		mv.setViewName("jsonView");
		return mv;

	}// delete

	// ** staff 내정보보기 클릭시
	@RequestMapping(value = "/staffMyInfo")
	public ModelAndView staffDetail(HttpServletRequest request, ModelAndView mv, StaffVO svo, HeadOfficeVO hvo) {
		String id = (String) request.getSession().getAttribute("loginID");
		String password = (String) request.getSession().getAttribute("loginPW");

		svo.setStaffCode(id);

		svo = service.selectOne(svo);

		hvo.setStaffVo(svo);

		hvo = service.loginSelectOne(hvo);

		if (hvo != null) {
			hvo.setHoPassword(password);
			hvo.setStaffVo(svo);
			mv.addObject("staffMyInfo", hvo); // MyBatis 에선 null , size()>0 으로 확인
		} else
			mv.addObject("message", "정보가 없습니다.");

		mv.setViewName("headoffice/headofficeStaffMyInfo");

		return mv;
	}// staffDetail

	// ** 직원 비번변경시 현재비번확인
	@RequestMapping(value = "/staffloginPwCheck")
	public ModelAndView staffloginPwCheck(HttpServletRequest request, ModelAndView mv, HeadOfficeVO hvo, StaffVO svo) {
		String hoid = (String) request.getSession().getAttribute("loginID");

		String inputPw = hvo.getHoPassword();
		svo.setStaffCode(hoid);

		hvo.setStaffVo(service.selectOne(svo));
		hvo = service.loginSelectOne(hvo);

		if (passwordEncoder.matches(inputPw, hvo.getHoPassword())) {
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}

		mv.setViewName("jsonView");

		return mv;
	}// staffDetail

	// ** 비번 변경
	@RequestMapping(value = "/headOfficePwUpdate")
	public ModelAndView headOfficePwUpdate(HttpServletRequest request, ModelAndView mv, HeadOfficeVO hvo, StaffVO svo) {
		String hoid = (String) request.getSession().getAttribute("loginID");
		String inputPw = hvo.getHoPassword();
		svo.setStaffCode(hoid);

		hvo.setStaffVo(service.selectOne(svo));
		hvo = service.loginSelectOne(hvo);
		hvo.setStaffVo(service.selectOne(svo));
		hvo.setHoPassword(passwordEncoder.encode(inputPw));

		if (service.headOfficePwUpdate(hvo) > 0) {
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}

		mv.setViewName("jsonView");

		return mv;
	}// staffDetail

//=========================< 가맹점 관리 >=========================

	
	// ** 가맹점 비번변경시 현재비번확인
	@RequestMapping(value = "/fcloginPwCheck")
	public ModelAndView fcloginPwCheck(HttpServletRequest request, ModelAndView mv, FranchiseVO fvo) {
		
		String inputPw = fvo.getFcPassword();

		fvo = fservice.selectFcOne(fvo);

		if (passwordEncoder.matches(inputPw, fvo.getFcPassword())) {
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}

		mv.setViewName("jsonView");

		return mv;
	}// fcloginPwCheck	
	
	// 가맹점 비밀번호 변경
	@RequestMapping(value = "/fcpwupdate")
	public ModelAndView fcPwUpdate(ModelAndView mv, FranchiseVO vo) {
		if (fservice.fcPwUpdate(vo) > 0) {
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}

		mv.setViewName("jsonView");
		return mv;
	}// fcupdate
	
	// 가맹점 리스트
	@RequestMapping(value = "/fclist")
	public ModelAndView fclist(ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
		cri.setSnoEno();
		List<FranchiseVO> list = service.searchFcList(cri);

		if (list != null && list.size() > 0) {
			mv.addObject("fcList", list);
		} else {
			mv.addObject("message", "출력할 자료가 없습니다.");
		}
		mv.setViewName("headoffice/fcList");

		pageMaker.setCri(cri);
		pageMaker.setTotalRowCount(service.searchFcRows(cri));
		return mv;
	}// staff 목록 리스트

	// 가맹점 생성 폼 이동
	@RequestMapping(value = "/fcinsertf")
	public ModelAndView fcinsertf(ModelAndView mv) {
		mv.setViewName("headoffice/fcInsertf");
		return mv;
	}// joinf

	// 가맹점 insert (강광훈)
	@RequestMapping(value = "/fcinsert")
	public ModelAndView fcInsert(ModelAndView mv, FranchiseVO vo) {
		
		try {
			
			log.info("가맹점 기입 비밀번호 : "+vo.getFcPassword());
			vo.setFcPassword(passwordEncoder.encode(vo.getFcPassword()));
			
		
		} catch (IllegalArgumentException e) {
				e.toString();	
		}
			finally {
				if (fservice.fcInsert(vo) > 0) {
					mv.addObject("message", "계정생성이 완료되었습니다.");
					mv.addObject("success", "success");
				} else {
					mv.addObject("message", " 계정생성이 실패하였습니다.");
					mv.addObject("success", "fail");
				}
			}
		
			mv.setViewName("jsonView");
			return mv;	
		
	/*
경과.
1. 2022.02.12. 16시쯤 발생.
2. 발생 환경 : 가맹점 insert 시 발생함.
3. 해결 안됨. 
4. 우회 방안 : 트라이캐치로 finally로 강제로 삽입함.

 타입 예외 보고

메시지 Request processing failed; nested exception is java.lang.IllegalArgumentException: rawPassword cannot be null

설명 서버가, 해당 요청을 충족시키지 못하게 하는 예기치 않은 조건을 맞닥뜨렸습니다.

예외

org.springframework.web.util.NestedServletException: Request processing failed; nested exception is java.lang.IllegalArgumentException: rawPassword cannot be null
	org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1014)
	org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:898)
	javax.servlet.http.HttpServlet.service(HttpServlet.java:655)
	org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)
	javax.servlet.http.HttpServlet.service(HttpServlet.java:764)
	org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)
	org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)
	org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)
근본 원인 (root cause)

java.lang.IllegalArgumentException: rawPassword cannot be null
	org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder.encode(BCryptPasswordEncoder.java:103)
	com.project.federico.HeadOfficeController.fcInsert(HeadOfficeController.java:834)
	sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
	sun.reflect.NativeMethodAccessorImpl.invoke(Unknown Source)
	sun.reflect.DelegatingMethodAccessorImpl.invoke(Unknown Source)
	java.lang.reflect.Method.invoke(Unknown Source)
	org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:190)
	org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)
	org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:106)
	org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:879)
	org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:793)
	org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)
	org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1040)
	org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:943)
	org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1006)
	org.springframework.web.servlet.FrameworkServlet.doGet(FrameworkServlet.java:898)
	javax.servlet.http.HttpServlet.service(HttpServlet.java:655)
	org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:883)
	javax.servlet.http.HttpServlet.service(HttpServlet.java:764)
	org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)
	org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:201)
	org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:119)
비고 근본 원인(root cause)의 풀 스택 트레이스를, 서버 로그들에서 확인할 수 있습니다.
*/		
			
			
			
			
			
	}// join

	// ** 가맹점 detail
	@RequestMapping(value = "/fcdetail")
	public ModelAndView fcdetail(HttpServletResponse response, ModelAndView mv, FranchiseVO vo) {

		vo = fservice.selectFcOne(vo);

		if (vo != null)
			mv.addObject("fcDetail", vo); // MyBatis 에선 null , size()>0 으로 확인
		else
			mv.addObject("message", "정보가 없습니다.");
		mv.setViewName("jsonView");

		return mv;
	}// fcdetail

	// 가맹점 정보 업데이트
	@RequestMapping(value = "/fcupdate")
	public ModelAndView fcUpdate(ModelAndView mv, FranchiseVO vo) {
		if (fservice.fcUpdate(vo) > 0) {
			mv.addObject("message", "정보수정이 완료되었습니다.");
			mv.addObject("success", "success");
		} else {
			mv.addObject("message", "정보수정이 실패하였습니다.");
			mv.addObject("success", "fail");
		}

		mv.setViewName("jsonView");
		return mv;
	}// fcupdate

	// 가맹점 폐점처리
	@RequestMapping(value = "/fcclose")
	public ModelAndView fcClose(ModelAndView mv, FranchiseVO vo) {

		if (fservice.fcClose(vo) > 0) {
			mv.addObject("message", "폐점처리가 완료되었습니다.");
			mv.addObject("success", "success");
		} else {
			mv.addObject("message", "폐점처리에 실패하였습니다.");
			mv.addObject("success", "fail");
		}
		mv.setViewName("jsonView");
		return mv;
	}// fcclose

//	=========================< 시큐리티 로그인적용(광훈) >==========================
	
	// 로그인폼이동 (강광훈)
//	@RequestMapping(value = "/securityHeadofficeLoginf")
//	public ModelAndView securityHeadofficeLoginf(ModelAndView mv) {
//		mv.setViewName("headoffice/ssloginForm");
//		return mv;
//	}// loginf-> 폼으로 이동시켜줌
	

	
	//============================Menu 민석=======================
	@RequestMapping(value = "/menuList")
	public ModelAndView menuList(ModelAndView mv,MenuVO vo,
			SearchCriteria cri,PageMaker pageMaker) {
		
		cri.setSnoEno();
		List<MenuVO> list = menuService.searchMenuList(cri);
		if(list != null) {
			mv.addObject("menuList",list);
			mv.setViewName("headoffice/menuList");
		} else {
			mv.setViewName("headoffice/menuList");
			mv.addObject("message","출력자료 없음.");
		}
		pageMaker.setCri(cri);
		pageMaker.setTotalRowCount(menuService.searchMenuRows(cri));

		return mv;
	}// menuList end
	

	
	@RequestMapping(value = "/menuInsert") // 민석
	public ModelAndView menuInsert(HttpServletRequest request, ModelAndView mv, MenuVO vo,RedirectAttributes rttr) 
		 	throws IOException {
		// 날짜폴더자동생성
		/*
		String uploadFolder = "C:/Users/19467/git/FedericoProject/src/main/webapp/resources/uploadImage/menuImage/";
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload path"+uploadPath);
		if(uploadPath.exists()==false)
			uploadPath.mkdirs();
			*/	
		
		// Form을 이용한 파일 업로드 방식

		// 1) 현재 웹어플리케이션의 실행 위치 확인 : 
		
		
		String realPath = request.getRealPath("/"); // deprecated Method
		System.out.println("** realPath => "+realPath);

		// 2) 위 의 값을 이용해서 실제저장위치 확인 
		// 경로는 각자의 경로로 바꾸시면 좋을 것 같습니다~
		if (realPath.contains(".eclipse."))

			 realPath = "C:/Users/19467/git/FedericoProject/src/main/webapp/resources/uploadImage/menuImage/";
		// realPath = "D:/MTest/MyWork/Spring02/src/main/webapp/resources/"+vo.getId()+"/";
		else realPath += "/resources/uploadImage/menuImage/";

		// ** 폴더 만들기 (File 클래스활용)
		File f1 = new File(realPath);
		if ( !f1.exists() ) f1.mkdir();
		
		String file1, file2="/federico/resources/uploadImage/menuImage/";
		
		MultipartFile uploadfilef = vo.getMenuUploadfilef();
		if ( uploadfilef !=null && !uploadfilef.isEmpty() ) {
			// Image 를 선택했음 -> Image 처리 (realPath+화일명)
			// 1) 물리적 위치에 Image 저장 
			file1=realPath + uploadfilef.getOriginalFilename(); //  전송된File명 추출 & 연결
		
			uploadfilef.transferTo(new File(file1)); // real 위치에 전송된 File 붙여넣기
			// 2) Table 저장위한 경로 
			file2 = "/federico/resources/uploadImage/menuImage/"+ uploadfilef.getOriginalFilename();
		}
		vo.setMenuImage(file2);
		
		// 2. Service 처리

		String uri = null;
		
		if(menuService.menuInsert(vo)>0) {
			mv.addObject("message",vo.getMenuName()+"입력이 완료되었습니다.");
			mv.addObject("success","success");
			uri = "redirect:menuList";
			
			uri="redirect:menuList";
			
		}else {
			mv.addObject("message",vo.getMenuName()+"입력이 실패하였습니다.");
			mv.addObject("success","fail");
			uri = ""; // 실패했을 때 
		}
			
		mv.setViewName(uri);
		return mv;

		/*
	// Ajax를 이용한 파일 업로드 방식
		log.info("upload Ajax");
		
		String uploadFolder = "C:/Users/19467/git/FedericoProject/src/main/webapp/resources/uploadImage";
		
		for(MultipartFile multipartFile : uploadFile) {
			log.info("----------------------------------------");
			log.info("upload File Name : "+multipartFile.getOriginalFilename());
			log.info("upload File Size : "+multipartFile.getSize());
			
			String uploadFileName = multipartFile.getOriginalFilename();
			//IE has file path
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("/")+1);
			
			log.info("only File Name : "+ uploadFile);
			File saveFile = new File(uploadFolder, uploadFileName);
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}// end catch
			
		}// end for
		*/	
		
	} // end method
	
	@RequestMapping(value = "/menuUpdate")	
	public ModelAndView menuUpdate(HttpServletRequest request, 
			ModelAndView mv,MenuVO vo,RedirectAttributes rttr ) 
	throws IOException{
		/*
		 성공시 :
		 1. 수정된 정보 확인 => list로 이동
		 2. image 추가 : 
		  image 수정여부 확인 
		  => 수정하지 않은경우 vo에 전달된 menuImage 값을 사용
		  => 수정시에만 변경처리.		  	  
		 */
		System.out.println("Index =>"+vo.getMenuIndex());
		System.out.println("flag =>"+vo.getMenuFlag());
		System.out.println("Image =>"+vo.getMenuImage());
		System.out.println("Intro =>"+vo.getMenuIntro());		
		System.out.println("Name =>"+vo.getMenuName());
		System.out.println("Price =>"+vo.getMenuPrice());
		System.out.println("menuUploadfilef =>"+vo.getMenuUploadfilef());
		
	
		
		MultipartFile uploadfilef = vo.getMenuUploadfilef();
		
		String file1, file2;
		
		if(uploadfilef != null && !uploadfilef.isEmpty()) {
			String realPath = request.getRealPath("/");
			
			if(realPath.contains(".eclips."))
				realPath = "/Users/gniusk614/Documents/WEBDEVELOP/MTest/TeamProject/FedericoProject/src/main/webapp/resources/uploadImage/menuImage/";
			else {
				realPath += "/resources/uploadImage/menuImage/";	
			}
			File f1 = new File(realPath);
			if ( !f1.exists()) f1.mkdir();
		// 전송된 file 처리 
		
		// 이미지 붙여넣기.
			file1=realPath + uploadfilef.getOriginalFilename();
			uploadfilef.transferTo(new File(file1));
			
			file2 = "/federico/resources/uploadImage/menuImage/"+ uploadfilef.getOriginalFilename();
			vo.setMenuImage(file2);
			System.out.println("Image =>"+vo.getMenuImage());
			System.out.println("Image =>"+ uploadfilef.getOriginalFilename());
		}
			
		String uri = null;
			
		if(menuService.menuUpdate(vo) > 0) {
			rttr.addFlashAttribute("success","수정완료");
//			request.getSession().setAttribute("loginName", vo.getName());
			uri = "redirect:menuList";
		} else { rttr.addFlashAttribute("success","수정실패");
		uri = ""; // 실패시 이동페이지
		
		}
		mv.setViewName(uri); 
		return mv;
		
	} //mupdate
	
	@RequestMapping(value = "/menuDetail")
	public ModelAndView menuDetail(ModelAndView mv, MenuVO vo) {
		
		vo = menuService.selectMenuOne(vo);
		log.info(vo.getMenuIndex());
		log.info(vo);
		
		
		if(vo != null) { 
			mv.addObject("menuvo",vo);
			mv.addObject("success","success");
		
		}else { mv.addObject("success","Fail");}
		
		
		mv.setViewName("jsonView");
			
		return mv;
	}
	
	

	@RequestMapping(value = "/menuDie")
	public ModelAndView menuDie(ModelAndView mv,MenuVO vo) {
		
		log.info("menuLife/menuDie) : "+vo.getMenuLive());
		
		if(menuService.menuLive(vo)>0) 			
			mv.addObject("success","success");			
		else
			mv.addObject("success","fail");				
		
		mv.setViewName("jsonView"); 
		return mv;
		
	} //menuDie
	
	//메인화면 보내기
	@RequestMapping(value = "/headofficeMain")
	public String headOfficeMain(ModelAndView mv,MenuVO vo) {
		return "headoffice/headofficeMain";
	} //headofficeMain
	
	
	
	// 차트화면 띄우기
	@RequestMapping(value = "/chart")
	public ModelAndView chart(ModelAndView mv, ChartVO vo, @RequestParam("flag") String flag) {
		List<ChartVO> list = new ArrayList<ChartVO>();
		
		switch(flag) {
		case "month" : list =service.monthChart(); break;
		case "day" :   list = service.dayChart(); break;
//		case "menu" :  list = service.menuChart(); break;
//		case "age" :   list = service.ageChart(); break;
//		case "area" : list = service.areaChart(); break;
		}
		if(list !=null) {
			mv.addObject("list", list);
		}else {
			mv.addObject("message", "통계자료가 없습니다.");
		}
		mv.setViewName("jsonView");
		return mv;
	} // chart	
	
	
	
	
	
	//고객공지사항 이동
	@RequestMapping(value = "noticeBoardf")
	public ModelAndView noticeBoardf(ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
		cri.setSnoEno();
		
		List<NoticeBoardVO> selectList = cservice.selectNoticeBoard();
		List<NoticeBoardVO> searchList = cservice.searchNoticeBoard(cri);
		if (searchList != null && searchList.size() > 0) {
			if(selectList !=null && selectList.size()>0) {
				mv.addObject("noticeList",selectList);
			}
			mv.addObject("boardList", searchList);
		} else {
			mv.addObject("message", "출력할 자료가 없습니다.");
		}
		pageMaker.setCri(cri);
		pageMaker.setTotalRowCount(cservice.searchNoticeBoardRows(cri));
		
		mv.setViewName("headoffice/noticeBoard");
		return mv;
	}
	
	
	//공지사항 디테일
	@RequestMapping(value ="/noticeDetail")
	public ModelAndView csNoticeDetail (ModelAndView mv ,NoticeBoardVO vo) {					
		vo = cservice.selectDetailNoticeBoard(vo);
		if(vo!=null) {
			mv.addObject("noticeDetail", vo);
		}else {
			mv.addObject("message", "출력할 글이 없습니다.");
		}
		mv.setViewName("headoffice/noticeBoardDetail");
		return mv;
	}
	
	//공지사항 글쓰기이동
	@RequestMapping(value ="/noticeInsertf")
	public ModelAndView noticeInsertf (ModelAndView mv ,NoticeBoardVO vo) {					
		mv.setViewName("headoffice/noticeBoardInsert");
		return mv;
	}
	
	
	
	//ckeditor이미지업로드
	@RequestMapping(value="/boardImageUpload", method = RequestMethod.POST)
    public void boardImageUpload(HttpServletRequest request,
    		HttpServletResponse response, MultipartHttpServletRequest multiFile
    		, @RequestParam MultipartFile upload) throws Exception{
    	// 랜덤 문자 생성
    	UUID uid = UUID.randomUUID();
    	
    	OutputStream out = null;
    	PrintWriter printWriter = null;
    	
    	//인코딩
    	response.setCharacterEncoding("utf-8");
    	response.setContentType("text/html;charset=utf-8");
    	try{
    		//파일 이름 가져오기
			String fileName = upload.getOriginalFilename();
			byte[] bytes = upload.getBytes();

			// 이미지 경로 생성
			String path = request.getRealPath("/");
			if (path.contains(".eclipse."))
				path = "/Users/gniusk614/Documents/WEBDEVELOP/MTest/TeamProject/FedericoProject/src/main/webapp/resources/uploadImage/boardImage/"; // 저장된 이미지 경로
			else path += "/resources/uploadImage/boardImage/"; 
			// 이미지 경로 설정(폴더 자동 생성)
			String ckUploadPath = path + uid + "_" + fileName;
			File folder = new File(path);
			System.out.println("1path:" + path); // 이미지 저장경로 console에 확인
			// 해당 디렉토리 확인
			if (!folder.exists()) {
				try {
					folder.mkdirs(); // 폴더 생성
				} catch (Exception e) {
					e.getStackTrace();
				}
			}
    	
    	out = new FileOutputStream(new File(ckUploadPath));
    	out.write(bytes);
    	out.flush(); // outputStram에 저장된 데이터를 전송하고 초기화
    	
    	String callback = request.getParameter("CKEditorFuncNum");
    	printWriter = response.getWriter();
    	String fileUrl = "/federico/headoffice/ckImgSubmit.do?uid=" + uid + "&fileName=" + fileName; // 작성화면
    	
    	// 업로드시 메시지 출력
    	printWriter.println("{\"filename\" : \""+fileName+"\", \"uploaded\" : 1, \"url\":\""+fileUrl+"\"}");
    	printWriter.flush();
    	
    	}catch(IOException e){
    		e.printStackTrace();
    	} finally {
    		try {
    		if(out != null) { out.close(); }
    		if(printWriter != null) { printWriter.close(); }
    	} catch(IOException e) { e.printStackTrace(); }
    	}
    	return;
    }
	
	
	// 서버로 전송된 이미지 뿌려주기
	@RequestMapping(value = "/ckImgSubmit.do")
	public void ckSubmit(@RequestParam(value = "uid") String uid, @RequestParam(value = "fileName") String fileName,
			HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 서버에 저장된 이미지 경로
		String path = request.getRealPath("/");
		log.info("realpath => "+path);
		if (path.contains(".eclipse."))
			path = "/Users/gniusk614/Documents/WEBDEVELOP/MTest/TeamProject/FedericoProject/src/main/webapp/resources/uploadImage/boardImage/"; // 저장된 이미지 경로
		else path += "/resources/uploadImage/boardImage/";
		
		
		System.out.println("2path:" + path);
		String sDirPath = path + uid + "_" + fileName;

		File imgFile = new File(sDirPath);

		// 사진 이미지 찾지 못하는 경우 예외처리로 빈 이미지 파일을 설정한다.
		if (imgFile.isFile()) {
			byte[] buf = new byte[1024];
			int readByte = 0;
			int length = 0;
			byte[] imgBuf = null;

			FileInputStream fileInputStream = null;
			ByteArrayOutputStream outputStream = null;
			ServletOutputStream out = null;

			try {
				fileInputStream = new FileInputStream(imgFile);
				outputStream = new ByteArrayOutputStream();
				out = response.getOutputStream();

				while ((readByte = fileInputStream.read(buf)) != -1) {
					outputStream.write(buf, 0, readByte);
				}

				imgBuf = outputStream.toByteArray();
				length = imgBuf.length;
				out.write(imgBuf, 0, length);
				out.flush();

			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				outputStream.close();
				fileInputStream.close();
				out.close();
			}
		}
	}
	
	//공지사항 글등록
	@RequestMapping(value ="/noticeInsert")
	public ModelAndView noticeInsert (HttpServletRequest request, ModelAndView mv ,NoticeBoardVO vo) {	
		String id = (String) request.getSession().getAttribute("loginID");
		vo.setId(id);
		if(service.noticeInsert(vo)>0) {
			mv.addObject("success", "성공");
		}else {
			mv.addObject("message", "실패");
		}
		mv.setViewName("jsonView");
		return mv;
	}

	// 공지사항 글수정 폼이동
	@RequestMapping(value = "/noticeUpdatef")
	public ModelAndView noticeUpdatef(ModelAndView mv, NoticeBoardVO vo) {
		vo = cservice.selectDetailNoticeBoard(vo);
		if (vo != null) {
			mv.addObject("noticeDetail", vo);
		} else {
			mv.addObject("message", "출력할 글이 없습니다.");
		}
		mv.setViewName("headoffice/noticeBoardUpdate");
		return mv;
	}
	
	//공지사항 글 수정(수정자 ID로 작성자 변경됨)
	@RequestMapping(value ="/noticeUpdate")
	public ModelAndView noticeUpdate (HttpServletRequest request, ModelAndView mv ,NoticeBoardVO vo) {	
		String id = (String) request.getSession().getAttribute("loginID");
		vo.setId(id);
		if(service.noticeUpdate(vo)>0) {
			mv.addObject("success", "성공");
		}else {
			mv.addObject("message", "실패");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	// 공지사항 글 삭제
	@RequestMapping(value = "/noticeDelete")
	public ModelAndView noticeDelete(ModelAndView mv, NoticeBoardVO vo) {
		
		if (service.noticeDelete(vo)>0) {
			mv.addObject("success", "성공");
		}else {
			mv.addObject("message", "실패");
		}
		mv.setViewName("jsonView");
		return mv;
	}	

	//고객공지사항 이동
	@RequestMapping(value = "complainBoardf")
	public ModelAndView complainBoardf(ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
		cri.setSnoEno();
		
		List<ComplainBoardVO> searchList = cservice.searchComplainBoard(cri);
		if (searchList != null && searchList.size() > 0) {
			mv.addObject("boardList", searchList);
		} else {
			mv.addObject("message", "출력할 자료가 없습니다.");
		}
		pageMaker.setCri(cri);
		pageMaker.setTotalRowCount(cservice.searchComplainBoardRows(cri));
		
		mv.setViewName("headoffice/complainBoard");
		return mv;
	}
	
	//컴플레인 디테일
	@RequestMapping(value ="/complainDetail")
	public ModelAndView complainDetail (ModelAndView mv ,ComplainBoardVO vo, ComplainCommentVO cvo) {	
		cvo.setComplainBoardSeq(vo.getSeq());
		
		List<ComplainCommentVO> list = cservice.selectListComplainComment(cvo);
		vo = cservice.selectDetailComplainBoard(vo);
		if(vo!=null) {
			mv.addObject("complainDetail", vo);
			mv.addObject("complainComment", list);
		}else {
			mv.addObject("message", "출력할 글이 없습니다.");
		}
		mv.setViewName("headoffice/complainBoardDetail");
		return mv;
	}
	
	//컴플레인 완료처리
	@RequestMapping(value ="/complainComplete")
	public ModelAndView complainComplete (HttpServletRequest request, ModelAndView mv ,ComplainBoardVO vo) {	
		
		if(cservice.complainComplete(vo)>0) {
			mv.addObject("success", "성공");
		}else {
			mv.addObject("message", "실패");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	//컴플레인 댓글달기
	@RequestMapping(value ="/complainCommentInsert")
	public ModelAndView complainCommentInsert (HttpServletRequest request, ModelAndView mv ,ComplainCommentVO vo) {	
		String id = (String) request.getSession().getAttribute("loginID");
		vo.setHoId(id);
		
		vo.setCommentContent(vo.getCommentContent().replaceAll("<", "&lt;"));
		vo.setCommentContent(vo.getCommentContent().replaceAll(">", "&gt;"));
		
		if(cservice.complainCommentInsert(vo)>0) {
			mv.addObject("success", "성공");
		}else {
			mv.addObject("message", "실패");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 고객의소리 댓글 삭제
	@RequestMapping(value = "/commentDelete")
	public ModelAndView commentDelete(ModelAndView mv, ComplainCommentVO vo) {
		
		if (cservice.deleteComplainComment(vo)>0) {
			mv.addObject("success", "성공");
		}else {
			mv.addObject("message", "실패");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	/* ============================={ 이벤트 페이지 }================================ */
	// 이벤트 게시판 글 등록
	@RequestMapping(value ="/eventInsert")
	public ModelAndView eventInsert (HttpServletRequest request, ModelAndView mv ,EventBoardVO vo) {	
		String id = (String) request.getSession().getAttribute("loginID");
		vo.setHoId(id);
		System.out.println(vo.getHoId());
		vo.setStartDate(vo.getStartDate().replaceAll("/", ""));
		vo.setEndDate(vo.getEndDate().replaceAll("/", ""));		
		if(service.eventInsert(vo)>0) {
			mv.addObject("success", "성공");
		}else {
			mv.addObject("message", "실패");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 이벤트 게시판 글 등록 폼이동
	@RequestMapping(value = "/eventInsertf")
	public ModelAndView eventInsertf(ModelAndView mv, EventBoardVO vo) {
	
		mv.setViewName("headoffice/eventBoardInsert");
		return mv;
	}
	
	// 이벤트 게시판 이동
	@RequestMapping(value = "eventBoardf")
	public ModelAndView eventBoardf(ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
		cri.setSnoEno();
		
		
		List<EventBoardVO> searchList = service.searchEventBoard(cri);
		if (searchList != null && searchList.size() > 0) {

			mv.addObject("eventList", searchList);
		} else {
			mv.addObject("message", "출력할 자료가 없습니다.");
		}
		pageMaker.setCri(cri);
		pageMaker.setTotalRowCount(service.searchEventBoardRows(cri));

		mv.setViewName("headoffice/eventBoard");
		return mv;
	}
	
	// 이벤트 게시판 디테일
	@RequestMapping(value ="/eventBoardDetail")
	public ModelAndView eventBoardDetail(ModelAndView mv, EventBoardVO vo) {					
		vo = service.selectDetailEventBoard(vo);
		System.out.println("** eventBoardDetail => "+vo);
		if(vo!=null) {
			mv.addObject("eventBoardDetail", vo);
		}else {
			mv.addObject("message", "출력할 글이 없습니다.");
		}
		mv.setViewName("headoffice/eventBoardDetail");
		return mv;
	}	
	
	// 이벤트 게시판 글 수정 폼이동
	@RequestMapping(value = "/eventUpdatef")
	public ModelAndView eventUpdatef(ModelAndView mv, EventBoardVO vo) {
		vo = service.selectDetailEventBoard(vo);
		if (vo != null) {
			mv.addObject("eventDetail", vo);
		} else {
			mv.addObject("message", "출력할 글이 없습니다.");
		}
		mv.setViewName("headoffice/eventBoardUpdate");
		return mv;
	}
	
	// 이벤트 게시판 글 수정(수정자 ID로 작성자 변경됨)
	@RequestMapping(value ="/eventUpdate")
	public ModelAndView eventUpdate (HttpServletRequest request, ModelAndView mv ,EventBoardVO vo) {	
		String id = (String) request.getSession().getAttribute("loginID");
		vo.setHoId(id);
		if(service.eventUpdate(vo)>0) {
			mv.addObject("success", "성공");
		}else {
			mv.addObject("message", "실패");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	
	
	
	// 이벤트 게시판 글 삭제
	@RequestMapping(value = "/eventDelete")
	public ModelAndView eventDelete(ModelAndView mv, EventBoardVO vo) {
		
		if (service.eventDelete(vo)>0) {
			mv.addObject("success", "성공");
		}else {
			mv.addObject("message", "실패");
		}
		mv.setViewName("jsonView");
		return mv;
	}
	
}
// class