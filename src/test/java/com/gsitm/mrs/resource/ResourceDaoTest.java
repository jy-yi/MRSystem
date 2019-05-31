package com.gsitm.mrs.resource;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gsitm.mrs.resource.dao.ResourceDAO;
import com.gsitm.mrs.resource.dto.EquipmentDTO;
import com.gsitm.mrs.resource.dto.RoomDTO;
import com.gsitm.mrs.resource.dto.WorkplaceDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ResourceDaoTest {
	
	@Inject
	private ResourceDAO dao;
	
	Logger logger = Logger.getLogger(ResourceDaoTest.class);
	
	/** 지사 목록 조회 테스트 */
	@Test
	public void TestWorkplaceList() {
		
		List<WorkplaceDTO> list = dao.getWorkplaceList();
		
		for (WorkplaceDTO workplaceDTO : list) {
			logger.info(workplaceDTO);
		}
		
	}
	
	/** 비품 목록 조회 테스트 */
	@Test
	public void TestEquipmentList() {
		
		List<Map<String, Object>> list = dao.getEquipmentList();
		
		for (Map<String, Object> map : list) {
			logger.info(map);
		}
		
	}
	
	/** 지사 추가 테스트 */
	@Test
	public void TestAddWorkplace() {

		dao.addWorkplace(new WorkplaceDTO(1, "GS SHOP", "서울특별시 영등포구 문래동6가 선유로 75"));
		
		logger.info("지사 추가 완료!");
		
	}

	/** 지사 수정 테스트 */
	@Test
	public void TestEditWorkplace() {

		dao.editWorkplace(new WorkplaceDTO(7, "수정수정", "수정"));
		
		logger.info("지사 수정 완료!");
		
	}
	
	/** 비품 추가 테스트 */
	@Test
	public void TestAddEquipment() {

		dao.addEquipment(new EquipmentDTO(1, 1, "에어컨", "2019-05-24"));
		
		logger.info("비품 추가 완료!");
		
	}
	
	/** 비품 추가를 위한 지사 및 회의실 정보 조회 테스트 */
	@Test
	public void TestRoomListForEquipment() {
		
		List<Map<String, Object>> list = dao.getRoomListForEquipment();
		List<Object> workplaceNameList = new ArrayList<>();
		
		for (Map<String, Object> map : list) {
			logger.info(map);
			
			Set<Map.Entry<String, Object>> entries = map.entrySet();

			for (Map.Entry<String, Object> entry : entries) {
			  System.out.print("key: "+ entry.getKey());
			  System.out.println(", Value: "+ entry.getValue());
			  
			  /* 지사 이름 중복 제거 */
			  if (entry.getKey().equals("WORKPLACENAME")) {
				  if (!workplaceNameList.contains(entry.getValue()))
					  workplaceNameList.add(entry.getValue());
			  }
			}
		}
		System.out.println("----------------------------------");
		
		for (Object object : workplaceNameList) {
			System.out.println(object);
		}
		
		System.out.println("----------------------------------");
		
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = list.get(i);
			
			Set<Map.Entry<String, Object>> entries = map.entrySet();

			for (Map.Entry<String, Object> entry : entries) {
				if (entry.getValue().equals("본사")) {
					System.out.println(map.toString());
				}
					
			}
		}
	}
}
