package service;

import java.util.List;

import vo.FranchiseVO;

public interface FranchiseService {
	
	List<FranchiseVO> selectFc(); //가맹점정보 모두 불러오기
	
	FranchiseVO selectFcOne(FranchiseVO vo); //특정 가맹점정보 불러오기
}
