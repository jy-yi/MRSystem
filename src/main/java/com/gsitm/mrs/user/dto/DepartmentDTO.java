package com.gsitm.mrs.user.dto;

/**
 * 부서 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.user.dto
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public class DepartmentDTO {

	private String name;
	private int departmentNo;
	

	public DepartmentDTO() {}

	public DepartmentDTO(int departmentNo, String name) {
		this.departmentNo = departmentNo;
		this.name = name;
	}

	public int getDepartmentNo() {
		return departmentNo;
	}

	public void setDepartmentNo(int departmentNo) {
		this.departmentNo = departmentNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "DepartmentDTO [departmentNo=" + departmentNo + ", name=" + name + "]";
	}

}
