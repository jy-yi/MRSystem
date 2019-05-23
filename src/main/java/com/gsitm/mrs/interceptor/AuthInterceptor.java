package com.gsitm.mrs.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		
		if (session.getAttribute("login") == null) {
			logger.info("현재 유저는 로그인하지 않았습니다.");
			response.sendRedirect("/");
			
			return false;
		}
		
		// 로그인 한 유저가 "/" (로그인 페이지)으로 강제 이동할 경우를 대비하여 현재 URL 주소 저장
		session.setAttribute("prevURL", request.getRequestURI());
		
		return true;
	}
}
