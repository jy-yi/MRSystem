package com.gsitm.mrs.user.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gsitm.mrs.user.dao.UserDAO;
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

}
