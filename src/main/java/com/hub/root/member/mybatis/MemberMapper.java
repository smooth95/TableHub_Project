package com.hub.root.member.mybatis;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.hub.root.member.dto.MemberDTO;
import com.hub.root.member.dto.StoreDTO;

public interface MemberMapper {
	public MemberDTO loginChk(@Param("id") String id);
	public MemberDTO idChk( String id );
	public MemberDTO nickChk( String nick );
	public ArrayList<MemberDTO> mailChk( String email );
	public int register(MemberDTO dto);

	public String storeLoginChk(String id);
	public int storeChk(String storeId);
	public int storeNumChk(String storeId);
	public int storeMailChk(String email);
	public int storeRegisterChk(StoreDTO dto);

	public String[] getMemId(String email);
	public int idEmailChk(@Param("id") String id, @Param("email") String email);
	public int modifyPwd(@Param("pwd") String pwd, @Param("id") String id);
}
