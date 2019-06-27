package com.gsitm.mrs.reservation.dao;

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
	public Map<String, Object> getCalendarInfo(int reservationNo);
	
	/** 마이페이지 예약 현황 리스트*/
	public List<Map<String, Object>> getReservationList(String employeeNo);
	
	/** 취소 사유 추가 */
	public void insertCancel (Map<String, Object> map);
	
	/** 참여 사원 이메일 리스트 조회 */
	public List<String> getEmailList (int reservaionNo);
	
	/** 마이페이지 가장 최근 예약 표시 */
	public List<Map<String, Object>> getLatestReservation(String employeeNo);
	
	/** 대시보드 */
	public List<Map<String, Object>> getDashBoard(int roomNo);
	
	/** 시작 버튼 처리 - 승인상태 변경 */
	public void updateStart(Map<String, Object> map);
	
	/** 끝 버튼 처리 - 대여물품 삭제 */
	public void deleteBorEquip(int reservationNo);
	
	/** 회의실 목록 조회 */
	public List<Map<String, Object>> getRoomList(int workplaceNo);
	
	/** 회의실 타입 조회 */
	public String getRoomType(int roomNo);
	
	/** 회의실 비품 목록 조회 */
	public List<Map<String, Object>> getEquipmentList(int roomNo);
	
	/** 사원 정보 조회 */
	public EmployeeDTO getEmployeeInfo(String employeeNo);
	
	/** 초성에 해당하는 사원 목록 조회 */
	public List<Map<String, Object>> getEmployeeListByChosung(String chosung);

	/** 검색 키워드에 해당하는 사원 목록 조회 */
	public List<Map<String, Object>> getEmployeeListBySearching(String keyword);
	
	/** 사원들의 부서 정보 조회 */
	public List<Map<String, Object>> getDepartmentList(Map<String, Object> map);
	
	/** 사원들의 정보 조회 */
	public List<Map<String, Object>> getEmployeeList(List<String> employees);

	/** 부서번호에 해당하는 부서 정보 조회 */
	public List<Map<String, Object>> getDepartmentListByDeptNo(List<String> departmentNos);
	
	/** 비품번호에 해당하는 비품 정보 조회  */
	public List<Map<String, Object>> getEquipmentsByEquipNo(List<Integer> equipmentNos);
	
	/** 예약번호 조회 */
	public int getReservationNo();
	
	/** 예약 번호로 예약 상세 정보 조회 */
	public Map<String, Object> getReservationInfoByResNo (int reservationNo);
	
	/** 예약정보 DB에 삽입 */
	public void insertReservation(ReservationDTO reservation);
	
	/** 대기 예약 DB에 삽입 */
	public void insertWaiting(int resNo);
	
	/** 회의 참여자 DB에 삽입  */
	public void insertParticipation(Map<String, Object> participationMap);
	
	/** 회의 참여 부서 DB에 삽입 */
	public void insertParticipateDepartment(Map<String, Object> departmentMap);
	
	/** 회의 대여 비품 DB에 삽입 */
	public void insertBorrowedEquipments(Map<String, Object> borrwedEquipmentMap);
	
	/** 해당 방의 예약정보 조회 */
	public List<Map<String, Object>> getReservationsByRoomNo(int roomNo);
	
	/** 해당 날짜의 예약 정보 조회 */
 	public List<Map<String, Object>> getReservationsByDate(Map<String, Object> roomData);
 	
 	/** 해당 부서의 회의 참여자 수 조회 */
 	public int getNumOfParticipation(Map<String, Object> infoMap);

 	/** 회의실 관리자 메일 조회 */
 	public String getAdminEmail(int roomNo);
 	
 	/** 예약자의 상위결재자 정보 조회 */
 	public EmployeeDTO getMgrInfo(String empNo);
 	
 	/** 사원의 이름 조회 */
 	public String getEmpName(String empNo);
 	
 	/** 방 정보 조회 */
 	public Map<String, Object> getRoomInfo(int roomNo);
 	
 	
	/* ------------- 관리자 ------------- */
	
	/** 승인 대기 목록 조회 */
	public List<Map<String, Object>> getWaitingList();
	
	/** 예약 상태 변경 */
	public void updateStatus(Map<String, Object> map);

	/** 관리자 승인 상태 변경 */
	public void updateAdminApproval(Map<String, Object> map);
	
	/** 상위결재자 승인 상태 변경 */
	public void updateMgrApproval(Map<String, Object> map);

	/** 반려 사유 추가 */
	public void insertRefuse (Map<String, Object> map);
	
	/** 승인 반려 목록 조회 */
	public List<Map<String, Object>> getApprovalCancelList();
	
	/** 예약 완료 목록 조회 */
	public List<Map<String, Object>> getSuccessList();
	
	/** 예약 취소 목록 조회 */
	public List<Map<String, Object>> getReservationCancelList();

}
