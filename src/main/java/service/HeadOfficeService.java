package service;

import java.util.List;
import java.util.Map;

import paging.SearchCriteria;
import vo.ChartVO;
import vo.EventBoardVO;
import vo.FcOrderDetailVO;
import vo.FcOrderVO;
import vo.FranchiseVO;
import vo.HeadOfficeVO;
import vo.ItemInfoVO;
import vo.NoticeBoardVO;
import vo.StaffVO;

public interface HeadOfficeService {

	ChartVO selectNumberOfFranchise(String s); // 가맹점 개설현황 - 매개변수로 where 조건
	
	List<FcOrderVO> selectFcOrderSumPirce(); // 본사 홈에 띄울 가맹점 미처리 자재발주

	int insertFcOrderDetail(List<FcOrderDetailVO> vo); //가맹점 자재발주 상세내역 등록
	
	int insertFcOrder(FcOrderVO vo); // 가맹점 발주 등록
	
	List<ItemInfoVO> selectItembyFlag(ItemInfoVO vo); // 분류로 자재 조회
	
	int fcOrderSeqUpdate(Map<String, Object> params); // 가맹점 발주내역 처리완료로 변경
	
	List<FcOrderDetailVO> selectFcOrderDetailbyOrderNumber(FcOrderDetailVO vo);  // 가맹점 발주내역 상세보기(발주번호 별로)
	
	List<FcOrderVO> selectFcOrder(String flag); // 가맹점발주정보 전체조회
	
	List<FcOrderVO> searchFcOrder(Map<String, Object> params); // 가맹점발주정보 조회,서치,페이징
	
	int searchFcOrderRows(Map<String, Object> params); // 가맹점발주정보 Search 결과 Rows 조회
	
	int itemdelete(ItemInfoVO vo); // 자재정보 삭제

	int itemUpdate(ItemInfoVO vo); // 자재정보 수정

	ItemInfoVO selectOneItem(ItemInfoVO vo); // 자재정보 1건 출력

	List<ItemInfoVO> searchItemList(SearchCriteria cri); // 자재정보 Search
	
	int searchItemRows(SearchCriteria cri); // 자재정보 Search 결과 Rows 조회
	
	List<ItemInfoVO> selectAllItem(); // 자재정보 모두출력

	List<StaffVO> selectMList(StaffVO vo); // 사원정보 리스트

	int iteminsert(ItemInfoVO vo); // 자재정보 입력

	HeadOfficeVO loginSelectOne(HeadOfficeVO vo); // 로그인시 id로 selectOne

	StaffVO selectOne(StaffVO vo); // staffVO selectOne

	int staffInsert(StaffVO vo); // 스탭 계정생성
	
	int staffUpdate(StaffVO vo); //스탭 정보수정
	
	int staffDelete(StaffVO vo); //스탭 정보삭제

	int headOfficeDelete(HeadOfficeVO vo); // ID, Password 삭제

	int headOfficeInsert(HeadOfficeVO vo); // ID, Password 생성
	
	int headOfficePwUpdate(HeadOfficeVO vo); // password 변경
	
	List<StaffVO> searchStaffList(SearchCriteria cri); // 스탭정보 Search

	int searchStaffRows(SearchCriteria cri); // 스탭정보 Search 결과 Rows 조회
	
	List<FranchiseVO> searchFcList(SearchCriteria cri); // 가맹점정보 Search
	
	int searchFcRows(SearchCriteria cri); // 가맹점정보 Search 결과 Rows 조회
	
	int noticeInsert(NoticeBoardVO vo); //공지사항 등록
	int noticeUpdate(NoticeBoardVO vo); //공지사항 수정
	int noticeDelete(NoticeBoardVO vo); //공지사항 삭제

	List<ChartVO> monthChart();//월별통계
	
	List<ChartVO> dayChart(); //요일별통계


	int eventInsert(EventBoardVO vo); // 이벤트 게시판 등록
	int eventUpdate(EventBoardVO vo); // 이벤트 게시판 수정
	int eventDelete(EventBoardVO vo); // 이벤트 게시판 삭제
	static EventBoardVO selectDetailEventBoard(EventBoardVO vo) {
		return vo;
	} // 이벤트 게시판 디테일
	

	
	
	
	
}
