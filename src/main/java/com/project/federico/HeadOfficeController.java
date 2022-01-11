package com.project.federico;

import java.io.IOException;
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
import service.HeadOfficeService;
import vo.HeadOfficeVO;
import vo.StaffVO;


@RequestMapping(value = "/headoffice")
@Log4j
@Controller
public class HeadOfficeController {
	
	@Autowired
	HeadOfficeService service;
	@Autowired
	PasswordEncoder passwordEncoder;
	
	
	@RequestMapping(value = "/loginf") //로그인폼이동 (강광훈)
	public ModelAndView loginf(ModelAndView mv) {
		mv.setViewName("headoffice/loginForm");
		return mv;
	}//loginf-> 폼으로 이동시켜줌 
	
	
	@RequestMapping(value = "/login") // 로그인(강광훈)
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, ModelAndView mv,
			HeadOfficeVO headOfficeVo, StaffVO staffVo)
			throws ServletException, IOException {	
		
		//정보 저장
		String staffCode = staffVo.getStaffCode();
		String password = headOfficeVo.getHoPassword();
		String uri = "/headoffice/loginForm";
		
		//로그인서비스처리
		staffVo = service.selectOne(staffVo);
		
		if (staffVo != null) {
			headOfficeVo.setStaffVo(staffVo);
			headOfficeVo = service.loginSelectOne(headOfficeVo);
		

			//정보 확인
			if(headOfficeVo != null) { // ID는 일치 -> Password 확인
//				if (passwordEncoder.matches(password, HeadOfficeVo.getHoPassword())) { => 암호화 구현 전이라 블럭
				if (headOfficeVo.getHoPassword().equals(password)) {	
					
					headOfficeVo.setStaffVo(staffVo);//굳이 이걸왜 한번 더 해야하는지모르겠는데 이거해야 밑에 널포인트 안뜸 ...
					// 로그인 성공 -> 로그인 정보 session에 보관, home
					request.getSession().setAttribute("loginID", headOfficeVo.getStaffVo().getStaffCode());
					request.getSession().setAttribute("loginName", headOfficeVo.getStaffVo().getStaffName());
					request.getSession().setAttribute("loginPW", password);
					uri = "redirect:headofficeMain";
				}else {
					mv.addObject("message", "Password가 일치하지않습니다.");
				}
			}else {
				mv.addObject("message", "회원정보가 없습니다. ID를 확인해주세요.");
			}//if
		}else {
			mv.addObject("message", "회원정보가 없습니다. ID를 확인해주세요.");
		}//if(staffVo null)
		
			mv.setViewName(uri);

		return mv;
	}//login
	
	@RequestMapping(value = "/logout")// 로그아웃 (강광훈)
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

	
	@RequestMapping(value = "/passwordReset") //비번변경폼이동 (강광훈)
	public ModelAndView passwordReset(ModelAndView mv) {
		mv.setViewName("headoffice/passwordResetForm");
		return mv;
	}//loginf-> 폼으로 이동시켜줌 
	
	
	@RequestMapping(value = "/memberList")
	public ModelAndView memberList(ModelAndView mv, HeadOfficeVO headvo, StaffVO staffvo) {
		
		
		List<StaffVO> list = service.selectMList(staffvo);
		
		
		if (list != null)
			mv.addObject("memberList", list);
		else
			mv.addObject("message", "출력할 자료가 없습니다.");
		
		mv.setViewName("headoffice/headofficeMemberList");
		return mv;
	}
	
	
	
	
	


}//class
