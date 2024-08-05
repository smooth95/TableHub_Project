package com.hub.root.member.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class MemberInfoInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("interceptor 실행");
		Cookie[] cookies = request.getCookies();

		// info페이지로 접근하기 위해서 로그인 한 기록이 있는지 확인하는 인터셉터
		// 한번 로그인했던 기록이 있으면 myPage라는 쿠키값이 생성되고 해당 값이 있는지를 확인 후
		// 다시 접근하려하면 비밀번호를 물어보지 않고 info페이지로 이동시킨다.

		String cook = "";
		// 생성된 쿠키값이 있다면 실행
		if (cookies != null) {
			for(Cookie c : cookies) {
				// 쿠키이름이 myPage와 같다면 cook에 쿠키값을 대입
				if (c.getName().equals("myPage")) {
					cook = c.getValue();
					break;
				}
			}
		}
		response.setContentType("text/html; charset=utf-8");

		// cookie값이 없다면 if문 실행
		if (cook == "") {
			System.out.println("if문실행");
			PrintWriter out = response.getWriter();

			// myPage라는 쿠키가 없으면 패스워드 확인 페이지로 이동(memInfoCont info 메서드)
			out.print("<script>location.href='/root/member/myPage/info';</script>");
			out.close();
			return false;
		} else {
			System.out.println("else문실행");

			// 쿠키값이 기존에 있다면 쿠키의 시간을 초기화하고 다시 내보낸다.
			if (cookies != null) {
				for(Cookie c : cookies) {
					if (c.getName().equals("myPage")) {
						c.setMaxAge(5 * 60);
						c.setPath("/root/member");
						response.addCookie(c);
						break;
					}
				}
			}
			return true;
		}



//		// cookie이 없다면 if문 실행
//		if (cook == "") {
//			PrintWriter out = response.getWriter();
//			// myPage라는 쿠키가 없으면 컨트롤러로 이동
//			out.print("<script>location.href='/root/member/myPage/info';</script>");
//			out.close();
//			return false;
//		} else {
//			if (cookies != null) {
//				for(Cookie c : cookies) {
//					if (c.getName().equals("myPage")) {
//						c.setMaxAge(5 * 60);
//						response.addCookie(c);
//						break;
//					}
//				}
//			}
//			return true;
//		}


	}

}
