package vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ComplainBoardVO {

	int seq;
	String title;
	String clientName;
	String clientPhone;
	String content;
	String regdate;
	String uploadfile;
	String completeFlag;
	String head;
	String fcId;
	String clientEmail;
	
	
	private MultipartFile menuUploadfilef; 
	
}
