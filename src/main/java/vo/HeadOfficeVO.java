package vo;

import java.util.List;

import lombok.Data;

@Data
public class HeadOfficeVO {
	String hoId;
	String hoPassword;
	StaffVO staffVo;

	// ** Spring Security 사용 컬럼
	private boolean enabled;
	private List<AuthVO> authList;

}
