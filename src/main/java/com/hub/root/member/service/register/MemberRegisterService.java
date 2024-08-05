package com.hub.root.member.service.register;

import java.util.Map;

import com.hub.root.member.dto.MemberDTO;

public interface MemberRegisterService {
	public int idChk(String id);
	public int nickChk(String nick);
	public int register(MemberDTO dto);

	public String storeRegisterChk(Map<String, Object> map);
}
