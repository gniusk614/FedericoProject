package vo;

import lombok.Data;

@Data
public class CartVO {

		int cartSeq;
		String clientId;
		int menuQty;
		MenuVO menuVo;
		
}
