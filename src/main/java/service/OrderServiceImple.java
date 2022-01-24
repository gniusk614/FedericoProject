package service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import mapperInterface.OrderMapper;
import vo.OrderDetailListVO;
import vo.OrderListVO;

@Log4j
@Service
public class OrderServiceImple implements OrderService {

	@Autowired
	OrderMapper dao;
	
	// 주문번호별 주문상세내역 조회
	@Override
	public List<OrderDetailListVO> selectDetailbyOrderNumber(int orderNumber) {
		return dao.selectDetailbyOrderNumber(orderNumber);
	}
	
	
	// 가맹점별 주문목록 조회
	@Override
	public List<OrderListVO> selectFcOrderbyFcId(OrderListVO orderListVo) {
		return dao.selectFcOrderbyFcId(orderListVo);
	}
	
	// 주문상세목록에 등록
	@Override
	public int insertOrderDetailList(Map<String, Object> params) {
		return dao.insertOrderDetailList(params);
	}
	
	// 주문목록에 등록
	@Override
	public int insertOrderList(Map<String, Object> params) {
		return dao.insertOrderList(params);
	}
	
	
	
	
}
