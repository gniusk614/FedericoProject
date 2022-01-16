package service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import mapperInterface.HeadOfficeMapper;
import paging.SearchCriteria;
import vo.FcOrderDetailVO;
import vo.FcOrderVO;
import vo.HeadOfficeVO;
import vo.ItemInfoVO;
import vo.StaffVO;

@Log4j
@Service
public class HeadOfficeServiceImpl implements HeadOfficeService {

	@Autowired
	HeadOfficeMapper dao;

	// 가맹점 발주내역 처리완료로 변경
	@Override
	public int fcOrderSeqUpdate(Map<String, Object> param) {
		return dao.fcOrderSeqUpdate(param);
	}
	
	
	// 가맹점 발주내역 상세보기(발주번호 별로)
	@Override
	public List<FcOrderDetailVO> selectFcOrderDetailbyOrderNumber(FcOrderDetailVO vo) {
		
		return dao.selectFcOrderDetailbyOrderNumber(vo);
	}
	
	// 가맹점발주정보 전체조회
	@Override
	public List<FcOrderVO> selectFcOrder(String flag) {
		return dao.selectFcOrder(flag);
	}
	

	// 사원정보리스트
	@Override
	public List<StaffVO> selectMList(StaffVO vo) {
		return dao.selectMList(vo);
	}

	// 자재정보 삭제
	@Override
	public int itemdelete(ItemInfoVO vo) {
		return dao.itemdelete(vo);
	}

	// 자재정보 수정
	@Override
	public int itemUpdate(ItemInfoVO vo) {
		return dao.itemUpdate(vo);
	}

	// 자재정보 1건 출력
	@Override
	public ItemInfoVO selectOneItem(ItemInfoVO vo) {
		return dao.selectOneItem(vo);
	}

	// 자재정보 Search
	@Override
	public List<ItemInfoVO> searchItemList(SearchCriteria cri) {
		return dao.searchItemList(cri);
	}
	
	// 자재정보 Search 결과 Rows 조회
	@Override
	public int searchItemRows(SearchCriteria cri) {
		return dao.searchItemRows(cri);
	}
	
	
	
	// 자재정보 모두출력
	@Override
	public List<ItemInfoVO> selectAllItem() {
		return dao.selectAllItem();
	}

	// 본사: 자재입력기능 (강현구)
	@Override
	public int iteminsert(ItemInfoVO vo) {
		return dao.iteminsert(vo);
	}

	// Login 시 사용
	@Override
	public HeadOfficeVO loginSelectOne(HeadOfficeVO vo) {
		return dao.loginSelectOne(vo);
	}

	// LoginSelectOne에 정보 보낼때 사용, 스탭정보 가져올때 사용
	@Override
	public StaffVO selectOne(StaffVO vo) {
		return dao.selectOne(vo);
	}

	// Staff 계정생성
	@Override
	public int staffInsert(StaffVO vo) {
		return dao.staffInsert(vo);
	}

	// Staff 정보수정
	@Override
	public int staffUpdate(StaffVO vo) {
		return dao.staffUpdate(vo);
	}
	// Staff 정보삭제
	@Override
	public int staffDelete(StaffVO vo) {
		return dao.staffDelete(vo);
	}
	
	// HeadOffice Id, password 생성
	@Override
	public int headOfficeInsert(HeadOfficeVO vo) {
		return dao.headOfficeInsert(vo);
	}
	
	// HeadOffice 계정 삭제
	@Override
	public int headOfficeDelete(HeadOfficeVO vo) {
		return dao.headOfficeDelete(vo);
	}
	
	@Override
	public int headOfficePwUpdate(HeadOfficeVO vo) {
		
		return dao.headOfficePwUpdate(vo);
	}

}
