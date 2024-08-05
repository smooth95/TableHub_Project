package com.hub.root.member.controller.register;

import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.hub.root.member.dto.MemberDTO;
import com.hub.root.member.service.register.MemberRegisterService;

@RestController
@RequestMapping("member/register")
public class MemberRegisterRestController {
	@Autowired MemberRegisterService mrs;

	@PostMapping(value="idChk", produces = "application/json; charset=utf-8")
	public int idChk(@RequestBody Map<String, Object> map) {
		System.out.println("map : " + map);
		int result = mrs.idChk((String)map.get("id"));

		return result;
	}
	@GetMapping(value="nickChk", produces = "application/json; charset=utf-8")
	public int nickChk(@RequestParam String nick) {
		System.out.println("nickChk 컨트롤러 연동");
		int result = mrs.nickChk(nick);

		return result;
	}


	@PostMapping(value="registerChk", produces = "application/json; charset=utf-8")
	public int registerChk(@RequestBody Map<String, Object> map) {
		System.out.println("id : " + (String)map.get("id"));
		System.out.println("pwd : " + (String)map.get("pwd"));
		System.out.println("nick : " + (String)map.get("nick"));
		System.out.println("phone : " + (String)map.get("phone"));
		System.out.println("email : " + (String)map.get("email"));
		System.out.println("birth : " + (String)map.get("birth"));
		System.out.println("gender : " + map.get("gender"));
		MemberDTO dto = new MemberDTO();
		dto.setId((String)map.get("id"));
		if (map.get("pwd") == null) {
			dto.setPwd("none");
		} else {
			dto.setPwd((String)map.get("pwd"));
		}
		dto.setNick((String)map.get("nick"));
		dto.setPhone((String)map.get("phone"));
		dto.setEmail((String)map.get("email"));
		dto.setBirth((String)map.get("birth"));
		dto.setGender((Integer)map.get("gender"));
		int result = mrs.register(dto);
		System.out.println("result : " + result);
		return result;
	}

	@PostMapping(value="registerCodeChk", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> registerCodeChk(@RequestBody Map<String, Object> map, HttpServletRequest req, HttpServletResponse res, HttpSession session,
			Model model) {
		String code = (String)map.get("code");

		Cookie[] Cookies = req.getCookies();
		String email = "";
		if (Cookies != null) {
			for(Cookie c : Cookies) {
				if (c.getName().equals("storeEmail")) {
					email = c.getValue();
					break;
				}
			}
		}
		String ses = (String)session.getAttribute(email);
		int result;
		if (code.equals(ses)) {
		 	result = 1;
		} else {
			result = 0;
		}
		map.put("result", result);
		return map;
	}

	@PostMapping(value="storeRegisterChk", produces = "application/json; charset=utf-8")
	public String storeRegisterChk(@RequestBody Map<String, Object> map) {
		System.out.println("id : " + map.get("id"));
		System.out.println("pwd : " + map.get("pwd"));
		System.out.println("name : " + map.get("name"));
		System.out.println("phone : " + map.get("phone"));
		System.out.println("phone : " + map.get("mainPhone"));
		System.out.println("email : " + map.get("email"));
		String msg = mrs.storeRegisterChk(map);
		return msg;
	}



}
