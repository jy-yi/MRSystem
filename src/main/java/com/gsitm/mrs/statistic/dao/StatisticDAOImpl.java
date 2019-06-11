package com.gsitm.mrs.statistic.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

/**
 * StatisticDAO 인터페이스를 구현하는 클래스
 * 
 * @Package : com.gsitm.mrs.statistic.dao
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
@Repository
public class StatisticDAOImpl implements StatisticDAO {

	@Inject
	private SqlSession sqlSession;

	private static String namespace = "com.gsitm.mrs.mappers.StatisticMapper";

	
	/* ------------- 관리자 ------------- */
	
	/** 지사 별 전체 예약 현황 조회 */
	@Override
	public List<Map<String, Object>> getReservationList(int workplaceNo) {
		return sqlSession.selectList(namespace + ".getReservationList", workplaceNo);
	}

	/** 지사 별 예약 현황 검색 */
	@Override
	public List<Map<String, Object>> getSearchList(Map<String, Object> searchMap) {
		return sqlSession.selectList(namespace + ".getSearchList", searchMap);
	}
}
