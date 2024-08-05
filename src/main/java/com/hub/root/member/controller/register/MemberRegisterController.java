package com.hub.root.member.controller.register;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hub.root.member.service.login.MemberLoginService;

@Controller
@RequestMapping("member/register")
public class MemberRegisterController {
	@Autowired MemberLoginService ms;

	@GetMapping("user")
	public String registerUser(HttpServletRequest req, Model model) {
		Cookie[] Cookies = req.getCookies();
		String email = "";
		if (Cookies != null) {
			for(Cookie c : Cookies) {
				if (c.getName().equals("email")) {
					email = c.getValue();
				}
			}
		}
		model.addAttribute("email", email);
		return "member/register/user";
	}

	@GetMapping("store")
	public String registerStore(HttpServletRequest req, Model model, @RequestParam String storeNum) {
		System.out.println("storeNum : "+ storeNum);
		Cookie[] Cookies = req.getCookies();
		String email = "";
		if (Cookies != null) {
			for(Cookie c : Cookies) {
				if (c.getName().equals("storeEmail")) {
					email = c.getValue();
				}
			}
		}
//		String emailLocal[] = email.split("@");
		model.addAttribute("storeEmail", email);
		model.addAttribute("storeNum", storeNum);

		return "member/register/store";
	}

	@GetMapping("naver")
	public String snsNaver() {

		return "member/register/naver";
	}



}
