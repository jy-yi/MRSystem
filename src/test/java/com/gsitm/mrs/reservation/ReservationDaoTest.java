package com.gsitm.mrs.reservation;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.sound.midi.MidiDevice.Info;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.scheduling.annotation.Scheduled;
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
	
	/** 가장 최근 예약 조회 테스트 */
	@Test
	public void TestLastestReservation() {
		
		List<Map<String, Object>> reservation = dao.getLatestReservation("it1228");
		
		for (Map<String, Object> map : reservation) {
			logger.info(map);
			
		}
	}
	
	/** 회의실 정보 조회 테스트 */
	@Test
	public void TestGetOne() {
		
		Map<String, Object> one =dao.getOne("it1226");
		
		logger.info(one);
		
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
		Integer[] deptArr= {23, 24};
		List<Integer> mainDeptList=new ArrayList<>(Arrays.asList(deptArr));
		Map<String, Object> map=new HashMap<>();
		map.put("employeeNoArr", participation);
		map.put("mainDeptList", mainDeptList);
		List<Map<String, Object>> list=dao.getDepartmentList(map);
		logger.info(list.toString());
	}
	
	/** */
	@Test
	public void TestGetReservationsByDate() {
		Map<String, Object> map=new HashMap<>();
		map.put("roomNo", 1);
		map.put("chosenDate", "2019-06-23");
		logger.info(dao.getReservationsByDate(map));
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
	
	/** 승인 반려 목록 조회 테스트 */
	@Test
	public void TestgetEmailList() {
		
		List<String> list = dao.getEmailList(1);
		
		for (String str : list) {
			logger.info(str);
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
	
	/** 사원들의 정보 조회 */
	@Test
	public void TestGetEmployeeList() {
		String[] emps= {"it1226", "it1227"};
		List<String> empNos=new ArrayList<>();
		Collections.addAll(empNos, emps);
		
		List<Map<String, Object>> maps=dao.getEmployeeList(empNos);
		for (Map<String, Object> map : maps) {
			logger.info(map);
		}
	}
	
	/** 부서번호에 해당하는 부서 정보 조회 */
	@Test
	public void TestGetDepartmentListByDeptNo() {
		String[] depts= {"23", "24"};
		List<String> departmentNos=new ArrayList<>();
		Collections.addAll(departmentNos, depts);
		
		List<Map<String, Object>> maps=dao.getDepartmentListByDeptNo(departmentNos);
		for (Map<String, Object> map : maps) {
			logger.info(map);
		}
	}
	
	/** 비품번호에 해당하는 비품 정보 조회  */
	@Test
	public void TestGetEquipmentsByEquipNo() {
		Integer[] equips= {12, 13, 14};
		List<Integer> equipNos=new ArrayList<>();
		Collections.addAll(equipNos, equips);
		
		List<Map<String, Object>> maps=dao.getEquipmentsByEquipNo(equipNos);
		for (Map<String, Object> map : maps) {
			logger.info(map);
		}
	}
	
	/** 예약번호 조회 */
	@Test
	public void testgetReservationNo() {
		logger.info(dao.getReservationNo());
	}
	
	/** 메일주소 조회 */
	@Test
	public void testgetAdminMgrEmailList() {
		Map<String, Object> map=new HashMap<>();
		map.put("empNo", "it1226");
		map.put("roomNo", 1);
		
//		logger.info(dao.getAdminMgrEmailList(map));
	}
	
	/** 매니저 메일주소 조회 */
	@Test
	public void testgetMgrEmail() {
		String empNo="it1226";
		
		logger.info(dao.getMgrEmail(empNo));
	}
	
	/** Waiting DB 데이터 삽입 테스팅  */
	@Test
	public void testInsertReservation() {
		ReservationDTO dto=new ReservationDTO();
		dto.setEmployeeNo("it1226");
		dto.setStartDate("2019-11-11 12:00");
		dto.setEndDate("2019-11-12 11:30");
		dto.setName("장기예약 테스팅");
		dto.setPurpose("기타");
		dto.setRoomNo(1);
		dto.setSnackWant("Y");
		dto.setReservationNo(9);
		
		dao.insertReservation(dto);
	}
	
	@Test
	public void testGetRoomType() {
		Map<String, Object> map =dao.getReservationInfoByResNo(1);
		logger.info(map);
	}
	
	
	
	
	
	
	
}
