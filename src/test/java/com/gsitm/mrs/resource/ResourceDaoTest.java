package com.gsitm.mrs.resource;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gsitm.mrs.resource.dao.ResourceDAO;
import com.gsitm.mrs.resource.dto.EquipmentDTO;
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
}
