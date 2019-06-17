package com.gsitm.mrs.statistic.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gsitm.mrs.resource.dto.RoomDTO;
import com.gsitm.mrs.statistic.dao.StatisticDAO;

/**
 * StatisticService 인터페이스 구현 클래스
 * 
 * @Package : com.gsitm.mrs.statistic.service
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
@Service
public class StatisticServiceImpl implements StatisticService {
	
	@Inject
	private StatisticDAO dao;
	
	/* ------------- 사용자 ------------- */
	
	/** 마이페이지 개인 예약 통계 */ 
	@Override
	public Map<String, Object> getIndividual(String employeeNo) {
		return dao.getIndividual(employeeNo);
	}
	
	/** 마이페이지 개인 날짜 예약 통계 */ 
	@Override
	public Map<String, Object> getIndividualDate(Map<String, Object> searchMap) {
		return dao.getIndividualDate(searchMap);
	}
	
	/** 마이페이지 소속 부서 예약 통계 */ 
	public Map<String, Object> getDepartment(String employeeNo) {
		return dao.getDepartment(employeeNo);
	}
	
	/** 마이페이지 소속 부서 날짜 예약 통계 */ 
	@Override
	public Map<String, Object> getDepartmentDate(Map<String, Object> searchMap) {
		return dao.getDepartmentDate(searchMap);
	}

	/** 마이페이지 전쳬 예약 통계 */
	@Override
	public List<Map<String, Object>> getUserAllList(String employeeNo) {
		return dao.getUserAllList(employeeNo);
	}
	
	/** 마이페이지 날짜 검색 */
	@Override
	public List<Map<String, Object>> getUserSearchList(Map<String, Object> searchMap) {
		return dao.getUserSearchList(searchMap);
	}
	
	/* ------------- 관리자 ------------- */

	/** 지사 별 전체 예약 현황 조회 */
	@Override
	public List<Map<String, Object>> getReservationList(int workplaceNo) {
		return dao.getReservationList(workplaceNo);
	}

	/** 지사 별 예약 현황 검색 */
	@Override
	public List<Map<String, Object>> getSearchList(Map<String, Object> searchMap) {
		return dao.getSearchList(searchMap);
	}

	/** 지사별 회의실 목록 조회 */
	@Override
	public List<RoomDTO> getRoomListByWorkplaceNo(int workplaceNo) {
		return dao.getRoomListByWorkplaceNo(workplaceNo);
	}

	

	

}
