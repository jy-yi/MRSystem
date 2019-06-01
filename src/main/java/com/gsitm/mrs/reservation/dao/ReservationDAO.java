package com.gsitm.mrs.reservation.dao;

import java.util.List;
import java.util.Map;

import com.gsitm.mrs.reservation.dto.ReservationDTO;


/**
 * 예약 관련 DB에서 데이터를 가져와 모델 생성
 * 
 * @Package : com.gsitm.mrs.reservation.dao
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public interface ReservationDAO {
	
	/* ------------- 사용자 ------------- */
	
	/** 마이페이지 예약현황 조회 */
	public List<Map<String, Object>> getReservationInfo(String employeeNo);
	
	/** 회의실 목록 조회 */
	public List<Map<String, Object>> getRoomList(int workplaceNo);
	
	/** 회의실 정보 조회 */
	public Map<String, Object> getRoomInfo(int roomNo);
	
	/** 회의실 비품 목록 조회 */
	public List<Map<String, Object>> getEquipmentList(int roomNo);
	
	/* ------------- 관리자 ------------- */
	
	/** 승인 대기 목록 조회 */
	public List<Map<String, Object>> getWaitingList();
	
	/** 승인 반려 목록 조회 */
	public List<Map<String, Object>> getApprovalCancelList();
	
	/** 예약 완료 목록 조회 */
	public List<Map<String, Object>> getSuccessList();

}
