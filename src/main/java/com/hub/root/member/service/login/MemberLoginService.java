package com.hub.root.member.service.login;

import java.util.Map;

import javax.servlet.http.Cookie;

public interface MemberLoginService {
	public int loginChk(String id, String pwd);
	public int mailChk(String email);
	public int sendMailCode(String email);
	public int snsLoginChk(String id);

	public int storeLoginChk(String id, String pwd);
	public Map<String, Object> storeNumChk(String storeId);
	public int storeMailChk(String email);

	public Map<String, Object> sendMailId(String email);
	public Map<String, Object> idEmailChk(String id, String email);
	public int modifyPwdIdChk(String id, Cookie[] cookies);
	public Map<String, Object> modifyPwd(String pwd, String id);
}
