package com.gsitm.mrs.resource.dto;

/**
 * 지사 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.resource.dto
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public class WorkplaceDTO {

	private int workplaceNo;
	private String name;
	private String address;

	public WorkplaceDTO() {
	}

	public WorkplaceDTO(int workplaceNo, String name, String address) {
		this.workplaceNo = workplaceNo;
		this.name = name;
		this.address = address;
	}

	public int getWorkplace() {
		return workplaceNo;
	}

	public void setWorkplace(int workplaceNo) {
		this.workplaceNo = workplaceNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "WorkplaceDTO [workplaceNo=" + workplaceNo + ", name=" + name + ", address=" + address + "]";
	}

}
