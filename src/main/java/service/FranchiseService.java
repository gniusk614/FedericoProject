package service;

import java.util.List;
import java.util.Map;

import vo.ChartVO;
import vo.FcClientRegVO;
import vo.FcOrderVO;
import vo.FranchiseVO;

public interface FranchiseService {

	int fcPwUpdate(FranchiseVO vo); //프랜차이즈 비밀번호 변경
	
	ChartVO fcLastMonthSales(String fcId); //가맹점 전월 매출
	
	List<ChartVO> selectFCStatsAnnualSales(Map<String, Object> params); //연간 판매량(월별, 지점별)
	
	List<ChartVO> selectFCStatsMenuSales(Map<String, Object> params); //메뉴별 판매량(월별, 지점별)
	
	List<ChartVO> selectFCStatsTimeSales(Map<String, Object> params); // 시간대별 매출
	
	List<ChartVO> selectFcStatsMonthlySales(Map<String, Object> params); // 특정 월의 일자별 매출
	
	int selectFcClientRowsCount(Map<String, Object> params); //가맹점 단골고객 조회 rowsCount
	
	List<FcClientRegVO> selectFcClientAll(Map<String, Object> params); //가맹점 단골고객 조회 All
	
	int deleteFcClientReg(FcClientRegVO vo); //가맹점 단골고객 삭제
	
	int updateFcClientReg(FcClientRegVO vo); //가맹점 단골고객 수정
	
	FcClientRegVO selectFcClientOne(FcClientRegVO vo); // 가맹점 단골고객 조회 - One
	
	int insertFcClient(FcClientRegVO vo); //가맹점 단골고객등록
	
	List<ChartVO> fcLastSevenDaysSalesPerDay(String fcId); //가맹점 오늘포함 이전 7일간 일별 매출
	
	ChartVO fcYesterdaySales(String fcId); //가맹점 전일 매출
	
	ChartVO fcThisMonthSales(String fcId); //가맹점 당월 매출
	
	ChartVO fcTodaySales(String fcId); //가맹점 당일 매출
	
	ChartVO fcThisMonthOrderSum(String fcId); //가맹점 당월 발주금액
	
	int searchItemOrderListRows(Map<String, Object> params); // 가맹점 발주내역 Rows
	
	List<FcOrderVO> searchItemOrderListFc(Map<String, Object> params); // 가맹점 발주내역 조회
	
	String selectDeliveryTimebyFcId(String fcId);  // 배송소요시간 select
	
	int updateDeliveryTime(FranchiseVO vo); //배송소요시간 update
	
	List<FranchiseVO> selectListbyArea(String area); //지역 가맹점 찾기. 
	
	
	
	List<FranchiseVO> selectListbyMinorAddress(String minor); // 서울(major) 강남구(minor)
	
	List<FranchiseVO> selectFc(); //가맹점정보 모두 불러오기
	
	FranchiseVO selectFcOne(FranchiseVO vo); //특정 가맹점정보 불러오기
	
	int fcUpdate(FranchiseVO vo); //프랜차이즈 정보 업데이트
	
	int fcClose(FranchiseVO vo); //프랜차이즈 폐점,오픈처리
	
	int fcInsert(FranchiseVO vo); //프랜차이즈 계정생성
	
	
	
}
