package com.hub.root.member.controller.login;

import java.util.Map;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.hub.root.member.config.MemberMessageConfig;
import com.hub.root.member.service.login.MemberLoginService;

@RestController
@RequestMapping("member")
public class MemberLoginRestController {
	@Autowired MemberLoginService ms;
	@Autowired MemberMessageConfig mmc;

    public int randomNumber() {
    	Random random = new Random();
    	int num = 1000 + random.nextInt(9000);
    	System.out.println("num : " + num);
    	return num;
    }

    @PostMapping(value="sendMessage", produces = "application/json; charset=utf-8")
    public String sendOne(@RequestBody Map<String, Object> map, HttpSession session, Model model) {
		System.out.println("memLoginrestCont sendMessage 실행");

    	int code = randomNumber();

    	String phoneNumber = (String)map.get("phoneNumber");
//        Message message = new Message();
//		 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
//        message.setFrom("01099062986");
//		message.setTo(phoneNumber);
//		message.setText("인증 코드는 [ " + code + " ] 입니다. 코드 입력 후 회원가입을 진행하세요");

//		SingleMessageSentResponse response = mmc.messageService.sendOne(new SingleMessageSendingRequest(message));

    	session.setAttribute("phoneNumber", phoneNumber);
    	session.setAttribute(phoneNumber, code);
    	model.addAttribute(session);


    	return "문자로 4자리 코드가 발송되었습니다.";
    }

    @PostMapping(value="codeChk", produces = "application/json; charset=utf-8")
    public int codeChk(@RequestBody Map<String, Object> map, HttpSession session, Model model) {

		System.out.println("memLoginrestCont codeChk 실행");

    	String phoneNumber = (String)session.getAttribute("phoneNumber");
    	int inputCode = Integer.parseInt((String)map.get("inputCode"));
    	int code = (Integer)session.getAttribute(phoneNumber);


    	if (inputCode == code) {
    		System.out.println("인증코드 일치함");
    		return 1;
    	} else {
    		System.out.println("인증코드 불일치");
    		return 0;
    	}

    }

	@PostMapping(value="register", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> register(@RequestBody Map<String, Object> map, HttpServletRequest req, HttpServletResponse res, HttpSession session,
			Model model) {
		System.out.println("memLoginrestCont register 실행");
		String code = (String)map.get("code");

		Cookie[] Cookies = req.getCookies();
		String email = "";
		if (Cookies != null) {
			for(Cookie c : Cookies) {
				if (c.getName().equals("email")) {
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

	@PostMapping(value="loginChk", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> loginChk(@RequestBody Map<String, Object> map, Model model, HttpSession session, HttpServletResponse res) {
		System.out.println("memLoginrestCont loginChk 실행");
		String id = (String)map.get("id");
		String ids[] = id.toString().split("=");
		System.out.println(ids[0]);
		
		// 불러온 id값의 첫글자가 N 또는 K(sns로그인)일경우 if문 실행
		if (ids[0].equals("N") || ids[0].equals("K")) {
			
			// 회원 정보를 조회하고 결과에 따라 0 또는 1을 반환한다.
			map.put("result", ms.snsLoginChk(id));
			String token = (String)map.get("token");
			
			session.setAttribute("userId", id);
			Cookie cookie = new Cookie("snsToken", token);
			cookie.setMaxAge(5 * 60);
			cookie.setPath("/root");
			res.addCookie(cookie);
			
			model.addAttribute(session);
		}else {
			System.out.println("else문 실행");
			String pwd = (String)map.get("pwd");
			int result = ms.loginChk(id, pwd);

			if (result == 1 || result == 2) {
				System.out.println("else 안에 if문실행");
				session.setAttribute("userId", id);
				session.setMaxInactiveInterval(1800);
				map.put("result", null);
				if (result == 2) {
					session.setAttribute("isAdmin", 1);
				}
				model.addAttribute(session);
			} else {
				map.put("result", "입력 정보가 일치하지 않습니다. <br>아이디 또는 비밀번호를 확인해주세요");
			}
		}

		return map;
	}

	@PostMapping(value="storeLoginChk", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> storeLoginChk(@RequestBody Map<String, Object> map, Model model, HttpSession session) {
		System.out.println("memLoginrestCont storeLoginChk 실행");
		String id = (String)map.get("id");
		String pwd = (String)map.get("pwd");
		int result = ms.storeLoginChk(id, pwd);

		if (result == 1) {
			session.setAttribute("storeId", id);
			map.put("result", null);
			model.addAttribute(session);
		} else {
			map.put("result", "입력 정보가 일치하지 않습니다. <br>아이디 또는 비밀번호를 확인해주세요");
		}

		return map;
	}

	@PostMapping(value="sendMail", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> sendMail(@RequestBody Map<String, Object> map, HttpServletRequest req, HttpServletResponse res, HttpSession session,
			Model model) {
		System.out.println("memLoginrestCont sendMail 실행");
		String email = (String)map.get("email");
		int result = ms.mailChk(email);
		if (result == 1) {
			map.put("msg", "이미 등록되어있는 주소입니다. <br>로그인 또는 아이디 찾기를 진행해주세요");
			map.put("result", 1);
		} else {
			// 이메일 값으로 쿠키를 만들어서 5분간 유지한다.
			Cookie cookie = new Cookie("email", email);
			cookie.setMaxAge(5 * 60); // 5분
			res.addCookie(cookie);

	    	int code = ms.sendMailCode(email);

	    	// 랜덤값을 문자열로 변환하여 세션에 저장
	    	// 저장된 쿠키의 이메일 값으로 코드값을 저장한다. 추후 코드 인증 확인시 필요
			String codeKey = String.valueOf(code);
			session.setAttribute(email, codeKey);
			/*
			 * 세션과 쿠키값으로 저장하는 이유
			 * 쿠키값으로만 저장하게 되면 쿠키값 변경이 가능해서 보안적으로 취약할것이고
			 * 세션값으로만 저장하게 되면 주소가 다른 값으로 여러 번 요청할 경우
			 * 문제가 발생될수 있어서 이 방법을 사용
			 */
			map.put("msg", "인증 코드가 전송되었습니다.");
			map.put("result", 0);
			model.addAttribute(session);
		}


		return map;
	}

	@PostMapping(value="storeNumChk", produces = "application/json; charset=utf-8")
	public Map<String, Object> storeNumChk(@RequestBody Map<String, Object> map) {
		System.out.println("memLoginrestCont storeNumChk 실행");
		System.out.println("id : " + map.get("storeId"));
		String storeId = (String)map.get("storeId");
		map = ms.storeNumChk(storeId);
		return map;
	}

	@PostMapping(value="storeSendMail", produces = "application/json; charset=utf-8")
	public Map<String, Object> storeSendMail(@RequestBody Map<String, Object> map, HttpServletRequest req, HttpServletResponse res, HttpSession session,
			Model model) {
		System.out.println("memLoginrestCont storeSendMail 실행");

		String email = (String)map.get("email");
		int result = ms.storeMailChk(email);
		if (result != 0) {
			map.put("msg", "이미 등록되어있는 이메일 주소입니다.");
			map.put("result", 1);
		} else {
			Cookie cookie = new Cookie("storeEmail", email);
			cookie.setMaxAge(5 * 60); // 5분
			res.addCookie(cookie);

	    	int code = ms.sendMailCode(email);

			String codeKey = String.valueOf(code);
			session.setAttribute(email, codeKey);

			map.put("msg", "인증 코드가 전송되었습니다.");
			map.put("result", 0);
			model.addAttribute(session);
		}


		return map;
	}
	
	// 아이디 찾기시 아이디정보를 메일로 전달
	@PostMapping(value="sendMail/id", produces="application/json; charset=utf-8")
	public Map<String, Object> sendMailId(@RequestBody Map<String, Object> map) {
		System.out.println("MemLoginRestCont sendMailId 실행");
		map = ms.sendMailId((String)map.get("email"));


		return map;
	}

	@PostMapping(value="sendMail/pwd", produces="application/json; charset=utf-8")
	public Map<String, Object> sendMailPwd(@RequestBody Map<String, Object> map, HttpServletResponse res, HttpSession session, Model model) {
		System.out.println("MemLoginRestCont sendMailPwd 실행");
		System.out.println("id : " + map.get("inputId"));
		System.out.println("email : " + map.get("inputEmail"));
		Map<String, Object> result = ms.idEmailChk((String)map.get("inputId"),
									(String)map.get("inputEmail"));

		// 링크 접속시 제어를 위해 5분간 쿠키 및 세션 발급
		if ((int)result.get("result") == 1) {
			Cookie cookie = new Cookie("id", (String)result.get("encodeId"));
			cookie.setMaxAge(5 * 60);
			cookie.setPath("/root/member/login/searchPwd/modifyPwd");

			res.addCookie(cookie);

			session.setAttribute("inputId", map.get("inputId"));
			model.addAttribute(session);

		}

		result.remove("encodeId");

		return result;
	}

	@PostMapping(value="login/searchPwd/modifyPwd", produces="application/json; charset=utf-8")
	public Map<String, Object> modifyPwd(@RequestBody Map<String, Object> map, HttpSession session) {
		System.out.println("MemLoginRestCont modifyPwd 실행");
		System.out.println("session : " + session.getAttribute("inputId"));
		String id = (String)session.getAttribute("inputId");
//		session.removeAttribute("inputId");
		map = ms.modifyPwd((String)map.get("pwd"), id);

		return map;
	}







}
