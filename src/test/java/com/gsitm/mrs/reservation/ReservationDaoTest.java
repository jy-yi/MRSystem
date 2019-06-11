package com.gsitm.mrs.reservation;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
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
import com.gsitm.mrs.user.dto.EmployeeDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ReservationDaoTest {
	
	@Inject
	private ReservationDAO dao;
	
	Logger logger = Logger.getLogger(ReservationDaoTest.class);
	
	/*********** 사용자 ************/
	
	/** 예약 캘린더 조회 테스트 */
	@Test
	public void TestReservationInfo() {
		
		List<Map<String, Object>> list = dao.getReservationInfo("it1228");
		
		for (Map<String, Object> map : list) {
			logger.info(map);
		}
	}
	
	/** 예약 리스트 조회 테스트 */
	@Test
	public void TestReservationList() {
		
		List<Map<String, Object>> list = dao.getReservationList("it1228");
		
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
	
	/** 초성에 해당하는 사원 정보 조회 테스트 */
	@Test
	public void getEmployeeListByChosung() {
		List<Map<String, Object>> list=dao.getEmployeeListByChosung("ㄱ");
		for(Map<String, Object> map:list) {
			logger.info(map.toString());
		}
	}
	
	/** 검색 키워드에 해당하는 사원 목록 조회 테스트 */
	@Test
	public void getEmployeeListBySearching() {
		List<Map<String, Object>> list=dao.getEmployeeListBySearching("김");
		for(Map<String, Object> map:list) {
			logger.info(map.toString());
		}
	}
	
	/** 사원들의 부서 목록 조회 테스트 */
	@Test
	public void getDepartmentList() {
		String[] strArr= {"it1226", "it1227"};
		List<String> participation=new ArrayList<>(Arrays.asList(strArr));
		List<Map<String, Object>> list=dao.getDepartmentList(participation);
		logger.info(list.toString());
	}
	
	/*********** 관리자 ************/
	
	/** 승인 대기 목록 조회 테스트 */
	@Test
	public void TestWaitingList() {
		
		List<Map<String, Object>> list = dao.getWaitingList();
		
		for (Map<String, Object> map : list) {
			logger.info(map);
		}
		
	}

	
	/** 승인 반려 목록 조회 테스트 */
	@Test
	public void TestApprovalCancelList() {
		
		List<Map<String, Object>> list = dao.getApprovalCancelList();
		
		for (Map<String, Object> map : list) {
			logger.info(map);
		}
		
	}
	
	/** 예약 완료 목록 조회 테스트 */
	@Test
	public void TestSuccessList() {
		
		List<Map<String, Object>> list = dao.getSuccessList();
		
		for (Map<String, Object> map : list) {
			logger.info(map);
		}
		
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date date = new Date();
		String today = dateFormat.format(date);
		
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = list.get(i);
			String startDate = (String) map.get("STARTDATE");
			String endDate = (String) map.get("ENDDATE");
			
			if (today.compareTo(startDate) < 0) {
				map.put("STATUS", 0);	// 미사용
			}
			
			if (today.compareTo(startDate) > 0 && today.compareTo(endDate) < 0) {
				map.put("STATUS", 1);	// 사용 중
			}
			
			if (today.compareTo(endDate) > 0) {
				map.put("STATUS", 2);	// 사용 완료
			}
		}
		
		System.out.println("----------------------");
		
		for (Map<String, Object> map : list) {
			logger.info(map.get("STATUS"));
		}
		
	}
	
	/** 예약 취소 목록 조회 테스트 */
	@Test
	public void TestReservationCancelList() {
		
		List<Map<String, Object>> list = dao.getReservationCancelList();
		
		for (Map<String, Object> map : list) {
			logger.info(map);
		}
		
	}
	
}
