package com.gsitm.mrs.user.controller;

import java.util.Map;

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
	public String login(EmployeeDTO employee, HttpSession session, Model model) throws Exception {
		
		Object isUser;
		Map<String, Object> admin;

		/* 관리자 로그인 */
		if (employee.getEmployeeNo().contains("admin")) {
			admin = service.loginAdmin(employee);
			isUser = service.getInfo((String) admin.get("EMPLOYEENO"));
			
			if (isUser != null) session.setAttribute("adminId", admin.get("ADMINID"));
			
		/* 회원 로그인 */	
		} else {
			isUser = service.login(employee);
		}

		/* 로그인 실패 */
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
	public String logout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
			throws Exception {

		Object obj = session.getAttribute("login");

		if (obj != null) {

			session.removeAttribute("login");
			session.invalidate();

			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			Cookie empNoCookie = WebUtils.getCookie(request, "empNoCookie");
			Cookie empNameCookie = WebUtils.getCookie(request, "empNameCookie");

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

			if (empNameCookie != null) {
				empNameCookie.setPath("/");
				empNameCookie.setMaxAge(0);
				response.addCookie(empNameCookie);
			}
		}

		return "redirect:/";
	}

}
