package vo;

import java.sql.Date;

import lombok.Data;

@Data
public class FcOrderVO {

	private int fcOrderSeq;
	private FranchiseVO fcVo;
	private Date fcOrderDate;
	private String fcFlag;
	
	
}
