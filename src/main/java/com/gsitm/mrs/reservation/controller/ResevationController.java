package com.gsitm.mrs.reservation.controller;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gsitm.mrs.reservation.dto.ReservationDTO;
import com.gsitm.mrs.reservation.service.ReservationService;
import com.gsitm.mrs.user.dto.EmployeeDTO;

/**
 * 예약 관련 프로젝트 Controller @RequestMapping("/reservation") URI 매칭
 * 
 * @Package : com.gsitm.mrs.reservation.controller
 * @date : 2019. 5. 2.
 * @author : 이종윤
 * 
 * @date : 2019. 5. 24.
 * @author : 김나윤
 */

@Controller
@RequestMapping("/reservation")
public class ResevationController {
	
	private static final Logger logger = LoggerFactory.getLogger(ResevationController.class);
	
	@Inject
	private ReservationService service;
	
	@RequestMapping(value = "/statusCalendar", method = RequestMethod.GET)
	public String statusCalendar(HttpSession session, String employeeNo, Model model) {
		
		logger.info("(사용자) 마이페이지 - 예약 현황 달력");
		
		Object user = session.getAttribute("login");
		EmployeeDTO employee = (EmployeeDTO) user;
		
		employeeNo = employee.getEmployeeNo();
		
		List<Map<String, Object>> reservationInfo = service.getReservationInfo(employeeNo);
		
		logger.info(reservationInfo+"");
		
		model.addAttribute("reservationInfo", reservationInfo);
		
		return "user/mypage/statusCalendar";
	}
	
	@RequestMapping(value = "/getCalendar", method = RequestMethod.GET)
	public String getCalendar(int reservationNo, Model model) {
		
		logger.info("(사용자) 마이페이지 - 캘린더 상세 정보");
		
		List<ReservationDTO> calendarInfo = service.getCalendarInfo(reservationNo);
		
		logger.info(calendarInfo+"");
		
		model.addAttribute("calendarInfo", calendarInfo);
		
		return "user/mypage/statusCalendar";
		
	}
	
	
	@RequestMapping(value = "/statusList", method = RequestMethod.GET)
	public String statusList(HttpSession session, String employeeNo, Model model) {
		
		logger.info("(사용자) 마이페이지 - 예약 현황 리스트");
		
		Object user = session.getAttribute("login");
		EmployeeDTO employee = (EmployeeDTO) user;
		
		employeeNo = employee.getEmployeeNo();
		
		List<Map<String, Object>> reservationList = service.getReservationList(employeeNo);
		
		logger.info(reservationList+"");
		
		model.addAttribute("reservationList", reservationList);
		
		return "user/mypage/statusList";
	}
	
	@RequestMapping(value = "/deleteReservation", method = RequestMethod.POST)
	public String deleteReservation(String reservationNo) throws Exception {

		 service.deleteReservation(Integer.parseInt(reservationNo));

		return "redirect:/reservation/statusList";
	}
	
	
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard() {
		
		logger.info("(사용자) 대시보드");
		
		return "user/dashboard/dashboard";
	}
	
	@RequestMapping(value = "/approvalWaitingList", method = RequestMethod.GET)
	public String approvalWaitingList(Model model) {
		
		logger.info("(관리자) 승인 대기 목록");
		
		List<Map<String, Object>> waitingList = service.getWaitingList();
		
		model.addAttribute("waitingList", waitingList);
		
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
	
	@RequestMapping(value = "/statistic", method = RequestMethod.GET)
	public String statistic() {
		
		logger.info("(관리자) 예약 통계");
		
		return "admin/reservation/statistic";
	}

	
	@RequestMapping(value = "/room", method = RequestMethod.GET)
	public String room() {
		
		logger.info("(사용자) 회의실 정보");
		
		return "user/reservation/room";
	}
	
	@RequestMapping(value = "/shortTerm_chooseDate/{roomNo}", method = RequestMethod.GET)
	public String chooseDate(@PathVariable int roomNo, Model model) {
		
		logger.info("(사용자) 예약-단기 예약 일자 선택");
		
		Map<String, Object> roomInfo=service.getRoomInfo(roomNo);
		List<Map<String, Object>> equipmentList=service.getEquipmentList(roomNo);
		
		model.addAttribute("roomInfo", roomInfo);
		model.addAttribute("equipmentList", equipmentList);
		
		return "user/reservation/shortTerm_chooseDate";
	}
	
	@RequestMapping(value = "/InputReservationInfo", method = RequestMethod.GET)
	public String InputReservationInfo(@ModelAttribute ReservationDTO reservationDto, 
			HttpServletRequest request, Model model) {
			
		logger.info("(사용자) 예약-예약 정보 입력");
		
		service.InputReservationInfo(request, reservationDto, model);
		System.out.println(reservationDto.toString());
		return "user/reservation/InputReservationInfo";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getChosungEmployeeList", method = RequestMethod.GET)
	public Map<String, Object> getChosungEmployeeList(@RequestParam char chosung) {
		
		logger.info("(사용자) 예약-초성에 해당하는 사원 목록 조회");
		// 사원번호, 이름 조회
		Map<String, Object> employeeList=new HashMap<>();
		
		return employeeList;
	}
}
