package service;

import java.util.HashMap;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;
import vo.EmailVO;

@Service
public class SendService {

	
	//문자인증시
	public void certifiedPhoneNumber(String phoneNumber, String cerNum) {
		String api_key = "NCSDRLFJFIUKNZGS";
		String api_secret = "VKI6IIOBY6CUIDJ1EWGISTWWVOIKKL5C";
		Message coolsms = new Message(api_key, api_secret);

		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", phoneNumber);
		params.put("from", "01099474735");
		params.put("type", "SMS");
		params.put("text", "페데리코피자 비회원주문 휴대폰인증 : 인증번호는" + "[" + cerNum + "]" + "입니다.");
		params.put("app_version", "test app 1.2"); // application name and version

//		try {
//			JSONObject obj = (JSONObject) coolsms.send(params);
//			System.out.println(obj.toString());
//		} catch (CoolsmsException e) {
//			System.out.println(e.getMessage());
//			System.out.println(e.getCode());
//		}
	}


	//결제완료 문자전송
	public void orderCompeleteSmsSend(String phoneNumber, String deliveryTime, String fcId) {
		String api_key = "NCSDRLFJFIUKNZGS";
		String api_secret = "VKI6IIOBY6CUIDJ1EWGISTWWVOIKKL5C";
		Message coolsms = new Message(api_key, api_secret);

		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", phoneNumber);
		params.put("from", "01099474735");
		params.put("type", "SMS");
		params.put("text", "페데리코피자 "+fcId+"점으로 주문이 완료되었습니다. "+deliveryTime+"분 소요될 예정입니다 :)");
		params.put("app_version", "test app 1.2"); // application name and version

//		try {
//			JSONObject obj = (JSONObject) coolsms.send(params);
//			System.out.println(obj.toString());
//		} catch (CoolsmsException e) {
//			System.out.println(e.getMessage());
//			System.out.println(e.getCode());
//		}
	}
	//주문취소 문자전송
	public void orderCancelSmsSend(String phoneNumber) {
		String api_key = "NCSDRLFJFIUKNZGS";
		String api_secret = "VKI6IIOBY6CUIDJ1EWGISTWWVOIKKL5C";
		Message coolsms = new Message(api_key, api_secret);

		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", phoneNumber);
		params.put("from", "01099474735");
		params.put("type", "SMS");
		params.put("text", "페데리코피자 주문취소가 완료되었습니다. 카드사환불은 2,3시간 소요예정입니다 :)");
		params.put("app_version", "test app 1.2"); // application name and version

//		try {
//			JSONObject obj = (JSONObject) coolsms.send(params);
//			System.out.println(obj.toString());
//		} catch (CoolsmsException e) {
//			System.out.println(e.getMessage());
//			System.out.println(e.getCode());
//		}
	}
	
	 @Autowired
	 protected JavaMailSender  mailSender;
	 
	public void SendEmail(EmailVO email) throws Exception {

			MimeMessage msg = mailSender.createMimeMessage();
			msg.setSubject(email.getSubject());
			msg.setText(email.getContent());
			msg.setRecipient(RecipientType.TO, new InternetAddress(email.getReciver()));

			mailSender.send(msg);
		}

	

}