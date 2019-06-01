package com.gsitm.mrs.reservation.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.gsitm.mrs.reservation.dto.ReservationDTO;
import com.gsitm.mrs.reservation.service.ReservationService;
import com.gsitm.mrs.user.dto.EmployeeDTO;

/**
 * 예약 관련 프로젝트 Controller @RequestMapping("/reservation") URI 매칭
 * 
 * @Package : com.gsitm.mrs.reservation.controller
 * @date : 2019. 5. 2 ~.
 * @author : 이종윤
 * 
 * @date : 2019. 5. 24 ~.
 * @author : 김나윤
 * 
 *  * @date : 2019. 5. 29 ~.
 * @author : 김재율
 */

@Controller
@RequestMapping("/reservation")
public class ResevationController {
	
	private static final Logger logger = LoggerFactory.getLogger(ResevationController.class);
	
	@Inject
	private ReservationService service;
	
	
	/* ------------- 사용자 ------------- */
	
	@RequestMapping(value = "/statusCalendar", method = RequestMethod.GET)
	public String statusCalendar(HttpSession session, Model model) {
		
		logger.info("(사용자) 마이페이지 - 예약 현황 달력");
		
		Object user = session.getAttribute("login");
		EmployeeDTO employee = (EmployeeDTO) user;
		
		String employeeNo = employee.getEmployeeNo();
		
		List<Map<String, Object>> reservationInfo = service.getReservationInfo(employeeNo);
		
		logger.info(reservationInfo+"");
		
		model.addAttribute("reservationInfo", reservationInfo);
		
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
	
	@RequestMapping(value = "/room", method = RequestMethod.GET)
	public String room() {
		
		logger.info("(사용자) 회의실 정보");
		
		return "user/reservation/room";
	}
	
	@RequestMapping(value = "/shortTerm_chooseDate/{roomNo}", method = RequestMethod.GET)
	public String chooseDate(@PathVariable int roomNo, Model model) {
		
		//logger.info("(사용자) 예약-단기 예약 일자 선택");
		
		Map<String, Object> roomInfo=service.getRoomInfo(roomNo);
		List<Map<String, Object>> equipmentList=service.getEquipmentList(roomNo);
		
		model.addAttribute("roomInfo", roomInfo);
		model.addAttribute("equipmentList", equipmentList);
		
		return "user/reservation/shortTerm_chooseDate";
	}
	
	@RequestMapping(value = "/InputReservationInfo", method = RequestMethod.GET)
	public String InputReservationInfo(@ModelAttribute ReservationDTO reservationDto, 
			@RequestParam int roomNo, HttpServletRequest request, @RequestParam String equipments) {
		
		//logger.info("(사용자) 예약-예약 정보 입력");
		
		//Map<String, Object> roomInfo=service.getRoomInfo(roomNo);
		System.out.println(reservationDto.toString());
		
		System.out.println(request.getParameter("equipments"));
		System.out.println("비품 목록  : "+equipments);
		//model.addAttribute("roomInfo", roomInfo);
		return "";
	}
	
	
	/* ------------- 관리자 ------------- */
	
	
	/**
	 * 관리자용 승인 대기 목록 페이지
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/approvalWaitingList", method = RequestMethod.GET)
	public String approvalWaitingList(Model model) {
		
		logger.info("(관리자) 승인 대기 목록");
		
		List<Map<String, Object>> waitingList = service.getWaitingList();
		
		model.addAttribute("waitingList", waitingList);
		
		return "admin/reservation/approvalWatingList";
	}
	
	/**
	 * 관리자용 승인 반려 목록 페이지
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/approvalCancelList", method = RequestMethod.GET)
	public String approvalCancelList(Model model) {
		
		logger.info("(관리자) 승인 반려 목록");
		
		List<Map<String, Object>> approvalCancelList = service.getApprovalCancelList();
		
		model.addAttribute("approvalCancelList", approvalCancelList);
		
		return "admin/reservation/approvalCancelList";
	}
	
	/**
	 * 관리자용 예약 완료 목록 페이지
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/reservationSuccessList", method = RequestMethod.GET)
	public String reservationSuccessList(Model model) {
		
		logger.info("(관리자) 예약 완료 목록");
		
		List<Map<String, Object>> successList = service.getSuccessList();
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date date = new Date();
		String today = dateFormat.format(date);
		
		for (int i = 0; i < successList.size(); i++) {
			Map<String, Object> map = successList.get(i);
			String startDate = (String) map.get("STARTDATE");
			String endDate = (String) map.get("ENDDATE");
			
			if (today.compareTo(startDate) < 0) {
				map.put("STATUS", 0);	// 미사용
			}
			
			if (today.compareTo(startDate) > 0 && today.compareTo(endDate) < 0) {
				map.put("STATUS", 1);	// 사용 중
			}
			
			if (today.compareTo(endDate) > 0) {
				map.put("STATUS", 2);	// 사용 완료
			}
		}
		
		model.addAttribute("successList", successList);
		
		return "admin/reservation/reservationSuccessList";
	}
	
	/**
	 * 관리자용 예약 취소 목록 페이지
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/reservationCancelList", method = RequestMethod.GET)
	public String reservationCancelList(Model model) {
		
		logger.info("(관리자) 예약 취소 목록");
		
		return "admin/reservation/reservationCancelList";
	}
	
	@RequestMapping(value = "/statistic", method = RequestMethod.GET)
	public String statistic(Model model) {
		
		logger.info("(관리자) 예약 통계");
		
		return "admin/reservation/statistic";
	}
}
