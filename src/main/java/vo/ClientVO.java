package vo;

import lombok.Data;

@Data
public class ClientVO {
	private String clientId;
	private String clientPassword;
	private String clientName;
	private String clientPhone;
	private String clientBirthday;
	private String clientAddress;
	private String clientEmail;
	private String smsCheck;
	private String emailCheck;
	private String deleteCheck;
	private String deleteReason;
	private String deletePhone;
	
}
