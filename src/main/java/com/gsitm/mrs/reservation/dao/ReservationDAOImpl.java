package com.gsitm.mrs.reservation.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gsitm.mrs.reservation.dto.ReservationDTO;
import com.gsitm.mrs.user.dto.EmployeeDTO;

/**
 * ReservationDAO 인터페이스를 구현하는 클래스
 * 
 * @Package : com.gsitm.mrs.reservation.dao
 * @date : 2019. 5. 8.
 * @author : 이종윤
 * 
 * @date : 2019. 5. 29.
 * @author : 김재율
 */
@Repository
public class ReservationDAOImpl implements ReservationDAO {

	@Inject
	private SqlSession sqlSession;

	private static String namespace = "com.gsitm.mrs.mappers.ReservationMapper";
	
	/** 마이페이지 예약 현황 캘린더 */
	@Override
	public List<Map<String, Object>> getReservationInfo(String employeeNo) {
		return sqlSession.selectList(namespace +".getReservationInfo", employeeNo);
	}
	
	/** 마이페이지 캘린더 상세 조회 */
	@Override
	public List<ReservationDTO> getCalendarInfo(int reservationNo) {
		return sqlSession.selectOne(namespace +".getCalendarInfo", reservationNo);
	}
	
	/** 마이페이지 예약 현황 리스트*/
	@Override
	public List<Map<String, Object>> getReservationList(String employeeNo) {
		return sqlSession.selectList(namespace +".getReservationList", employeeNo);
	}
	
	/** 마이페이지 목록형 예약 취소 */
	@Override
	public void deleteReservation(int reservationNo) {
		sqlSession.delete(namespace +".deleteReservation", reservationNo); 
	}
	
	/** 회의실 목록 조회 */
	@Override
	public List<Map<String, Object>> getRoomList(int workplaceNo) {
		return sqlSession.selectList(namespace + ".getRoomList", workplaceNo);
	}
	
	/** 회의실 정보 조회 */
	@Override
	public Map<String, Object> getRoomInfo(int roomNo) {
		return sqlSession.selectOne(namespace + ".getRoomInfo", roomNo);
	}

	/** 회의실 비품 목록 조회 */
	@Override
	public List<Map<String, Object>> getEquipmentList(int roomNo) {
		return sqlSession.selectList(namespace + ".getEquipmentList", roomNo);
	}

	/** 사원 정보 조회 */
	@Override
	public EmployeeDTO getEmployeeInfo(String employeeNo) {
		return sqlSession.selectOne(namespace + ".getEmployeeInfo", employeeNo);
	}
	
	/** 초성에 해당하는 사원 목록 조회 */
	@Override
	public List<Map<String, Object>> getEmployeeListByChosung(String chosung) {
		return sqlSession.selectList(namespace + ".getEmployeeListByChosung", chosung);
	}

	/** 검색 키워드에 해당하는 사원 목록 조회 */
	@Override
	public List<Map<String, Object>> getEmployeeListBySearching(String keyword) {
		System.out.println("키워드 : "+keyword);
		return sqlSession.selectList(namespace + ".getEmployeeListBySearching", keyword);
	}

	/** 사원들의 부서 정보 조회 */
	@Override
	public List<Map<String, Object>> getDepartmentList(List<String> participation) {
		return sqlSession.selectList(namespace + ".getDepartmentList", participation);
	}
	
	/* ------------- 관리자 ------------- */
	
	/** 승인 대기 목록 조회 */
	@Override
	public List<Map<String, Object>> getWaitingList() {
		return sqlSession.selectList(namespace + ".getWaitingList");
	}

	/** 승인 반려 목록 조회 */
	@Override
	public List<Map<String, Object>> getApprovalCancelList() {
		return sqlSession.selectList(namespace + ".getApprovalCancelList");
	}

	/** 예약 완료 목록 조회 */
	@Override
	public List<Map<String, Object>> getSuccessList() {
		return sqlSession.selectList(namespace + ".getSuccessList");
	}


}
