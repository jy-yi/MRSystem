package com.gsitm.mrs.user.controller;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.util.WebUtils;

import com.gsitm.mrs.user.dto.EmployeeDTO;
import com.gsitm.mrs.user.service.UserService;

/**
 * 회원 관련 프로젝트 Controller @RequestMapping("/user") URI 매칭
 * 
 * @Package : com.gsitm.mrs.user.controller
 * @date : 2019. 5. 2.
 * @author : 이종윤
 */

@Controller
@RequestMapping("/user")
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Inject
	private UserService service;
	
	/**
	 * 로그인 
	 * 
	 * @Method Name : login
	 * @param employee
	 * @param session
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(EmployeeDTO employee,HttpSession session, Model model) throws Exception {
		
		EmployeeDTO isUser = service.login(employee);
		
		if (isUser == null) {
			return "login";
		}
		model.addAttribute("user", isUser);
		
		return "login";
	}
	
	/**
	 * 로그아웃
	 *
	 * @Method Name : logout
	 * @param request
	 * @param response
	 * @param session
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout (HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		
		Object obj = session.getAttribute("login");
		
		if (obj != null) {
			
			session.removeAttribute("login");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			Cookie empNoCookie = WebUtils.getCookie(request, "empNoCookie");
			
			if (loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				response.addCookie(loginCookie);
			}
			
			if (empNoCookie != null) {
				empNoCookie.setPath("/");
				empNoCookie.setMaxAge(0);
				response.addCookie(empNoCookie);
			}
		}
		
		return "redirect:/";
	}


}
