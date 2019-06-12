package com.gsitm.mrs.statistic;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gsitm.mrs.resource.dto.RoomDTO;
import com.gsitm.mrs.statistic.dao.StatisticDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class StatisticDaoTest {
	
	@Inject
	private StatisticDAO dao;
	
	Logger logger = Logger.getLogger(StatisticDaoTest.class);
	
	
	/** 지사 별 전체 예약 현황 조회 테스트 */
	@Test
	public void TestReservationList() {
		
		List<Map<String, Object>> list = dao.getReservationList(2);
		
		for (Map<String, Object> map : list) {
			logger.info(map);
		}
	}
	
	/** 지사별 회의실 목록 조회 테스트 */
	@Test
	public void TestRoomList() {
		List<RoomDTO> list = dao.getRoomListByWorkplaceNo(1);
		
		for (RoomDTO roomDTO : list) {
			logger.info(roomDTO);
		}
	}
	
}
