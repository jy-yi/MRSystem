package com.gsitm.mrs.user.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gsitm.mrs.user.dao.UserDAO;
import com.gsitm.mrs.user.dto.DepartmentDTO;
import com.gsitm.mrs.user.dto.EmployeeDTO;

/**
 * UserService 인터페이스 구현 클래스
 * 
 * @Package : com.gsitm.mrs.user.service
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
@Service
public class UserServiceImpl implements UserService {
	
	@Inject
	private UserDAO dao;

	/** 로그인 */
	@Override
	public EmployeeDTO login(EmployeeDTO employee) {
		return dao.login(employee);
	}
	
	/** 관리자 로그인 */
	@Override
	public Map<String, Object> loginAdmin(EmployeeDTO employee) {
		return dao.loginAdmin(employee);
	}

	/** 회원번호로 회원 정보 받아오기 */
	@Override
	public EmployeeDTO getInfo(String employeeNo) {
		return dao.getInfo(employeeNo);
	}

	/** 부서 목록 조회 */
	@Override
	public List<DepartmentDTO> getDepartmentList() {
		return dao.getDepartmentList();
	}
}
