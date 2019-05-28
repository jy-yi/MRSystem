package com.gsitm.mrs.user.dto;

/**
 * 관리자 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.user.dto
 * @date : 2019. 5. 28.
 * @author : 이종윤
 */
public class AdminDTO {

	private String adminId;
	private String employeeNo;
	private String password;

	public AdminDTO() {}

	public AdminDTO(String adminId, String employeeNo, String password) {
		this.adminId = adminId;
		this.employeeNo = employeeNo;
		this.password = password;
	}

	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	public String getEmployeeNo() {
		return employeeNo;
	}

	public void setEmployeeNo(String employeeNo) {
		this.employeeNo = employeeNo;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Override
	public String toString() {
		return "AdminDTO [adminId=" + adminId + ", employeeNo=" + employeeNo + ", password=" + password + "]";
	}

}
