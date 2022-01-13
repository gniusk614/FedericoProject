package vo;

import lombok.Data;

@Data
public class FcOrderDetailVO {
	
	private int fcOrderDetailSeq;
	private int fcOrderSeq;
	private int itemIndex;
	private int itemQty;
	private ItemInfoVO itemInfoVO;
	
}
