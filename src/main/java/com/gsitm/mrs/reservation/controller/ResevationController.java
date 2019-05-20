package com.gsitm.mrs.reservation.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * 예약 관련 프로젝트 Controller @RequestMapping("/reservation") URI 매칭
 * 
 * @Package : com.gsitm.mrs.reservation.controller
 * @date : 2019. 5. 2.
 * @author : 이종윤
 * 
 */

@Controller
@RequestMapping("/reservation")
public class ResevationController {
	
	private static final Logger logger = LoggerFactory.getLogger(ResevationController.class);
	
	@RequestMapping(value = "/statusCalendar", method = RequestMethod.GET)
	public String statusCalendar(Model model) {
		
		logger.info("(사용자) 마이페이지 - 예약 현황 달력");
		
		return "user/mypage/statusCalendar";
	}
	
	@RequestMapping(value = "/statusList", method = RequestMethod.GET)
	public String statusList() {
		
		logger.info("(사용자) 마이페이지 - 예약 현황 리스트");
		
		return "user/mypage/statusList";
	}
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard() {
		
		logger.info("(사용자) 대시보드");
		
		return "user/dashboard/dashboard";
	}
	
	@RequestMapping(value = "/approvalWaitingList", method = RequestMethod.GET)
	public String approvalWaitingList() {
		
		logger.info("(관리자) 승인 대기 목록");
		
		return "admin/reservation/approvalWatingList";
	}
	
	@RequestMapping(value = "/approvalCancelList", method = RequestMethod.GET)
	public String approvalCancelList() {
		
		logger.info("(관리자) 승인 반려 목록");
		
		return "admin/reservation/approvalCancelList";
	}
	
	@RequestMapping(value = "/reservationSuccessList", method = RequestMethod.GET)
	public String reservationSuccessList() {
		
		logger.info("(관리자) 예약 완료 목록");
		
		return "admin/reservation/reservationSuccessList";
	}
	
	@RequestMapping(value = "/reservationCancelList", method = RequestMethod.GET)
	public String reservationCancelList() {
		
		logger.info("(관리자) 예약 취소 목록");
		
		return "admin/reservation/reservationCancelList";
	}
	
}
