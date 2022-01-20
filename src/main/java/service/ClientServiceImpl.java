package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j;
import mapperInterface.ClientMapper;
import paging.SearchCriteria;
import vo.ClientVO;

@Log4j
@Service
public class ClientServiceImpl implements ClientService {

	@Autowired
	ClientMapper dao;
	
	
	//고객 정보 1건 출력
	@Override
	public ClientVO selectOne(ClientVO vo) {
		return dao.selectOne(vo);
	}
	
	
	
	//고객정보 search
	@Override
	public List<ClientVO> searchClientList(SearchCriteria cri) {
		return dao.searchClientList(cri);
	}
	
	
}
