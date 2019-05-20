package com.gsitm.mrs.reservation.dto;

/**
 * 주관/협조부서 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.reservation.dto
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public class LeadDepartmentDTO {

	private int reservationNo;
	private int departmentNo;
	private String isMain;

	public LeadDepartmentDTO() {}

	public LeadDepartmentDTO(int reservationNo, int departmentNo, String isMain) {
		this.reservationNo = reservationNo;
		this.departmentNo = departmentNo;
		this.isMain = isMain;
	}

	public int getReservationNo() {
		return reservationNo;
	}

	public void setReservationNo(int reservationNo) {
		this.reservationNo = reservationNo;
	}

	public int getDepartmentNo() {
		return departmentNo;
	}

	public void setDepartmentNo(int departmentNo) {
		this.departmentNo = departmentNo;
	}

	public String getIsMain() {
		return isMain;
	}

	public void setIsMain(String isMain) {
		this.isMain = isMain;
	}

	@Override
	public String toString() {
		return "LeadDepartmentDTO [reservationNo=" + reservationNo + ", departmentNo=" + departmentNo + ", isMain=" + isMain + "]";
	}

}
