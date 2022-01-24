package vo;

import java.sql.Date;
import java.util.List;

import lombok.Data;

@Data
public class FcOrderVO {

	private int fcOrderSeq;
	private String fcId;
	private Date fcOrderDate;
	private String fcOrderFlag;
	
}
