package com.gsitm.mrs.user.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void login(EmployeeDTO employee,HttpSession session, Model model) throws Exception {
		
		EmployeeDTO isUser = service.login(employee);
		
		if (isUser == null) {
			return;
		}
		model.addAttribute("user", isUser);
	}

}
