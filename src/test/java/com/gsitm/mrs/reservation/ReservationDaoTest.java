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

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ReservationDaoTest {
	
	@Inject
	private ReservationDAO dao;
	
	Logger logger = Logger.getLogger(ReservationDaoTest.class);
	
	/** 승인 대기 목록 조회 테스트 */
	@Test
	public void TestWaitingList() {
		
		List<Map<String, Object>> list = dao.getWaitingList();
		
		for (Map<String, Object> map : list) {
			logger.info(map);
		}
		
	}

}
