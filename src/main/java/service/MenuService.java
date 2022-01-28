package service;

import java.util.List;

import paging.SearchCriteria;
import vo.MenuVO;

public interface MenuService {	
	
	List<MenuVO> selectMenuListbyFlag(MenuVO vo); //selectMenuListbyFlag
	
	List<MenuVO> selectMenuList(); //selectList
	
	MenuVO selectMenuOne(MenuVO vo); //selectOne
	
	int menuInsert(MenuVO vo); //insert
	
	int menuUpdate(MenuVO vo); //update
	
	int menuDelete(MenuVO vo); //delete
	
	int menuLive(MenuVO vo); // Live
	
	int menuDie(MenuVO vo); // Live
	
	List<MenuVO> searchMenuList(SearchCriteria cri); // 자재정보 검색
	 
	int searchMenuRows(SearchCriteria cri); // 자재정보 search 결과 Rows 조회
	
	List<MenuVO> searchAllMenu();
}
	