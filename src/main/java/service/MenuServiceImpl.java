package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import mapperInterface.MenuMapper;
import vo.MenuVO;

@Log4j
@Service
public class MenuServiceImpl implements MenuService {
	
	@Autowired
	MenuMapper dao;	
	
	@Override
	public List<MenuVO> selectMenuListbyFlag(MenuVO vo) {
		return dao.selectMenuListbyFlag(vo);
	}
	@Override
	public List<MenuVO> selectMenuList(){
		return dao.selectMenuList();	
	}
	@Override
	public MenuVO selectMenuOne(MenuVO vo) {
		return dao.selectMenuOne(vo);
	} 
	@Override
	public int menuInsert(MenuVO vo) {
		return dao.menuInsert(vo);
	}
	@Override
	public int menuUpdate(MenuVO vo) {
		return dao.menuUpdate(vo);
	}
	@Override
	public int menuDelete(MenuVO vo) {
		return dao.menuDelete(vo);
	}
	@Override
	public int menuLive(MenuVO vo) {
		return dao.menuLive(vo);
	}
	@Override
	public int menuDie(MenuVO vo) {
		return dao.menuDie(vo);
	}
	
		
}
