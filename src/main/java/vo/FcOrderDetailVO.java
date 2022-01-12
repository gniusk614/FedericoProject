package vo;

import lombok.Data;

@Data
public class FcOrderDetailVO {
	
	private int fcOrderDetailSeq;
	private ItemInfoVO itemInfoVO;
	private int itemQty;
	
}
