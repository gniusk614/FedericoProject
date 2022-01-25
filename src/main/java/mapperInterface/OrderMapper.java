package mapperInterface;

import java.util.List;
import java.util.Map;

import vo.FcOrderVO;
import vo.OrderDetailListVO;
import vo.OrderListVO;

public interface OrderMapper {
	
	int searchCompleteOrderRows(Map<String, Object> params); // 완료주문 searchOrderRows
	List<OrderListVO> searchCompleteOrder(Map<String, Object> params); // 완료주문 서치,페이징
	
	int orderComplete(OrderListVO vo); // 주문완료처리
	List<OrderDetailListVO> selectDetailbyOrderNumber(int orderNumber); // 주문번호별 주문상세내역 조회
	List<OrderListVO> selectFcOrderbyFcId(OrderListVO orderListVo); // 가맹점별 주문목록 조회
	
	int insertOrderDetailList(Map<String, Object> params);// 주문상세목록에 등록
	int insertOrderList(Map<String, Object> params); // 주문목록에 등록
	
	
	
}
