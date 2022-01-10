package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.HeadOfficeMapper;
import vo.HeadOfficeVO;
import vo.StaffVO;


@Service
public class HeadOfficeServiceImpl implements HeadOfficeService {
	
	@Autowired
	HeadOfficeMapper dao;
	
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
