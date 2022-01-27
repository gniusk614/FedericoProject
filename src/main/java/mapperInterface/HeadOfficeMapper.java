package mapperInterface;

import java.util.List;
import java.util.Map;

import paging.SearchCriteria;
import vo.ChartVO;
import vo.FcOrderDetailVO;
import vo.FcOrderVO;
import vo.FranchiseVO;
import vo.HeadOfficeVO;
import vo.ItemInfoVO;
import vo.StaffVO;

public interface HeadOfficeMapper {

	int insertFcOrderDetail(List<FcOrderDetailVO> vo); //가맹점 자재발주 상세내역 등록
	
	int insertFcOrder(FcOrderVO vo); // 가맹점 발주 등록 
	
	List<ItemInfoVO> selectItembyFlag(ItemInfoVO vo); // 분류로 자재 조회
	
	int fcOrderSeqUpdate(Map<String, Object> param); // 가맹점 발주내역 처리완료로 변경

	List<FcOrderDetailVO> selectFcOrderDetailbyOrderNumber(FcOrderDetailVO vo); // 가맹점 발주내역 상세보기(발주번호 별로)

	List<FcOrderVO> selectFcOrder(String flag); // 가맹점발주정보 전체조회

	List<FcOrderVO> searchFcOrder(Map<String, Object> params); // 가맹점발주정보 조회,서치,페이징

	int searchFcOrderRows(Map<String, Object> params); // 가맹점발주정보 Search 결과 Rows 조회

	int itemdelete(ItemInfoVO vo); // 자재정보 삭제

	int itemUpdate(ItemInfoVO vo); // 자재정보 수정

	ItemInfoVO selectOneItem(ItemInfoVO vo); // 자재정보 1건출력

	List<ItemInfoVO> searchItemList(SearchCriteria cri); // 자재정보 Search

	int searchItemRows(SearchCriteria cri); // 자재정보 Search 결과 Rows 조회

	List<ItemInfoVO> selectAllItem(); // 자재정보 모두출력

	List<StaffVO> selectMList(StaffVO vo); // 사원정보 리스트

	int iteminsert(ItemInfoVO vo); // 자재정보 입력

	HeadOfficeVO loginSelectOne(HeadOfficeVO vo); // 로그인시 id로 selectOne

	StaffVO selectOne(StaffVO vo); // staffVO selectOne

	int staffInsert(StaffVO vo); // 스탭 생성

	int staffUpdate(StaffVO vo); // 스탭 정보수정

	int staffDelete(StaffVO vo); // 스탭 정보삭제

	int headOfficeDelete(HeadOfficeVO vo); // id,password 삭제

	int headOfficeInsert(HeadOfficeVO vo); // ID, Password 생성

	int headOfficePwUpdate(HeadOfficeVO vo); // password 변경

	List<StaffVO> searchStaffList(SearchCriteria cri); // 스탭정보 Search

	int searchStaffRows(SearchCriteria cri); // 스탭정보 Search 결과 Rows 조회
	
	List<FranchiseVO> searchFcList(SearchCriteria cri); // 가맹점정보 Search
	
	int searchFcRows(SearchCriteria cri); // 가맹점정보 Search 결과 Rows 조회
	
	
	//=======< 통계 >========
	//월별통계
	List<ChartVO> monthChart();
	//요일별통계
	List<ChartVO> dayChart();
	

}
