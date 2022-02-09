package service;

import java.util.List;
import java.util.Map;

import paging.SearchCriteria;
import vo.CartVO;
import vo.ClientVO;
import vo.EventBoardVO;
import vo.NoticeBoardVO;
import vo.ComplainBoardVO;
import vo.ComplainCommentVO;

public interface ClientService {
	

	int deleteCartbyClientId(String clientId); // 회원장바구니 통쨰로 삭제
	int deleteCart(CartVO vo); // 회원장바구니 항목 삭제
	int updateCart(CartVO vo); // 회원장바구니 수량변경
	List<CartVO> selectCartbyClient(CartVO vo); // 회원장바구니 조회
	int insertCart(CartVO vo); // 회원 장바구니 항목추가
	
	ClientVO selectDubCheck(ClientVO vo); //고객 아이디 중복확인
	ClientVO selectOne(ClientVO vo); //고객 정보 1건 출력
	ClientVO selectOnePhone(ClientVO vo); //고객 정보 핸드폰으로 찾기 1건 출력
	List<ClientVO> searchClientList(SearchCriteria cri); //고객정보 search
	int insertClient(ClientVO vo); //회원가입
	int updateClientPw(ClientVO vo);//비밀번호 변경
	int updateMyInfo(ClientVO vo);//내정보변경
	int deleteClient(ClientVO vo);//회원탈퇴
	int keepLogin(Map<String, Object> params);//자동로그인
	ClientVO checkUserWithSessionKey(String sessionId);//유효기간 남아있는 아이디 select
	
	List<NoticeBoardVO> selectNoticeBoard();//공지사항게시판 공지체크만 전체출력
	List<NoticeBoardVO> searchNoticeBoard(SearchCriteria cri);//공지사항search
	int searchNoticeBoardRows(SearchCriteria cri); //공지사항 search 결과 rows 조회
	NoticeBoardVO selectDetailNoticeBoard(NoticeBoardVO vo);//공지사항 Detail조회
	int countUpNoticeBoard(NoticeBoardVO vo); //공지사항 
	

	
	

	int complainInsert(ComplainBoardVO vo); //컴플레인 등록
	List<ComplainBoardVO> searchComplainBoard(SearchCriteria cri); //컴플레인 리스트 출력
	int searchComplainBoardRows(SearchCriteria cri);//row조회
	ComplainBoardVO selectDetailComplainBoard(ComplainBoardVO vo);//컴플레인 Detail조회
	int complainComplete(ComplainBoardVO vo); //컴플레인 완료처리
	int complainCommentInsert(ComplainCommentVO vo); //컴플레인 댓글입력
	List<ComplainCommentVO> selectListComplainComment(ComplainCommentVO vo); //컴플레인 댓글출력
	int deleteComplainComment(ComplainCommentVO vo); //컴플레인 댓글삭제
	
	/* ============================={ 이벤트 페이지 }================================ */
	List<EventBoardVO> searchEventBoard(SearchCriteria cri);// 이벤트 게시판 출력
	int searchEventBoardRows(SearchCriteria cri); //이벤트 게시판 search 결과 rows 조회
	
	List<EventBoardVO> searchEndEventBoard(SearchCriteria cri);// 이벤트 게시판 출력
	int searchEndEventBoardRows(SearchCriteria cri); //이벤트 게시판 search 결과 rows 조회
	EventBoardVO selectDetailEventBoard(EventBoardVO vo);// 이벤트 게시판 Detail조회
}
