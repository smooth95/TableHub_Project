package com.hub.root.member.controller.info;

import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hub.root.member.dto.MemberDTO;
import com.hub.root.member.service.info.MemberInfoService;

@Controller
@RequestMapping("member/myPage")
public class MemberInfoController {
	@Autowired MemberInfoService mis;

	@GetMapping("info")
	public String memberInfo(HttpSession session, Model model, HttpServletRequest req, HttpServletResponse res) {
    	System.out.println("memInfoCont info 실행");
		String id = (String)session.getAttribute("userId");

		String loginType = id.split("=")[0];

		// 사용자가 네이버 로그인일 경우 바로 마이페이지로 이동
		if (loginType.equals("N")) {
			Cookie cook = new Cookie("myPage", id);
			cook.setPath("/root/member");
			res.addCookie(cook);

			return "redirect:detail";

		// 사용자가 로컬로그인 사용자이면 패스워드 확인 페이지로 이동
		} else {
			return "member/info/pwdCheck";
		}
	}

	@GetMapping("detail")
	public String detail (HttpSession session, HttpServletRequest req, Model model) {
    	System.out.println("memInfoCont detail 실행");
		MemberDTO dto = mis.getMemberInfo((String)session.getAttribute("userId"));
		model.addAttribute(session);
		model.addAttribute("dto", dto);
		return "member/info/detail";

	}

	@GetMapping("download")
	public void download(@RequestParam String img, HttpServletResponse res) throws Exception {
    	System.out.println("memInfoCont download 실행");
    	String originImgName = null;
    	if (img.split("_").length > 1) {
    		originImgName = img.split("_")[1];
    	} else {
    		originImgName = img;
    	}
		res.setContentType("text/plain; charset=utf-8");
		res.addHeader("Content-disposition", "attachment;fileName="+URLEncoder.encode(img, "UTF-8"));
		File file;

		// 파일을 변경한 적이 없으면 기본적으로 default로 저장됨. defualt파일을 다운로드한다.
		if (originImgName.equals("default.jpg") || originImgName.equals("default")) {
			file = new File(MemberInfoService.IMAGE_REPO + "/default.jpg");
		} else {

			// 파일을 변경했으면 해당 이름으로 저장이되고 형식은 아이디_파일명 으로 저장된다.
			// 해당 파일을 불러온다.

			file = new File(MemberInfoService.IMAGE_REPO + "/" + img);
		}
		// 파일이 존재한다면 해당 파일을 사용자에게 전달한다.
		if(file.exists()) {
			FileInputStream in = new FileInputStream(file);
			FileCopyUtils.copy(in, res.getOutputStream());
			in.close();
		}
	}

	@GetMapping("myBooking")
	public String myBooking(Model model, HttpSession session) {
    	System.out.println("memInfoCont myBooking 실행");
		model.addAttribute(session);
		return "member/info/myBooking";
	}

	@GetMapping("deleteUser")
	public String deleteUser(HttpSession session, Model model) {
    	System.out.println("memInfoCont deleteUser 실행");
		String id = (String) session.getAttribute("userId");

		String loginType = id.split("=")[0];

    	model.addAttribute("loginType", loginType);

		return "member/info/deleteUser";
	}

	@GetMapping("myReview")
	public String myReview() {
    	System.out.println("memInfoCont myReview 실행");

		return "member/info/myReview";
	}

	@GetMapping("myBoard")
	public String myBoard() {
    	System.out.println("memInfoCont myBoard 실행");

		return "member/info/myBoard";
	}

	@GetMapping("myReply")
	public String myReply() {
    	System.out.println("memInfoCont myReply 실행");

		return "member/info/myReply";
	}
	
	

	
	
}
