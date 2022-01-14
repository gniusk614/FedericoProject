package com.project.federico;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

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
import service.FranchiseService;
import service.HeadOfficeService;
import vo.FcOrderDetailVO;
import vo.FcOrderVO;
import vo.FranchiseVO;
import vo.HeadOfficeVO;
import vo.ItemInfoVO;
import vo.StaffVO;

@RequestMapping(value = "/headoffice")
@Log4j
@Controller
public class HeadOfficeController {

	@Autowired
	FranchiseService fcService;
	@Autowired
	HeadOfficeService service;
	@Autowired
	PasswordEncoder passwordEncoder;


	
	// 가맹점 발주내역 상세보기(발주번호 별로) return json
	@RequestMapping(value = "/fcorderdetail")
	public ModelAndView fcorderdetail(ModelAndView mv, FcOrderDetailVO vo, ItemInfoVO ivo){
		List<FcOrderDetailVO> list = service.selectFcOrderDetailbyOrderNumber(vo);
		
		int i=0;
		for (FcOrderDetailVO dvo:list) {
			ivo.setItemIndex(dvo.getItemIndex());
			dvo.setItemInfoVO(service.selectOneItem(ivo));
			list.set(i, dvo);
			i++;
		}
		
		if(list.size() > 0) {
			mv.addObject("list",list);
		} else {
			mv.addObject("message","조회할 자료가 없습니다.");
		}
		
		mv.setViewName("jsonView");
		return mv;
	}
	
	
	
	// 발주내역조회 + 폼 이동(강현구) 
	// 요청에 쿼리스트링으로 구분
	// flag = Y -> 처리완료
	// flag = N -> 미러치
	// 쿼리스트링X -> 전체조회(미구현)
	@RequestMapping(value = "/fcorder")
	public ModelAndView fcorder(ModelAndView mv, FcOrderVO vo, FcOrderDetailVO detailVo, FranchiseVO fcVo, @RequestParam("flag") String flag) {
		
		String uri="headoffice/headofficeMain";
		if("Y".equals(flag)) uri = "headoffice/fcOrderY";
		else if("N".equals(flag)) uri = "headoffice/fcOrderN";
		
		List<FcOrderVO> list = service.selectFcOrder(flag);
		
		if(list != null && list.size()>0) {
			mv.addObject("list",list);
		} else {
			mv.addObject("message", "조회할 자료가 없습니다.");
		}
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

	// 본사: 자재리스트 가져오기 + 자재조회폼 이동 (강현구)
	@RequestMapping(value = "/itemselect")
	public ModelAndView iteminsertf(ModelAndView mv) {

		List<ItemInfoVO> list = new ArrayList<ItemInfoVO>();
		list = service.selectAllItem();

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.setViewName("headoffice/itemselectf");
		} else {
			mv.setViewName("haedoffice/headofficeMain");
		}

		return mv;
	}

	// 로그인폼이동 (강광훈)
	@RequestMapping(value = "/loginf")
	public ModelAndView loginf(ModelAndView mv) {
		mv.setViewName("headoffice/loginForm");
		return mv;
	}// loginf-> 폼으로 이동시켜줌

	// 로그인(강광훈)
	@RequestMapping(value = "/login")
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, ModelAndView mv,
			HeadOfficeVO headOfficeVo, StaffVO staffVo) throws ServletException, IOException {

		// 정보 저장
		String staffCode = staffVo.getStaffCode();
		String password = headOfficeVo.getHoPassword();
		String uri = "/headoffice/loginForm";

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
					// 로그인 성공 -> 로그인 정보 session에 보관, home
					request.getSession().setAttribute("loginID", headOfficeVo.getStaffVo().getStaffCode());
					request.getSession().setAttribute("loginName", headOfficeVo.getStaffVo().getStaffName());
					uri = "redirect:headofficeMain";
				} else {
					mv.addObject("message", "Password가 일치하지않습니다.");
				}
			} else {
				mv.addObject("message", "회원정보가 없습니다. ID를 확인해주세요.");
			} // if
		} else {
			mv.addObject("message", "회원정보가 없습니다. ID를 확인해주세요.");
		} // if(staffVo null)

		mv.setViewName(uri);

		return mv;
	}// login

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
	public ModelAndView staffList(ModelAndView mv, HeadOfficeVO headvo, StaffVO staffvo) {

		List<StaffVO> list = service.selectMList(staffvo);

		if (list != null)
			mv.addObject("staffList", list);
		else
			mv.addObject("message", "출력할 자료가 없습니다.");

		mv.setViewName("headoffice/headofficeStaffList");
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
		if (service.headOfficeDelete(hvo) >0){
			if (service.staffDelete(svo)> 0) {
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
	public ModelAndView staffDetail( HttpServletRequest request, ModelAndView mv, StaffVO svo, HeadOfficeVO hvo) {
		String id = (String) request.getSession().getAttribute("loginID");
		String password = (String) request.getSession().getAttribute("loginPW");
		
		svo.setStaffCode(id);

		svo = service.selectOne(svo);

		hvo.setStaffVo(svo);
		
		hvo = service.loginSelectOne(hvo);
		
		
		if (hvo != null)
			{hvo.setHoPassword(password);
			hvo.setStaffVo(svo);
			mv.addObject("staffMyInfo", hvo); // MyBatis 에선 null , size()>0 으로 확인
		}else mv.addObject("message", "정보가 없습니다.");
		
			mv.setViewName("headoffice/headofficeStaffMyInfo");

		return mv;
	}// staffDetail
	
	
	// ** 비번변경시 현재비번확인
	@RequestMapping(value = "/staffloginPwCheck")
	public ModelAndView staffloginPwCheck( HttpServletRequest request, ModelAndView mv, HeadOfficeVO hvo, StaffVO svo) {
		String hoid = (String) request.getSession().getAttribute("loginID");
		
		String inputPw = hvo.getHoPassword();
		svo.setStaffCode(hoid);
		
		hvo.setStaffVo(service.selectOne(svo));
		hvo = service.loginSelectOne(hvo);
		
		if(passwordEncoder.matches(inputPw, hvo.getHoPassword())) {
			mv.addObject("success", "success");
		}else {
			mv.addObject("success", "fail");
		}

		mv.setViewName("jsonView");

		return mv;
	}// staffDetail
	
	
	//  ** 비번 변경
	@RequestMapping(value = "/headOfficePwUpdate")
	public ModelAndView headOfficePwUpdate( HttpServletRequest request, ModelAndView mv, HeadOfficeVO hvo, StaffVO svo) {
		String hoid = (String) request.getSession().getAttribute("loginID");
		String inputPw = hvo.getHoPassword();
		svo.setStaffCode(hoid);
		
		hvo.setStaffVo(service.selectOne(svo));
		hvo = service.loginSelectOne(hvo);
		hvo.setStaffVo(service.selectOne(svo));
		hvo.setHoPassword(passwordEncoder.encode(inputPw));
		
		if(service.headOfficePwUpdate(hvo)>0) {
			mv.addObject("success", "success");
		}else {
			mv.addObject("success", "fail");
		}

		mv.setViewName("jsonView");

		return mv;
	}// staffDetail
	
	
	

}
// class