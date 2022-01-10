package mapperInterface;

import java.util.List;

import vo.HeadOfficeVO;
import vo.StaffVO;

public interface HeadOfficeMapper {

	List<StaffVO> selectMList(StaffVO vo); //사원정보 리스트
	
	HeadOfficeVO loginSelectOne(HeadOfficeVO vo); //로그인시 id로 selectOne
	StaffVO selectOne(StaffVO vo); //staffVO selectOne
	
	
	
}
