package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.TestMapper;
import vo.TestVO;

@Service
public class TestServiceImple implements TestService {
	
	@Autowired
	TestMapper dao;
	
	@Override
	public List<TestVO> selectList() {
		
		return dao.selectList();
	}
		
}
