package com.gsitm.mrs.reservation.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.gsitm.mrs.reservation.dto.ReservationDTO;
import com.gsitm.mrs.reservation.service.ReservationService;
import com.gsitm.mrs.resource.service.ResourceService;
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
	
	@Inject
	private ResourceService resourceService;
	
	/* ------------- 사용자 ------------- */
	
	@RequestMapping(value = "/statusCalendar", method = {RequestMethod.GET, RequestMethod.POST})
	public String statusCalendar(HttpSession session, String employeeNo, Model model) {
		
		logger.info("(사용자) 마이페이지 - 예약 현황 달력");
		
		Object user = session.getAttribute("login");
		EmployeeDTO employee = (EmployeeDTO) user;
		
		employeeNo = employee.getEmployeeNo();
		
		List<Map<String, Object>> reservationInfo = service.getReservationInfo(employeeNo);
		List<Map<String, Object>> latestReservation = service.getLatestReservation(employeeNo);
		
		model.addAttribute("reservationInfo", reservationInfo);
		model.addAttribute("latestReservation", latestReservation);
		
		
		return "user/mypage/statusCalendar";
	}
	
	@RequestMapping(value = "/getCalendar", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getCalendar(int reservationNo, Model model) {
		
		logger.info("(사용자) 마이페이지 - 캘린더 상세 정보");
		
		Map<String, Object> calendarInfo = service.getCalendarInfo(reservationNo);
		
		logger.info(calendarInfo+"");
		
		return calendarInfo;
	}
	
	@RequestMapping(value = "/statusList", method = RequestMethod.GET)
	public String statusList(HttpSession session, String employeeNo, Model model) {
		
		logger.info("(사용자) 마이페이지 - 예약 현황 리스트");
		
		Object user = session.getAttribute("login");
		EmployeeDTO employee = (EmployeeDTO) user;
		
		employeeNo = employee.getEmployeeNo();
		
		List<Map<String, Object>> reservationList = service.getReservationList(employeeNo);
		
		model.addAttribute("reservationList", reservationList);
		
		return "user/mypage/statusList";
	}
	
	@RequestMapping(value="/updateStart", method = RequestMethod.POST)
	public String updateStart(String reservationNo, String status, String empNo) {
		
		System.err.println("updatesTratr"+ empNo);
		
		Map<String, Object> map = new HashMap<>();
				
		map.put("reservationNo", reservationNo);
		map.put("status", status);
		map.put("empNo", "it1226");
		
		service.updateStart(map);
		
		return "redirect:/reservation/statusList";
	}
	
	
	/**
	 * 예약 취소
	 * @param reservationNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cancelReservation", method = RequestMethod.POST)
	public String cancelReservation(String status, String reservationNo, String empNo, String reason, String name, String term, String reservationName) throws Exception {

		Map<String, Object> map = new HashMap<>();
		map.put("reservationNo", reservationNo);
		map.put("status", status);
		map.put("reason", reason);
		
		service.updateStatus(map);
		service.insertCancel(map);
		
		List<String> emailList = service.getEmailList(Integer.parseInt(reservationNo));
		
		String title = "[GS ITM] 회의실 예약 취소 안내";
		String email = StringUtils.join(emailList, ",");	// 해당 예약에 참여하는 사원의 이메일 목록 콤마(,)로 구분
		
		service.mailSend(empNo, email, title, name, reason, term, reservationName, "취소", "");

		return "redirect:/reservation/statusList";
	}
	
	@RequestMapping(value ="/statistic", method = RequestMethod.GET)
	public String statistic(HttpSession session, String employeeNo, Model model) {
		
		logger.info("(사용자) 마이페이지 - 예약 통계");
		
		return "user/mypage/statistic";
	}
	
	@RequestMapping(value = "/dashboard", method = RequestMethod.GET)
	public String dashboard(Model model, String roomNo) {
		
		logger.info("(사용자) 대시보드");
		
		return "user/dashboard/dashboard";
	}
	
	@RequestMapping(value="/getRoomDashBoard", method = RequestMethod.POST)
	public ModelAndView getRoomDashBoard(String roomNo) {
		
		logger.info("(사용자) 대시보드 - 탭 클릭");
		logger.info("roomNo : " + roomNo);
		
		List<Map<String, Object>> roomDashBoard = service.getDashBoard(Integer.parseInt(roomNo));
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("roomDashBoard", roomDashBoard);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	@RequestMapping(value = "/deleteBorEquip", method = RequestMethod.POST)
	public String deleteBorEquip(String reservationNo) {
		
		service.deleteBorEquip(Integer.parseInt(reservationNo));

		return "redirect:/reservation/statusCalendar";
	}
	
	@RequestMapping(value="/getOne", method = RequestMethod.POST)
	public ModelAndView getOne(String employeeNo) {
		
		Map<String, Object> one = service.getOne(employeeNo);
		
		logger.info(employeeNo);
		logger.info(one+"");
		
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("one", one);
		mav.setViewName("jsonView");
		
	
		
		return mav;
	}
	
	
	@RequestMapping(value = "/room", method = RequestMethod.GET)
	public String room(Model model) {
		logger.info("(사용자) 회의실 정보");
		
		List<Map<String, Object>> roomList = resourceService.getRoomList();
		List<String> equipmentList = resourceService.getEquipmentListDistinct();

		model.addAttribute("roomList", roomList);
		model.addAttribute("equipDistinctList", equipmentList);
		
		return "user/reservation/room";
	}
	
	@RequestMapping(value = "/chooseDate/{roomNo}", method = RequestMethod.GET)
	public String ChooseDate(@PathVariable int roomNo, Model model, HttpServletRequest request) {
		logger.info("(사용자) 예약 - 예약 일자 선택");
		
		// 뒤로 가기를 통해 이 페이지에 돌아온 경우 미리 선택한 예약 정보를 저장하는 map
		Map<String, Object> savedRoomInfo=new HashMap<>();
		if(request.getParameter("startDate")!=null) {
			savedRoomInfo.put("startDate", request.getParameter("startDate"));
			savedRoomInfo.put("endDate", request.getParameter("endDate"));
			savedRoomInfo.put("snackWant", request.getParameter("snackWant"));
			savedRoomInfo.put("equipments", request.getParameter("equipments"));
			model.addAttribute("savedRoomInfo", savedRoomInfo);
		}
		
		service.chooseDate(model, roomNo);
		
		return "user/reservation/chooseDate";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getEmployeeListByChosung", method = RequestMethod.GET)
	public Map<String, Object> getEmployeeListByChosung(@RequestParam String chosung) {
		
		logger.info("(사용자) 예약-초성에 해당하는 사원 목록 조회");
		// 사원번호, 이름 조회
		Map<String, Object> employeeList=new HashMap<>();
		employeeList.put("employeeList", service.getEmployeeListByChosung(chosung));
		return employeeList;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getEmployeeListBySearching", method = RequestMethod.GET)
	public Map<String, Object> getEmployeeListBySearching(@RequestParam String keyword) {
		
		logger.info("(사용자) 예약 - 검색 키워드에 해당하는 사원 목록 조회");
		// 사원번호, 이름 조회
		Map<String, Object> employeeList=new HashMap<>();
		employeeList.put("employeeList", service.getEmployeeListBySearching(keyword));
		return employeeList;
	}

	@ResponseBody
	@RequestMapping(value = "/getDepartmentList", method = RequestMethod.GET)
	public Map<String, Object> getDepartmentList(@RequestParam List<String> employeeNoArr,
												 @RequestParam List<String> mainDeptList){
		logger.info("(사용자) 예약 - 사원들의 부서 목록 조회");
		// 사원번호, 이름 조회
		Map<String, Object> map=new HashMap<>();
		map.put("departmentList", service.getDepartmentList(employeeNoArr, mainDeptList));
		return map;
	}
	
	@RequestMapping(value="/checkReservationInfo", method=RequestMethod.GET)
	public String checkReservation(HttpServletRequest request, Model model) {
		
		logger.info("(사용자) 예약 - 회의실 예약 정보 입력 내역 조회");
		
		service.checkReservationInfo(request, model);
		return "user/reservation/checkReservationInfo";
	}
	
	@RequestMapping(value="/doReserve", method=RequestMethod.POST)
	@ResponseBody
	public void doReserve(@RequestBody Map<String, Object> reserveData){
		
		logger.info("(사용자) 예약 - 회의실 예약 정보 DB에 insert");
		
		service.doReserve(reserveData);
	}
	
	@RequestMapping(value="/getParticipations", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getParticipations(@RequestParam(value="participationNos") List<String> participationNos){
		System.out.println(participationNos);
		logger.info("(사용자) 예약 - 사원번호로 회의 참여자 정보 얻어오기");
		
		Map<String, Object> result=new HashMap<>();
		result.put("participations", service.getParticipations(participationNos));
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/getReservationsByDate", method=RequestMethod.GET)
	public Map<String, Object> getReservationsByDate(String roomNo, String chosenDate){
		
		logger.info("(사용자) 예약 - 해당 날짜에 예약된 정보 얻어오기");
		
		Map<String, Object> roomData=new HashMap<>();
		roomData.put("roomNo", Integer.parseInt(roomNo));
		roomData.put("chosenDate", chosenDate);
		
		Map<String, Object> result=new HashMap<>();
		result.put("reservations", service.getReservationsByDate(roomData));
		return result;
	}
	
	@RequestMapping(value = "/InputReservationInfo", method = RequestMethod.GET)
	public String InputReservationInfo(@ModelAttribute ReservationDTO reservationDto, 
			HttpServletRequest request, Model model) {
		logger.info("(사용자) 예약 - 예약 정보 입력");
		
		service.InputReservationInfo(request, reservationDto, model);
		return "user/reservation/InputReservationInfo";
	}
		
	/* ------------- 관리자 ------------- */
	
	/**
	 * (관리자) 승인 대기 목록 조회 페이지 
	 * 
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
	 * 예약 상위결재자 승인
	 * 
	 * @param reservationNo	승인할 예약 번호
	 * @return
	 */
	@RequestMapping(value = "/mgrApproval", method = RequestMethod.POST)
	public String mgrApproval(String reservationNo) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("reservationNo", reservationNo);
		map.put("mgrApproval", "Y");
		
		service.updateMgrApproval(map);
		
		return "redirect:/reservation/approvalWaitingList";
	}
	
	/**
	 * 예약 관리자 승인
	 *
	 * @param status
	 * @param reservationNo
	 * @return
	 */
	@RequestMapping(value = "/adminApproval", method = RequestMethod.POST)
	public String adminApproval(String status, String reservationNo) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("reservationNo", reservationNo);
		map.put("status", status);
		map.put("adminApproval", "Y");
		
		service.updateStatus(map);
		service.updateAdminApproval(map);
		
		return "redirect:/reservation/approvalWaitingList";
	}
	
	/**
	 * 상위결재자 예약 반려
	 * 
	 * @param status
	 * @param reservationNo
	 * @param reason
	 * @return
	 */
	@RequestMapping(value = "/mgrRefuse", method = RequestMethod.POST)
	public String mgrRefuse(String status, String reservationNo, String reason) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("reservationNo", reservationNo);
		map.put("status", status);
		map.put("mgrApproval", "N");
		map.put("reason", reason);
		
		System.out.println("상위결재자 예약 반려 > " + map);
		
		service.updateStatus(map);
		service.updateMgrApproval(map);
		service.insertRefuse(map);
		
		return "redirect:/reservation/approvalWaitingList";
	}
	
	/**
	 * 관리자 예약 반려
	 * 
	 * @param status		예약 상태 (반려 : 2)
	 * @param reservationNo	예약 번호
	 * @param reason		반려 사유
	 * @return
	 */
	@RequestMapping(value = "/adminRefuse", method = RequestMethod.POST)
	public String adminRefuse(String status, String reservationNo, String empNo, String reason, String email, String name, String term, String reservationName) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("reservationNo", reservationNo);
		map.put("status", status);
		map.put("adminApproval", "N");
		map.put("reason", reason);
		
		service.updateStatus(map);
		service.updateAdminApproval(map);
		service.insertRefuse(map);
		
		String title = "[GS ITM] 회의실 예약 반려 안내";
		
		service.mailSend(empNo, email, title, name, reason, term, reservationName, "반려", "http://localhost/reservation/statusList");
		
		return "redirect:/reservation/approvalWaitingList";
	}
	
	/**
	 * (관리자) 승인 반려 목록 조회 페이지 
	 *
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
	 * (관리자) 예약 완료 목록 조회 페이지 
	 * 
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
	 * (관리자) 예약 취소 목록 조회 페이지
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/reservationCancelList", method = RequestMethod.GET)
	public String reservationCancelList(Model model) {
		
		logger.info("(관리자) 예약 취소 목록");
		
		List<Map<String, Object>> reservationCancelList = service.getReservationCancelList();
		
		model.addAttribute("reservationCancelList", reservationCancelList);
		
		return "admin/reservation/reservationCancelList";
	}
}
