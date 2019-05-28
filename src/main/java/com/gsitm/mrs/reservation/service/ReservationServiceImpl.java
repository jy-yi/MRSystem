package com.gsitm.mrs.reservation.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gsitm.mrs.reservation.dao.ReservationDAO;

/**
 * ReservationService 인터페이스 구현 클래스
 * 
 * @Package : com.gsitm.mrs.reservation.service
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
@Service
public class ReservationServiceImpl implements ReservationService {
	
	@Inject
	private ReservationDAO dao;

	/** 승인 대기 목록 조회 */
	@Override
	public List<Map<String, Object>> getWaitingList() {
		return dao.getWaitingList();
	}

}
