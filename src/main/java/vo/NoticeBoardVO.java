package vo;

import java.sql.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeBoardVO {

	private int seq;
	private String title;
	private String id;
	private String content;
	private String regdate;
	private String noticeFlag;
	private int cnt;
	
	
}
