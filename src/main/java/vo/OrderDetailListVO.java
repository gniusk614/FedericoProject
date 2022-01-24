package vo;

import lombok.Data;

@Data
public class OrderDetailListVO {
	
	private int orderDetailNumber;
	private int orderNumber;
	private String menuIndex;
	private String menuQty;
	
	private MenuVO menuVo;
	
}
