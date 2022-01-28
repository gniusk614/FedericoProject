package service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.FranchiseMapper;
import vo.ChartVO;
import vo.FcOrderVO;
import vo.FranchiseVO;

@Service
public class FranchiseServiceImple implements FranchiseService {

	@Autowired
	FranchiseMapper dao;

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

}
