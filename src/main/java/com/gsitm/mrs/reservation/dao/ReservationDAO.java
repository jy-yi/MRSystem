package com.gsitm.mrs.reservation.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.gsitm.mrs.reservation.dto.ReservationDTO;
import com.gsitm.mrs.user.dto.EmployeeDTO;


/**
 * 예약 관련 DB에서 데이터를 가져와 모델 생성
 * 
 * @Package : com.gsitm.mrs.reservation.dao
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public interface ReservationDAO {
	
	/* ------------- 사용자 ------------- */
	
	/** 마이페이지 예약 현황 캘린더 */
	public List<Map<String, Object>> getReservationInfo(String employeeNo);
	
	/** 마이페이지 캘린더 상세 조회 */
	public List<ReservationDTO> getCalendarInfo(int reservationNo);
	
	/** 마이페이지 예약 현황 리스트*/
	public List<Map<String, Object>> getReservationList(String employeeNo);
	
	/** 마이페이지 목록형 예약 취소 */
	public void deleteReservation(int reservationNo);
	
	/** 회의실 목록 조회 */
	public List<Map<String, Object>> getRoomList(int workplaceNo);
	
	/** 회의실 정보 조회 */
	public Map<String, Object> getRoomInfo(int roomNo);
	
	/** 회의실 비품 목록 조회 */
	public List<Map<String, Object>> getEquipmentList(int roomNo);
	
	/** 사원 정보 조회 */
	public EmployeeDTO getEmployeeInfo(String employeeNo);
	
	/** 초성에 해당하는 사원 목록 조회 */
	public List<Map<String, Object>> getEmployeeListByChosung(String chosung);

	/** 검색 키워드에 해당하는 사원 목록 조회 */
	public List<Map<String, Object>> getEmployeeListBySearching(String keyword);
	
	/** 사원들의 부서 정보 조회 */
	public List<Map<String, Object>> getDepartmentList(List<String> participation);
	
	/* ------------- 관리자 ------------- */
	
	/** 승인 대기 목록 조회 */
	public List<Map<String, Object>> getWaitingList();
	
	/** 승인 반려 목록 조회 */
	public List<Map<String, Object>> getApprovalCancelList();
	
	/** 예약 완료 목록 조회 */
	public List<Map<String, Object>> getSuccessList();

	

}
