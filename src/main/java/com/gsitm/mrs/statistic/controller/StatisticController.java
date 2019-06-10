package com.gsitm.mrs.statistic.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.gsitm.mrs.statistic.service.StatisticService;
import com.gsitm.mrs.user.dto.DepartmentDTO;
import com.gsitm.mrs.user.service.UserService;

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
	
	@Inject
	private StatisticService statisticService;
	
	@Inject
	private UserService userService;
	
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage(Model model) {
		
		logger.info("사용자 - 예약 통계");
		
		return "user/mypage/statistic";
	}
	
	/**
	 * (관리자) 예약 통계 페이지
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/statistic", method = RequestMethod.GET)
	public String statusCalendar(Model model) {
		
		logger.info("관리자 - 예약 통계");
		
		List<DepartmentDTO> departmentList = userService.getDepartmentList();
		
		model.addAttribute("departmentList", departmentList);
		
		return "admin/statistic/statistic";
	}
	
	
	@RequestMapping(value = "/getReservationList", method = RequestMethod.POST)
	public ModelAndView getReservationList(Model model, String workplaceNo) {

		List<Map<String, Object>> reservationList = statisticService.getReservationList(Integer.parseInt(workplaceNo));

		ModelAndView mav = new ModelAndView();
		mav.addObject("reservationList", reservationList);
		mav.setViewName("jsonView");

		return mav;
	}

	
}
