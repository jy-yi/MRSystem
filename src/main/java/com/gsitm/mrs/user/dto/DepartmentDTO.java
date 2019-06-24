package com.gsitm.mrs.user.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 부서 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.user.dto
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class DepartmentDTO {

	private int departmentNo;
	private String name;
	
}
