package vo;

import java.util.List;

import lombok.Data;

@Data
public class HeadOfficeVO {
	private String hoId;
	private String hoPassword;
	private StaffVO staffVo;

	// ** Spring Security 사용 컬럼
	private boolean enabled;
	private List<AuthVO> authList;

}
