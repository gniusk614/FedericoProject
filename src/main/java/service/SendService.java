package service;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Service;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class SendService {

	
	
	public void certifiedPhoneNumber(String phoneNumber, String cerNum) {
		String api_key = "NCSDRLFJFIUKNZGS";
		String api_secret = "VKI6IIOBY6CUIDJ1EWGISTWWVOIKKL5C";
		Message coolsms = new Message(api_key, api_secret);

		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", phoneNumber);
		params.put("from", "01099474735");
		params.put("type", "SMS");
		params.put("text",  "페데리코피자 비회원주문 휴대폰인증 : 인증번호는" + "["+cerNum+"]" + "입니다.");
		params.put("app_version", "test app 1.2"); // application name and version

		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		} catch (CoolsmsException e) {
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
	}
	
}
