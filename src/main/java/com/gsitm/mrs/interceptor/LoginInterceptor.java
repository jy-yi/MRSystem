package com.gsitm.mrs.interceptor;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
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

import com.gsitm.mrs.resource.dto.WorkplaceDTO;
import com.gsitm.mrs.resource.service.ResourceService;
import com.gsitm.mrs.user.dto.AdminDTO;
import com.gsitm.mrs.user.dto.EmployeeDTO;
import com.gsitm.mrs.user.service.UserService;

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
	
	@Inject
	private UserService userService;
	
	@Inject
	private ResourceService resourceService;	

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		HttpSession session = request.getSession();
		
		Object user = session.getAttribute(LOGIN);
		
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		
		if (loginCookie != null) {
			user = userService.getInfo(loginCookie.getValue());
			
			logger.info("자동 로그인! >> " + user.toString());
			
			session.setAttribute(LOGIN, user);
		}

		/* 지사 목록 동적 연동을 위해 세션에 저장 */
		List<WorkplaceDTO> workplaceList = resourceService.getWorkplaceList();
		session.setAttribute("workplaceList", workplaceList);
		
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
			
			EmployeeDTO userCookie = (EmployeeDTO) user;
			
			/* 자동 로그인 */
			if (request.getParameter("useCookie") != null) {
				logger.info("로그인 Remember me!");
				
				Cookie loginCookie = new Cookie("loginCookie", userCookie.getEmployeeNo());
				loginCookie.setPath("/");
				loginCookie.setMaxAge(60 * 60 * 24 * 7);
				response.addCookie(loginCookie);
			}
			
			/* 쿠키에 아이디 저장 */
			Cookie empNoCookie = new Cookie("empNoCookie", userCookie.getEmployeeNo());
			empNoCookie.setPath("/");
			empNoCookie.setMaxAge(60 * 60);
			response.addCookie(empNoCookie);

			/* 쿠키에 이름 저장 */
			Cookie empNameCookie = new Cookie("empNameCookie", URLEncoder.encode(userCookie.getName(), "utf-8"));
			empNameCookie.setPath("/");
			empNameCookie.setMaxAge(60 * 60);
			response.addCookie(empNameCookie);

			/* 일반 회원일 경우 */
			if (session.getAttribute("adminId") == null) 
				response.sendRedirect("/reservation/statusCalendar");
			/* 관리자일 경우 */
			else
				response.sendRedirect("/reservation/dashboard");
		}

	}

}
