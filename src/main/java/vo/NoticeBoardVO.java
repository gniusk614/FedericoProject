package vo;

import lombok.Data;

@Data
public class NoticeBoardVO {

	private int seq;
	private String title;
	private String id;
	private String content;
	private String regdate;
	private String uploadFile;
	private String noticeFlag;
	private int cnt;
	
}
