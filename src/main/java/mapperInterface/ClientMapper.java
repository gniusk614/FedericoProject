package mapperInterface;

import java.util.List;

import paging.SearchCriteria;
import vo.ClientVO;

public interface ClientMapper {
	
	
	ClientVO selectOne(ClientVO vo); //고객 정보 1건 출력
	List<ClientVO> searchClientList(SearchCriteria cri); //고객정보 search
	
	
}
