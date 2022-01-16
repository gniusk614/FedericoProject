package com.project.federico;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.extern.log4j.Log4j;
import paging.PageMaker;
import paging.SearchCriteria;
import service.FranchiseService;
import service.HeadOfficeService;
import service.MenuService;
import vo.FcOrderDetailVO;
import vo.FcOrderVO;
import vo.FranchiseVO;
import vo.HeadOfficeVO;
import vo.ItemInfoVO;
import vo.MenuVO;
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

	@Autowired
	MenuService menuService;



	
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
	
	// 가맹점 발주내역 처리완료로 변경
	@RequestMapping(value = "/fcordersequpdate")
	public ModelAndView fcOrderSeqUpdate(ModelAndView mv, FcOrderVO vo, @RequestParam("flag") String flag) {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("flag", flag);
		param.put("vo", vo);
		
		if(service.fcOrderSeqUpdate(param) > 0) {
			mv.addObject("success","success");
		} else {
			mv.addObject("success","fail");
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
		
		if(service.fcOrderSeqUpdate(param) > 0) {
			mv.addObject("success","success");
		} else {
			mv.addObject("success","fail");
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

	// 본사: 자재리스트 가져오기 + 자재조회폼 이동 (강현구) - 페이징 진행중
	@RequestMapping(value = "/itemselect")
	public ModelAndView iteminsertf(ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {
		
		cri.setSnoEno();
		
		List<ItemInfoVO> list = service.searchItemList(cri);

		if (list != null && list.size() > 0) {
			mv.addObject("list", list);
			mv.setViewName("headoffice/itemselectf");
		} else {
			mv.setViewName("haedoffice/headofficeMain");
		}
		pageMaker.setCri(cri);
		pageMaker.setTotalRowCount(service.searchItemRows(cri));
		
		

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
	

	//============================Menu=======================
	@RequestMapping(value = "/menuList")
	public ModelAndView menuList(ModelAndView mv,MenuVO vo) {
		
		List<MenuVO> list = menuService.selectMenuList();
		if(list != null) {
			mv.addObject("menuList",list);
		} else {
			mv.addObject("message","출력자료 없음.");
		}
		mv.setViewName("headoffice/menuList");
		return mv;
	}
	
	@RequestMapping(value = "/menuRegistration") // 메뉴등록 양식으로 이동(김민석_22.01.13)
	public ModelAndView menuRegistrationf(HttpServletRequest request, ModelAndView mv, MenuVO vo) 
		 	 throws IOException {
		
		//******** FileUpload 기능 *******
		// 현재 웹 어플리케이션의 실행 위치 확인.
		String realPath = request.getRealPath("/"); // Wabapp까지의 경로.
		System.out.println("** realPath => "+realPath);
		
		// 저장공간 확인.
		if(realPath.contains(".eclipse."))
			realPath="C:\\Users\\19467\\eclipse-workspace\\Spring02\\src\\main\\webapp\\resources\\uploadImage";
		else realPath += "resources\\Image\\"; 
		
		// 폴더만들기. (file 클래스 활용)
		File f1 = new File(realPath);
				
		if ( !f1.exists() ) f1.mkdir();
				
		// ** 기본 이미지 지정하기 
		String file1, file2="resources/uploadImage/basicman1.jpg";
		
		// ** MultipartFile
		// => 업로드한 파일에 대한 모든 정보를 가지고 있으며 이의 처리를 위한 메서드를 제공한다.
		//    -> String getOriginalFilename(), 
		//    -> void transferTo(File destFile),
		//    -> boolean isEmpty()
		
		MultipartFile uploadfilef = vo.getMenuUploadfilef();
		if ( uploadfilef !=null && !uploadfilef.isEmpty() ) {
			// Image 를 선택했음 -> Image 처리 (realPath+화일명)
			// 1) 물리적 위치에 Image 저장 
			file1=realPath + uploadfilef.getOriginalFilename(); //  전송된File명 추출 & 연결
			uploadfilef.transferTo(new File(file1)); // real 위치에 전송된 File 붙여넣기
			// 2) Table 저장위한 경로 
			file2 = "resources/uploadImage/"+ uploadfilef.getOriginalFilename();
		}
		vo.setMenuUploadfile(file2);
	
		// 2. Service 처리
		String uri = "/headoffice/menuList";  // 성공시 로그인폼으로
		
	      // *** Transaction Test 
	      // 1) Transaction 적용전 : 동일자료 2번 insert
	      //    => 첫번째는 입력완료 되고, 두번째 자료입력시 Key중복 오류발생
	      // 2) Transaction 적용후 : 동일자료 2번 insert
	      //    => 첫번째는 입력완료 되고, 두번째 자료입력시 Key중복 오류발생 하지만,
	      //       rollback 되어 둘다 입력 안됨
			
		
		if ( menuService.menuInsert(vo) > 0 ) {
			 // insert 성공
			 mv.addObject("message", "메뉴등록 성공");
		 }else { 
			 // insert 실패
			 mv.addObject("message", "메뉴등록 실패");
			 uri="member/joinForm";
		 }
		mv.setViewName(uri);
		return mv;
		
		
	}
	@RequestMapping(value = "/menuUpdate")
	public ModelAndView menuUpdate(ModelAndView mv,MenuVO vo) {
		
		if(menuService.menuUpdate(vo) > 0) {
			mv.addObject("success", "success");
		} else {
			mv.addObject("success", "fail");
		}
		mv.setViewName("jsonView"); 
		return mv;
		
	} //mupdate
	
	// ** Member Delete : 회원탈퇴
	// => member delete, session 무효화
	// => 삭제 성공 -> home,
	//    삭제 실패 -> memberDetail 
	

}
// class