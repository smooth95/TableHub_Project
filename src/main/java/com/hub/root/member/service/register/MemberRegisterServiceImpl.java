package com.hub.root.member.service.register;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hub.root.member.dto.MemberDTO;
import com.hub.root.member.dto.StoreDTO;
import com.hub.root.member.mybatis.MemberMapper;

@Service
public class MemberRegisterServiceImpl implements MemberRegisterService{


	@Autowired MemberMapper mapper;
	@Autowired JavaMailSender sender;

	BCryptPasswordEncoder en;
	public MemberRegisterServiceImpl () {
		en = new BCryptPasswordEncoder();
	}

	@Override
	public int idChk(String id) {
		MemberDTO dto = mapper.idChk(id);
		int result;
		if (dto == null) {
			result = 0;
		} else {
			result = 1;
		}
		return result;
	}

	@Override
	public int nickChk(String nick) {
		MemberDTO dto = mapper.nickChk(nick);
		int result;
		if (dto == null) {
			result = 0;
		} else {
			result = 1;
		}
		return result;
	}

	@Override
	public int register(MemberDTO dto) {
		System.out.println("서비스시작asdf");
		dto.setPwd(en.encode(dto.getPwd()));
		dto.setDateCreate(setTime());
		dto.setImg("default.jpg");
		dto.setStatus("안녕하세요 저는 "+dto.getNick()+" 입니다.");
		System.out.println(dto.getStatus());
		int result = mapper.register(dto);
		return result;
	}

	public String setTime() {
		LocalDateTime currentTime = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedTime = currentTime.format(formatter);

        return formattedTime;
	}

	@Override
	public String storeRegisterChk(Map<String, Object> map) {
		StoreDTO dto = new StoreDTO();
		dto.setId((String)map.get("id"));
		dto.setPwd(en.encode((String)map.get("pwd")));
		dto.setName((String)map.get("name"));
		dto.setPhone((String)map.get("phone"));
		dto.setMainPhone((String)map.get("mainPhone"));
		dto.setEmail((String)map.get("email"));
		int result = mapper.storeRegisterChk(dto);
		String msg = null;
		if (result == 1) {
			msg = "가입이 완료되었습니다. \n로그인 후 마이페이지에서 가게를 등록해주세요.";
		} else {
			msg = "문제가 발생하였습니다. \n새로고침 후 다시 시도해주세요";
		}
		return msg;
	}








}
