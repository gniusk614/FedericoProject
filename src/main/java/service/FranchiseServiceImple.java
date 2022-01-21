package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.FranchiseMapper;
import vo.FranchiseVO;

@Service
public class FranchiseServiceImple implements FranchiseService {

	@Autowired
	FranchiseMapper dao;

	//지역 가맹점 찾기. 
	@Override
	public List<FranchiseVO> selectListbyArea(String area) {
		return dao.selectListbyArea(area);
	}
	
	// 가맹점정보 모두 불러오기
	@Override
	public List<FranchiseVO> selectFc() {
		return dao.selectFc();
	}

	// 특정 가맹점정보 불러오기
	@Override
	public FranchiseVO selectFcOne(FranchiseVO vo) {
		return dao.selectFcOne(vo);
	}

	// 프랜차이즈 정보 업데이트
	@Override
	public int fcUpdate(FranchiseVO vo) {
		return dao.fcUpdate(vo);
	}

	//프랜차이즈 폐점,오픈처리
	@Override
	public int fcClose(FranchiseVO vo) {
		return dao.fcClose(vo);
	}
	
	// 프랜차이즈 계정생성
	@Override
	public int fcInsert(FranchiseVO vo) {
		return dao.fcInsert(vo);
	}

}
