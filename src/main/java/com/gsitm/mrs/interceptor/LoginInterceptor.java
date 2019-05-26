package com.gsitm.mrs.interceptor;

import java.net.URLEncoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.gsitm.mrs.user.dto.EmployeeDTO;

/**
 * 로그인 유지를 위한 필터 역할을 해주는 인터셉터 preHandle 메소드, postHandle 메소드 활용
 * 
 * @Package : com.gsitm.mrs.interceptor
 * @date : 2019. 5. 22.
 * @author : 이종윤
 */
public class LoginInterceptor extends HandlerInterceptorAdapter {

	private static final String LOGIN = "login";
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		
		Object user = session.getAttribute(LOGIN);
		Cookie empNoCookie = WebUtils.getCookie(request, "empNoCookie");

		if (user != null) {
			EmployeeDTO employee = (EmployeeDTO) user;
			
			if (empNoCookie != null) {
				empNoCookie.setPath("/");
				empNoCookie.setMaxAge(0);
				response.addCookie(empNoCookie);
//				service.keepLogin(user.getId(), session.getId(), new Date(0));
			}
			return false;
		}

		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

		HttpSession session = request.getSession();

		ModelMap modelMap = modelAndView.getModelMap();
		Object user = modelMap.get("user");

		if (user == null) {
			logger.info("로그인 오류");
			response.sendRedirect("/?result=error");
		} else {
			logger.info("새로운 로그인! >> " + user.toString());
			session.setAttribute(LOGIN, user);
			
			//TODO : 자동 로그인 (useCookie) 기능 구현하기!
			if (request.getParameter("useCookie") != null) {
				
				Cookie loginCookie = new Cookie("loginCookie", session.getId());
				loginCookie.setPath("/");
				loginCookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(loginCookie);
			}
			
			/* 쿠키에 아이디 저장 */
			EmployeeDTO userCookie = (EmployeeDTO) user;
			Cookie empNoCookie = new Cookie("empNoCookie", userCookie.getEmployeeNo());
			empNoCookie.setPath("/");
			empNoCookie.setMaxAge(60 * 60 * 24 * 7);
			response.addCookie(empNoCookie);

			/* 쿠키에 이름 저장 */
			Cookie empNameCookie = new Cookie("empNameCookie", URLEncoder.encode(userCookie.getName(), "utf-8"));
			empNameCookie.setPath("/");
			empNameCookie.setMaxAge(60 * 60 * 24 * 7);
			response.addCookie(empNameCookie);

			response.sendRedirect("/reservation/statusCalendar");
		}

	}

}
