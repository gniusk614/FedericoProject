package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import mapperInterface.HeadOfficeMapper;
import vo.HeadOfficeVO;
import vo.IteminfoVO;
import vo.StaffVO;

@Log4j
@Service
public class HeadOfficeServiceImpl implements HeadOfficeService {
	
	@Autowired
	HeadOfficeMapper dao;
	
	// 사원정보리스트
		@Override
		public List<StaffVO> selectMList(StaffVO vo) {
			return dao.selectMList(vo);
		}	
		
			// 본사: 자재입력기능 (강현구)
	@Override
	public int iteminsert(IteminfoVO vo) {
		log.info("service"+vo.getItemFlag()+vo.getItemName()+vo.getItemPrice());

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
	
}
