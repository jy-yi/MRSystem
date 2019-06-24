package com.gsitm.mrs.statistic.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.gsitm.mrs.resource.dto.RoomDTO;
import com.gsitm.mrs.statistic.service.StatisticService;
import com.gsitm.mrs.user.dto.DepartmentDTO;
import com.gsitm.mrs.user.dto.EmployeeDTO;
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
	private StatisticService service;
	
	@Inject
	private UserService userService;
	
	/* ------------- 사용자 ------------- */
	 
	@RequestMapping(value = "/mypage", method = {RequestMethod.GET})
	public String mypage(HttpSession session, Model model) {
		
		logger.info("사용자 - 예약 통계 페이지");
		
		return "user/mypage/statistic";
	}
	
	/** 전체 예약 통계 검색 */
	@RequestMapping(value = "/getUserAllList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> getUserAllList(HttpSession session, Model model) {
		
		logger.info("사용자 - 전체 리스트");
		
		Object user = session.getAttribute("login");
		EmployeeDTO employee = (EmployeeDTO) user;
		
		List<Map<String, Object>> userAllList = service.getUserAllList(employee.getEmployeeNo());
		Map<String, Object> getIndividual = service.getIndividual(employee.getEmployeeNo());
		Map<String, Object> getDepartment = service.getDepartment(employee.getEmployeeNo());
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("userAllList", userAllList);
		map.put("getIndividual", getIndividual);
		map.put("getDepartment", getDepartment);
		
		logger.info(getIndividual+"");
		logger.info(getDepartment+"");
		
		return map;
	}
	
	/** 날짜 선택하여 예약 통계 검색 */
	@RequestMapping(value = "/getUserSearchList", method = RequestMethod.POST)
	public ModelAndView getUserSearchList(HttpSession session, String startDate, String endDate) {

		logger.info("사용자 - 검색 리스트");
		
		Object user = session.getAttribute("login");	
		EmployeeDTO employee = (EmployeeDTO) user;
		
		logger.info(employee.getEmployeeNo() +","+startDate +", " +endDate);
		
		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("employeeNo", employee.getEmployeeNo());
		searchMap.put("startDate", startDate);
		searchMap.put("endDate", endDate);
		
		List<Map<String, Object>> userSearchList = service.getUserSearchList(searchMap);
		Map<String, Object> getIndividualDate = service.getIndividualDate(searchMap);
		Map<String, Object> getDepartmentDate = service.getDepartmentDate(searchMap);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("userSearchList", userSearchList);
		mav.addObject("getIndividualDate", getIndividualDate);
		mav.addObject("getDepartmentDate", getDepartmentDate);
		mav.setViewName("jsonView");
		
		logger.info(mav+"");
		//logger.info((String) mav.getModel().get(getIndividualDate.size()));
		//logger.info(getIndividualDate.size() +", " + getDepartmentDate.size());
		
		return mav;
	}
	
	/* ------------- 관리자 ------------- */
	
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
	
	/**
	 * 지사별 전체 예약 목록 조회
	 * 
	 * @param workplaceNo	조회할 지사 번호
	 * @return
	 */
	@RequestMapping(value = "/getReservationList", method = RequestMethod.POST)
	public ModelAndView getReservationList(String workplaceNo) {

		List<Map<String, Object>> reservationList = service.getReservationList(Integer.parseInt(workplaceNo));

		ModelAndView mav = new ModelAndView();
		mav.addObject("reservationList", reservationList);
		mav.setViewName("jsonView");

		return mav;
	}
	
	/**
	 * 검색 옵션별 예약 목록 조회
	 * 
	 * @param workplaceNo	검색할 지사 번호
	 * @param departmentNo	검색할 부서 번호
	 * @param startDate		검색할 시작 날짜
	 * @param endDate		검색할 종료 날짜
	 * @return
	 */
	@RequestMapping(value = "/getSearchList", method = RequestMethod.POST)
	public ModelAndView getSearchList(String workplaceNo, String departmentNo, String startDate, String endDate) {

		Map<String, Object> searchMap = new HashMap<>();
		searchMap.put("workplaceNo", workplaceNo);
		searchMap.put("departmentNo", departmentNo);
		searchMap.put("startDate", startDate);
		searchMap.put("endDate", endDate);
		
		List<Map<String, Object>> searchList = service.getSearchList(searchMap);

		ModelAndView mav = new ModelAndView();
		mav.addObject("searchList", searchList);
		mav.setViewName("jsonView");

		return mav;
	}
	
	/**
	 * 지사별 회의실 목록 조회
	 * 
	 * @param workplaceNo	조회할 지사
	 * @return
	 */
	@RequestMapping(value = "/getRoomListByWorkplaceNo", method = RequestMethod.POST)
	public ModelAndView getRoomListByWorkplaceNo(String workplaceNo) {

		List<RoomDTO> roomList = service.getRoomListByWorkplaceNo(Integer.parseInt(workplaceNo));

		ModelAndView mav = new ModelAndView();
		mav.addObject("roomList", roomList);
		mav.setViewName("jsonView");

		return mav;
	}
	
}
