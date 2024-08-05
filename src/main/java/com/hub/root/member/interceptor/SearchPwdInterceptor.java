package com.hub.root.member.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class SearchPwdInterceptor extends HandlerInterceptorAdapter {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("index 실행 전 출력");
		Cookie[] cookies = request.getCookies();
		String test = request.getParameter("id");
		System.out.println("test : " + test);

		String id = "";
		if (cookies != null) {
			for (Cookie c : cookies) {
				if ( c.getName().equals("id")) {
					id = c.getValue();
				}
			}
		}

		if( id.equals("") ) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print("<script>alert('정상적인 접근이 아닙니다.');"
						+"location.href='/root/main/mainPage1';</script>");
			return false;
		}
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		System.out.println("index 실행 후 동작");
	}

}
