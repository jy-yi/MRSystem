package com.gsitm.mrs.statistic.service;

import java.util.List;
import java.util.Map;

import com.gsitm.mrs.resource.dto.RoomDTO;

/**
 * 통계 관련 인터페이스 정의
 * 
 * @Package : com.gsitm.mrs.statistic.service
 * @date : 2019. 5. 8.
 * @author : 이종윤
 * 
 * @date : 2019. 6. 14.
 * @author : 김재율
 */
public interface StatisticService {
	
	
	/* ------------- 사용자 ------------- */
	
	/** 마이페이지 개인 예약 통계 */ 
	public List<Map<String, Object>> getIndividual(String employeeNo);
	
	
	/* ------------- 관리자 ------------- */
	
	/** 지사 별 전체 예약 현황 조회 */
	public List<Map<String, Object>> getReservationList(int workplaceNo);
	
	/** 지사 별 예약 현황 검색 */
	public List<Map<String, Object>> getSearchList (Map<String, Object> searchMap);

	/** 지사별 회의실 목록 조회 */
	public List<RoomDTO> getRoomListByWorkplaceNo(int workplaceNo);
}
