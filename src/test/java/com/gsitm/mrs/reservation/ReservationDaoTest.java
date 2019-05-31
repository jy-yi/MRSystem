package com.gsitm.mrs.reservation;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gsitm.mrs.reservation.dao.ReservationDAO;
import com.gsitm.mrs.reservation.dto.ReservationDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ReservationDaoTest {
	
	@Inject
	private ReservationDAO dao;
	
	Logger logger = Logger.getLogger(ReservationDaoTest.class);
	
	/** 예약 목록 조회 테스트 */
	@Test
	public void TestReservationInfo() {
		
		List<Map<String, Object>> list = dao.getReservationInfo("it1226");
		
		for (Map<String, Object> map : list) {
			logger.info(map);
		}
	}
	
	/** 승인 대기 목록 조회 테스트 */
	@Test
	public void TestWaitingList() {
		
		List<Map<String, Object>> list = dao.getWaitingList();
		
		for (Map<String, Object> map : list) {
			logger.info(map);
		}
		
	}

	/** 회의실 정보 조회 테스트 */
	@Test
	public void TestRoomInfo() {
		
		Map<String, Object> room=dao.getRoomInfo(1);
		
		logger.info(room);
		
	}
	
	/** 회의실 목록 조회 테스트 */
	@Test
	public void TestRoomList() {
		
		List<Map<String, Object>> list=dao.getRoomList(1);
		
		logger.info(dao.getRoomInfo(1));
		
	}
	
}
