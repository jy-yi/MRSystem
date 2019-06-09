package com.gsitm.mrs.reservation.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.gsitm.mrs.reservation.dto.ReservationDTO;
import com.gsitm.mrs.resource.dto.EquipmentDTO;
import com.gsitm.mrs.user.dto.EmployeeDTO;

/**
 * 예약 관련 인터페이스 정의
 * 
 * @Package : com.gsitm.mrs.reservation.service
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public interface ReservationService {
	
	/* ------------- 사용자 ------------- */
	
	/** 마이페이지 예약 현황 캘린더 */
	public List<Map<String, Object>> getReservationInfo(String employeeNo);
	
	/** 마이페이지 캘린더 상세 조회 */
	public List<ReservationDTO> getCalendarInfo(int reservationNo);
	
	/** 마이페이지 예약 현황 리스트*/
	public List<Map<String, Object>> getReservationList(String employeeNo);
	
	/** 마이페이지 목록형 예약 취소 */
	public void deleteReservation(int reservationNo);
	
	/** 회의실 정보 조회 */
	public Map<String, Object> getRoomInfo(int roomNo);

	/** 회의실 목록 조회 */
	public List<Map<String, Object>> getRoomList(int workplaceNo);
	
	/** 회의실 비품 목록 조회 */
	public List<Map<String, Object>> getEquipmentList(int roomNo);
	
	/** 사용자가 선택한 비품 목록 EquipmentDto에 담기 */
	public EquipmentDTO putIntoEuipmentDto(HttpServletRequest request);
	
	public void InputReservationInfo(HttpServletRequest request, ReservationDTO reservationDto, Model model);
	
	/** 초성에 해당하는 사원 목록 조회 */
	public List<Map<String, Object>> getEmployeeListByChosung(String chosung);

	/** 검색 키워드에 해당하는 사원 목록 조회 */
	public List<Map<String, Object>> getEmployeeListBySearching(String keyword);
	
	/* ------------- 관리자 ------------- */
	
	/** 승인 대기 목록 조회 */
	public List<Map<String, Object>> getWaitingList();
	
	/** 승인 반려 목록 조회 */
	public List<Map<String, Object>> getApprovalCancelList();
	
	/** 예약 완료 목록 조회 */
	public List<Map<String, Object>> getSuccessList();

	

}
