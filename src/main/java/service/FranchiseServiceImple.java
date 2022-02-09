package service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.FranchiseMapper;
import vo.ChartVO;
import vo.FcClientRegVO;
import vo.FcOrderVO;
import vo.FranchiseVO;

@Service
public class FranchiseServiceImple implements FranchiseService {

	@Autowired
	FranchiseMapper dao;

	//프랜차이즈 비밀번호 변경
	@Override
	public int fcPwUpdate(FranchiseVO vo) {
		return dao.fcPwUpdate(vo);
	}
	
	//가맹점 전월 매출
	@Override
	public ChartVO fcLastMonthSales(String fcId) {
		return dao.fcLastMonthSales(fcId);
	}
	
	//연간 판매량(월별, 지점별)
	@Override
	public List<ChartVO> selectFCStatsAnnualSales(Map<String, Object> params) {
		return dao.selectFCStatsAnnualSales(params);
	}
	
	//메뉴별 판매량(월별, 지점별)
	@Override
	public List<ChartVO> selectFCStatsMenuSales(Map<String, Object> params) {
		return dao.selectFCStatsMenuSales(params);
	}
	
	// 시간대별 매출
	@Override
	public List<ChartVO> selectFCStatsTimeSales(Map<String, Object> params) {
		return dao.selectFCStatsTimeSales(params);
	}
	
	// 특정 월의 일자별 매출
	@Override
	public List<ChartVO> selectFcStatsMonthlySales(Map<String, Object> params) {
		return dao.selectFcStatsMonthlySales(params);
	}
	
	//가맹점 단골고객 조회 rowsCount
	@Override
	public int selectFcClientRowsCount(Map<String, Object> params) {
		return dao.selectFcClientRowsCount(params);
	}
	
	//가맹점 단골고객 조회 All
	@Override
	public List<FcClientRegVO> selectFcClientAll(Map<String, Object> params) {
		return dao.selectFcClientAll(params);
	}
	
	//가맹점 단골고객 삭제
	@Override
	public int deleteFcClientReg(FcClientRegVO vo) {
		return dao.deleteFcClientReg(vo);
	}
	
	//가맹점 단골고객 수정
	@Override
	public int updateFcClientReg(FcClientRegVO vo) {
		return dao.updateFcClientReg(vo);
	}
	
	// 가맹점 단골고객 조회 - One
	@Override
	public FcClientRegVO selectFcClientOne(FcClientRegVO vo) {
		return dao.selectFcClientOne(vo);
	}
	
	//가맹점 단골고객등록
	@Override
	public int insertFcClient(FcClientRegVO vo) {
		return dao.insertFcClient(vo);
	}
	
	//가맹점 오늘포함 이전 7일간 일별 매출
	@Override
	public List<ChartVO> fcLastSevenDaysSalesPerDay(String fcId) {
		return dao.fcLastSevenDaysSalesPerDay(fcId);
	}
	
	//가맹점 전일 매출
	@Override
	public ChartVO fcYesterdaySales(String fcId) {
		return dao.fcYesterdaySales(fcId);
	}
	
	//가맹점 당월 매출
	@Override
	public ChartVO fcThisMonthSales(String fcId) {
		return dao.fcThisMonthSales(fcId);
	}
	
	//가맹점 당일 매출
	@Override
	public ChartVO fcTodaySales(String fcId) {
		return dao.fcTodaySales(fcId);
	}
	
	//가맹점 당월 발주금액
	@Override
	public ChartVO fcThisMonthOrderSum(String fcId) {
		return dao.fcThisMonthOrderSum(fcId);
	}
	
	// 가맹점 발주내역 Rows
	@Override
	public int searchItemOrderListRows(Map<String, Object> params) {
		return dao.searchItemOrderListRows(params);
	}
	
	// 가맹점 발주내역 조회
	@Override
	public List<FcOrderVO> searchItemOrderListFc(Map<String, Object> params) {
		return dao.searchItemOrderListFc(params);
	}
	
	// 배송소요시간 select
	@Override
	public String selectDeliveryTimebyFcId(String fcId) {
		return dao.selectDeliveryTimebyFcId(fcId);
	}
	
	//배송소요시간 update
	@Override
	public int updateDeliveryTime(FranchiseVO vo) {
		return dao.updateDeliveryTime(vo);
	}
	
	
	//지역 가맹점 찾기. 
	@Override
	public List<FranchiseVO> selectListbyArea(String area) {
		return dao.selectListbyArea(area);
	}
	
	// 가맹점정보 모두 불러오기
	@Override
	public List<FranchiseVO> selectFc() {
		return dao.selectFc();
	}

	// 특정 가맹점정보 불러오기
	@Override
	public FranchiseVO selectFcOne(FranchiseVO vo) {
		return dao.selectFcOne(vo);
	}

	// 프랜차이즈 정보 업데이트
	@Override
	public int fcUpdate(FranchiseVO vo) {
		return dao.fcUpdate(vo);
	}

	//프랜차이즈 폐점,오픈처리
	@Override
	public int fcClose(FranchiseVO vo) {
		return dao.fcClose(vo);
	}
	
	// 프랜차이즈 계정생성
	@Override
	public int fcInsert(FranchiseVO vo) {
		return dao.fcInsert(vo);
	}
	
	// 프랜차이즈 지도위치 표시
	@Override
	public List<FranchiseVO> selectFcAddress(Map<String, Object> params) {
		return dao.selectFcAddress(params);
	}
	
	// 프랜차이즈 지도 주소기준표시
	@Override
	public List<FranchiseVO> selectFcLocation(String fcAddress_keyword){
		return dao.selectFcLocation(fcAddress_keyword);
	}
	
	// 프랜차이즈 지도 주소전체검색
	@Override
	public List<FranchiseVO> selectFcAllAddress(FranchiseVO vo){
		return dao.selectFcAllAddress(vo);
	}
}
