package mapperInterface;

import java.util.List;

import vo.MenuVO;

public interface MenuMapper {
	
	
	List<MenuVO> selectMenuListbyFlag(MenuVO vo); //selectMenuListbyFlag
	List<MenuVO> selectMenuList(); //selectList
	MenuVO selectMenuOne(MenuVO vo); //selectOne
	int menuInsert(MenuVO vo); //insert
	int menuUpdate(MenuVO vo); //update
	int menuDelete(MenuVO vo); //delete
	int menuLive(MenuVO vo);
	int menuDie(MenuVO vo);
}
