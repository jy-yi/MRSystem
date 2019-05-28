package com.gsitm.mrs.resource;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gsitm.mrs.resource.dao.ResourceDAO;
import com.gsitm.mrs.resource.dto.WorkplaceDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ResourceDaoTest {
	
	@Inject
	private ResourceDAO dao;
	
	Logger logger = Logger.getLogger(ResourceDaoTest.class);
	
	/** 승인 대기 목록 조회 테스트 */
	@Test
	public void TestWaitingList() {
		
		List<WorkplaceDTO> list = dao.getWorkplaceList();
		
		for (WorkplaceDTO workplaceDTO : list) {
			logger.info(workplaceDTO);
		}
		
	}

}
