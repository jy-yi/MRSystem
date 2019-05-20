package com.gsitm.mrs.user.dto;

/**
 * 사원 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.user.dto
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public class EmployeeDTO {

	private String empolyeeNo;
	private String managerNo;
	private int departmentNo;
	private String name;
	private String password;
	private String email;
	private String phone;

	public EmployeeDTO() {}

	public EmployeeDTO(String empolyeeNo, String managerNo, int departmentNo, String name, String password, String email, String phone) {
		this.empolyeeNo = empolyeeNo;
		this.managerNo = managerNo;
		this.departmentNo = departmentNo;
		this.name = name;
		this.password = password;
		this.email = email;
		this.phone = phone;
	}

	public String getEmpolyeeNo() {
		return empolyeeNo;
	}

	public void setEmpolyeeNo(String empolyeeNo) {
		this.empolyeeNo = empolyeeNo;
	}

	public String getManagerNo() {
		return managerNo;
	}

	public void setManagerNo(String managerNo) {
		this.managerNo = managerNo;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	@Override
	public String toString() {
		return "EmployeeDTO [empolyeeNo=" + empolyeeNo + ", managerNo=" + managerNo + ", departmentNo=" + departmentNo
				+ ", name=" + name + ", password=" + password + ", email=" + email + ", phone=" + phone + "]";
	}

}
