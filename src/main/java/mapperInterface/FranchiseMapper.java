package mapperInterface;

import java.util.List;
import java.util.Map;

import vo.ChartVO;
import vo.FcOrderVO;
import vo.FranchiseVO;

public interface FranchiseMapper {
	
	ChartVO fcYesterdaySales(String fcId); //가맹점 전일 매출
	
	ChartVO fcThisMonthSales(String fcId); //가맹점 당월 매출
	
	ChartVO fcTodaySales(String fcId); //가맹점 당일 매출
	
	ChartVO fcThisMonthOrderSum(String fcId); //가맹점 당월 발주금액
	
	int searchItemOrderListRows(Map<String, Object> params); // 가맹점 발주내역 Rows
	
	List<FcOrderVO> searchItemOrderListFc(Map<String, Object> params); // 가맹점 발주내역 조회
	
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
