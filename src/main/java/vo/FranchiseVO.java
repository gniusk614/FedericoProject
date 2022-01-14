package vo;

import lombok.Data;

@Data
public class FranchiseVO {
	
	private String fcId;
	private	String fcPassword;
	private String fcName;
	private String fcAdress;
	private String fcArea;
	private String fcPhone;
	private String hoId;
	// 가맹점 정보를 이용하는 부분에서 담당직원정보를 조회할일이 없을것같아 객체 안넣음(현구)

}
