package mapperInterface;

import java.util.List;
import java.util.Map;

import paging.SearchCriteria;
import vo.CartVO;
import vo.ClientVO;

public interface ClientMapper {
	
	int insertOrderDetailList(Map<String, Object> params);// 주문상세목록에 등록
	int insertOrderList(Map<String, Object> params); // 주문목록에 등록
	
	int deleteCartbyClientId(String clientId); // 회원장바구니 통쨰로 삭제
	int deleteCart(CartVO vo); // 회원장바구니 항목 삭제
	int updateCart(CartVO vo); // 회원장바구니 수량변경
	List<CartVO> selectCartbyClient(CartVO vo); // 회원장바구니 조회
	int insertCart(CartVO vo); // 회원 장바구니 항목추가
	
	ClientVO selectOne(ClientVO vo); //고객 정보 1건 출력
	ClientVO selectOnePhone(ClientVO vo); //고객 정보 핸드폰으로 찾기 1건 출력
	List<ClientVO> searchClientList(SearchCriteria cri); //고객정보 search
	
	
}
