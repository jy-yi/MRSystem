package com.gsitm.mrs.resource.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 자원 관련 프로젝트 Controller @RequestMapping("/reservation") URI 매칭
 * 
 * @Package : com.gsitm.mrs.resource.controller
 * @date : 2019. 5. 8.
 * @author : 이종윤
 * 
 */
@Controller
@RequestMapping("/resource")
public class ResourceController {
	
private static final Logger logger = LoggerFactory.getLogger(ResourceController.class);
	
	@RequestMapping(value = "/workplaceList", method = RequestMethod.GET)
	public String workplaceList() {
		
		logger.info("(관리자) 지사 관리");
		
		return "admin/resource/workplaceList";
	}
	
	@RequestMapping(value = "/roomList", method = RequestMethod.GET)
	public String roomList() {
		
		logger.info("(관리자) 회의실 관리");
		
		return "admin/resource/roomList";
	}

	@RequestMapping(value = "/equipmentList", method = RequestMethod.GET)
	public String equipmentList() {
		
		logger.info("(관리자) 비품 관리");
		
		return "admin/resource/equipmentList";
	}
}
