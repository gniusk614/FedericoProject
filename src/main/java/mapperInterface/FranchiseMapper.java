package mapperInterface;

import java.util.List;

import vo.FranchiseVO;
import vo.HeadOfficeVO;

import vo.ItemInfoVO;
import vo.StaffVO;

public interface FranchiseMapper {
	
	String selectDeliveryTimebyFcId(String fcId);  // 배송소요시간 select
	
	int updateDeliveryTime(FranchiseVO vo); //배송소요시간 update
	 
	List<FranchiseVO> selectListbyArea(String area); //지역 가맹점 찾기. 
	
	// 서울(major or area) 강남구(minor)
	List<FranchiseVO> selectListbyMinorAddress(String minor); 
	
	List<FranchiseVO> selectFc(); //가맹점정보 모두 불러오기
	
	FranchiseVO selectFcOne(FranchiseVO vo); //특정 가맹점정보 불러오기

	int fcUpdate(FranchiseVO vo); //프랜차이즈 정보 업데이트
	int fcInsert(FranchiseVO vo); //프랜차이즈 계정생성
	int fcClose(FranchiseVO vo); ////프랜차이즈 폐점,오픈처리
	
	
}
