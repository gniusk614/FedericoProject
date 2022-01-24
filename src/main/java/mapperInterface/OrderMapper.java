package mapperInterface;

import java.util.List;
import java.util.Map;

import vo.OrderDetailListVO;
import vo.OrderListVO;

public interface OrderMapper {
	
	List<OrderDetailListVO> selectDetailbyOrderNumber(int orderNumber); // 주문번호별 주문상세내역 조회
	List<OrderListVO> selectFcOrderbyFcId(OrderListVO orderListVo); // 가맹점별 주문목록 조회
	
	int insertOrderDetailList(Map<String, Object> params);// 주문상세목록에 등록
	int insertOrderList(Map<String, Object> params); // 주문목록에 등록
	
	
	
}
