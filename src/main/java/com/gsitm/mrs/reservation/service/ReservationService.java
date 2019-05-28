package com.gsitm.mrs.reservation.service;

import java.util.List;
import java.util.Map;

/**
 * 예약 관련 인터페이스 정의
 * 
 * @Package : com.gsitm.mrs.reservation.service
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public interface ReservationService {
	
	/** 승인 대기 목록 조회 */
	public List<Map<String, Object>> getWaitingList();

}
