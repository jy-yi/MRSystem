package com.gsitm.mrs.reservation.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gsitm.mrs.reservation.dto.ReservationDTO;

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
	
	/** 마이페이지 예약현황 조회 */
	@Override
	public List<Map<String, Object>> getReservationInfo(String employeeNo) {
		return sqlSession.selectList(namespace +".getReservationInfo", employeeNo);
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

	/* ------------- 관리자 ------------- */
	
	/** 승인 대기 목록 조회 */
	@Override
	public List<Map<String, Object>> getWaitingList() {
		return sqlSession.selectList(namespace + ".getWaitingList");
	}

}
