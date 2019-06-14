package com.gsitm.mrs.user.service;

import java.util.List;
import java.util.Map;

import com.gsitm.mrs.user.dto.DepartmentDTO;
import com.gsitm.mrs.user.dto.EmployeeDTO;

/**
 * 회원 관련 인터페이스 정의
 * 
 * @Package : com.gsitm.mrs.user.service
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public interface UserService {
	
	/** 로그인 */
	public EmployeeDTO login (EmployeeDTO employee);
	
	/** 관리자 로그인 */
	Map<String, Object> loginAdmin (EmployeeDTO employee);
	
	/** 회원번호로 회원 정보 받아오기 */
	public EmployeeDTO getInfo (String employeeNo);
	
	/** 부서 목록 조회 */
	public List<DepartmentDTO> getDepartmentList();
}
