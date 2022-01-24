package vo;

import java.sql.Date;

import lombok.Data;

@Data
public class OrderListVO {
	
	private int orderNumber;
	private String clientId;
	private String fcId;
	private String completeYN;
	private String memo;
	private Date orderDate;
	private String clientName;
	private String clientAddress;
	private String clientPhone;
	private String memberYN;
	
}
