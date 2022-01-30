package vo;

import lombok.Data;

@Data
public class FcClientRegVO {
	
	private int seq;
	private String fcId;
	private String clientPhone;
	private String memo;
	private String gbFlag;
}
