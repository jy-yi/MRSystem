package com.gsitm.mrs.reservation.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.gsitm.mrs.reservation.dto.ReservationDTO;
import com.gsitm.mrs.resource.dto.EquipmentDTO;

/**
 * 예약 관련 인터페이스 정의
 * 
 * @Package : com.gsitm.mrs.reservation.service
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public interface ReservationService {
	
	/* ------------- 사용자 ------------- */
	
	/** 마이페이지 예약현황 조회 */
	public List<Map<String, Object>> getReservationInfo(String employeeNo);
	
	/** 회의실 정보 조회 */
	public Map<String, Object> getRoomInfo(int roomNo);

	/** 회의실 목록 조회 */
	public List<Map<String, Object>> getRoomList(int workplaceNo);
	
	/** 회의실 비품 목록 조회 */
	public List<Map<String, Object>> getEquipmentList(int roomNo);
	
	/** 사용자가 선택한 비품 목록 EquipmentDto에 담기 */
	public EquipmentDTO putIntoEuipmentDto(HttpServletRequest request);
	
	/* ------------- 관리자 ------------- */
	
	/** 승인 대기 목록 조회 */
	public List<Map<String, Object>> getWaitingList();
	

}
