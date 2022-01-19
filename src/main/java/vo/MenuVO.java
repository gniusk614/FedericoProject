package vo;

import org.springframework.web.multipart.MultipartFile;

/*-----작성기록 -----------
 1. 2022.01.13 김민석 생성
 2. 
*/

import lombok.Data;

@Data
public class MenuVO {
	
	private int menuIndex;
	private String menuName;
	private String menuIntro;
	private String menuFlag;
	private int menuPrice;
	
	private String menuImage; //  Table에 저장된 경로및 화일명 처리를 위한 필드
	private MultipartFile menuUploadfilef; 
	
}
