package com.gsitm.mrs.user;

import javax.inject.Inject;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.gsitm.mrs.user.dao.UserDAO;
import com.gsitm.mrs.user.dto.EmployeeDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class UserDaoTest {
	
	@Inject
	private UserDAO dao;
	
	Logger logger = Logger.getLogger(UserDaoTest.class);
	
	/** 로그인 테스트 */
	@Test
	public void TestLogin() {
		
		EmployeeDTO employee = new EmployeeDTO("it1232", "it0003", 26, "이종윤", "1111111", "it1232@gsitm.com", "010-1111-1111");
		
		logger.info(dao.login(employee).toString());
		
	}
	
	/** 회원 정보 검색 테스트 */
	@Test
	public void TestGetInfo() {
		
		logger.info(dao.getInfo("it1232"));
		
	}
}
