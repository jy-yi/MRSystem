package com.gsitm.mrs.statistic.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

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

}
