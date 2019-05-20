package com.gsitm.mrs.statistic.dao;

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
}
