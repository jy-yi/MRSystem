package com.gsitm.mrs.statistic.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 통계 관련 프로젝트 Controller @RequestMapping("/statistic") URI 매칭
 * 
 * @Package : com.gsitm.mrs.statistic
 * @date : 2019. 5. 2.
 * @author : 이종윤
 */

@Controller
@RequestMapping("/statistic")
public class StatisticController {

	private static final Logger logger = LoggerFactory.getLogger(StatisticController.class);
	
	@RequestMapping(value = "/statistic", method = RequestMethod.GET)
	public String statusCalendar(Model model) {
		
		logger.info("마이페이지 - 예약 통계");
		
		return "admin/statistic/statistic";
	}
	

	
}
