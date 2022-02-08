package service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import mapperInterface.ClientMapper;
import paging.SearchCriteria;
import vo.CartVO;
import vo.ClientVO;
import vo.EventBoardVO;
import vo.NoticeBoardVO;
import vo.ComplainBoardVO;
import vo.ComplainCommentVO;

@Log4j
@Service
public class ClientServiceImpl implements ClientService {

	@Autowired
	ClientMapper dao;
	
	
	// 회원장바구니 통쨰로 삭제
	@Override
	public int deleteCartbyClientId(String clientId) {
		return dao.deleteCartbyClientId(clientId);
	}
	
	
	// 회원장바구니 항목 삭제
	@Override
	public int deleteCart(CartVO vo) {
		return dao.deleteCart(vo);
	}
	
	// 회원장바구니 수량변경
	@Override
	public int updateCart(CartVO vo) {
		return dao.updateCart(vo);
	}
	
	// 회원장바구니 조회
	@Override
	public List<CartVO> selectCartbyClient(CartVO vo) {
		return dao.selectCartbyClient(vo);
	}
	
	// 회원 장바구니 항목추가
	@Override
	public int insertCart(CartVO vo) {
		return dao.insertCart(vo);
	}
	
	
	//고객 정보 1건 출력
	@Override
	public ClientVO selectOne(ClientVO vo) {
		return dao.selectOne(vo);
	}
	//고객 정보 핸드폰으로 찾기 1건 출력
	@Override
	public ClientVO selectOnePhone(ClientVO vo) {
		return dao.selectOnePhone(vo);
	}//selectOnePhone
	
	
	//고객정보 search
	@Override
	public List<ClientVO> searchClientList(SearchCriteria cri) {
		return dao.searchClientList(cri);
	}
	
	//회원가입
	@Override
	public int insertClient(ClientVO vo) {
		return dao.insertClient(vo);
	}
	//비밀번호 변경
	@Override
	public int updateClientPw(ClientVO vo) {
		return dao.updateClientPw(vo);
	}
	//내 정보 변경
	@Override
	public int updateMyInfo(ClientVO vo) {
		return dao.updateMyInfo(vo);
	}
	//회원탈퇴
	@Override
	public int deleteClient(ClientVO vo) {
		return dao.deleteClient(vo);
	}
	//자동로그인
	@Override
	public int keepLogin(Map<String, Object> params) {
		return dao.keepLogin(params);
	}
	//세션아이디 유효기간 남아있는 아이디 select
	@Override
	public ClientVO checkUserWithSessionKey(String sessionId) {
		return dao.checkUserWithSessionKey(sessionId);
	}
	
	

	//공지사항게시판 공지체크만 전체출력
	@Override
	public List<NoticeBoardVO> selectNoticeBoard() {
		return dao.selectNoticeBoard();
	}
	
	//공지사항
	@Override
	public List<NoticeBoardVO> searchNoticeBoard(SearchCriteria cri) {
		return dao.searchNoticeBoard(cri);
	}
	
	//공지사항 출력 결과 rows 조회
	@Override
	public int searchNoticeBoardRows(SearchCriteria cri) {
		return dao.searchNoticeBoardRows(cri);
	}
	
	
	//공지사항 Detail조회
	@Override
	public NoticeBoardVO selectDetailNoticeBoard(NoticeBoardVO vo) {
		return dao.selectDetailNoticeBoard(vo);
	}
	
	//공지사항 조회수증가
	@Override
	public int countUpNoticeBoard(NoticeBoardVO vo) {
		return dao.countUpNoticeBoard(vo);
	}
	

	

	//고객의 소리 등록
	@Override
	public int complainInsert(ComplainBoardVO vo) {
		return dao.complainInsert(vo);
	}
	

	//컴플레인 리스트 출력
	@Override
	public List<ComplainBoardVO> searchComplainBoard(SearchCriteria cri) {
		return dao.searchComplainBoard(cri);
	}
	// 컴플레인 row 출력
	@Override
	public int searchComplainBoardRows(SearchCriteria cri) {
		return dao.searchComplainBoardRows(cri);
	}
	// 컴플레인 디테일 출력
	@Override
	public ComplainBoardVO selectDetailComplainBoard(ComplainBoardVO vo) {
		return dao.selectDetailComplainBoard(vo);
	}
	
	// 컴플레인 완료처리
	@Override
	public int complainComplete(ComplainBoardVO vo) {
		return dao.complainComplete(vo);
	}
	
	// 컴플레인 댓글달기
	@Override
	public int complainCommentInsert(ComplainCommentVO vo) {
		return dao.complainCommentInsert(vo);
	}	
	// 컴플레인 댓글출력
	@Override
	public List<ComplainCommentVO> selectListComplainComment(ComplainCommentVO vo) {
		return dao.selectListComplainComment(vo);
	}
	// 컴플레인 댓글삭제
	@Override
	public int deleteComplainComment(ComplainCommentVO vo) {
		return dao.deleteComplainComment(vo);
	}
	
	// 이벤트 게시판 
	@Override
	public List<EventBoardVO> searchEventBoard(SearchCriteria cri) {
		return dao.searchEventBoard(cri);
	}

	// 이벤트 게시판 출력 결과 rows 조회
	@Override
	public int searchEventBoardRows(SearchCriteria cri) {
		return dao.searchEventBoardRows(cri);
	}
	
	// 이벤트 게시판 Detail조회
	@Override
	public EventBoardVO selectDetailEventBoard(EventBoardVO vo) {
		return dao.selectDetailEventBoard(vo);
	}
	
}
