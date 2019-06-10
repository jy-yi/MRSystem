package com.gsitm.mrs.statistic.dao;

import java.util.List;
import java.util.Map;

/**
 * 통계 관련 DB에서 데이터를 가져와 모델 생성
 * 
 * @Package : com.gsitm.mrs.statistic.dao
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public interface StatisticDAO {
	
	/** 지사 별 전체 예약 현황 조회 */
	public List<Map<String, Object>> getReservationList(int workplaceNo);

}
