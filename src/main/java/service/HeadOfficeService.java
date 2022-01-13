package service;

import java.util.List;

import vo.FcOrderDetailVO;
import vo.FcOrderVO;
import vo.HeadOfficeVO;
import vo.ItemInfoVO;
import vo.StaffVO;

public interface HeadOfficeService {

	List<FcOrderDetailVO> selectFcOrderDetailbyOrderNumber(FcOrderDetailVO vo);  // 가맹점 발주내역 상세보기(발주번호 별로)
	
	List<FcOrderVO> selectFcOrder(String flag); // 가맹점발주정보 전체조회
	
	int itemdelete(ItemInfoVO vo); // 자재정보 삭제

	int itemUpdate(ItemInfoVO vo); // 자재정보 수정

	ItemInfoVO selectOneItem(ItemInfoVO vo); // 자재정보 1건 출력

	List<ItemInfoVO> selectAllItem(); // 자재정보 모두출력

	List<StaffVO> selectMList(StaffVO vo); // 사원정보 리스트

	int iteminsert(ItemInfoVO vo); // 자재정보 입력

	HeadOfficeVO loginSelectOne(HeadOfficeVO vo); // 로그인시 id로 selectOne

	StaffVO selectOne(StaffVO vo); // staffVO selectOne

	int staffInsert(StaffVO vo); // 스탭 계정생성

	int headOfficeInsert(HeadOfficeVO vo); // ID, Password 생성

}
