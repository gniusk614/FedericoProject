package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.FranchiseMapper;
import vo.FranchiseVO;

@Service
public class FranchiseServiceImple implements FranchiseService{
	
	@Autowired
	FranchiseMapper dao;
	
	//가맹점정보 모두 불러오기
	@Override
	public List<FranchiseVO> selectFc() {
		return dao.selectFc();
	}
	
	//특정 가맹점정보 불러오기
	@Override
	public FranchiseVO selectFcOne(FranchiseVO vo) {
		return dao.selectFcOne(vo);
	}
	
}
