package mapperInterface;

import java.util.List;

import vo.FranchiseVO;
import vo.HeadOfficeVO;

import vo.ItemInfoVO;
import vo.StaffVO;

public interface FranchiseMapper {
	
	List<FranchiseVO> selectFc(); //가맹점정보 모두 불러오기
	
	FranchiseVO selectFcOne(FranchiseVO vo); //특정 가맹점정보 불러오기

}
