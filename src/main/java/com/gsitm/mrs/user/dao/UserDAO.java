package com.gsitm.mrs.user.dao;

import java.util.List;
import java.util.Map;

import com.gsitm.mrs.user.dto.DepartmentDTO;
import com.gsitm.mrs.user.dto.EmployeeDTO;

/**
 * 사원 및 부서 DB에서 데이터를 가져와 모델 생성
 * 
 * @Package : com.gsitm.mrs.user.dao
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public interface UserDAO {

	/** 로그인 */
	public EmployeeDTO login (EmployeeDTO employee);
	
	/** 관리자 로그인 */
	Map<String, Object> loginAdmin (EmployeeDTO employee);

	/** 회원번호로 회원 정보 받아오기 */
	public EmployeeDTO getInfo (String employeeNo);
	
	/** 부서 목록 조회 */
	public List<DepartmentDTO> getDepartmentList();
	
	
}
