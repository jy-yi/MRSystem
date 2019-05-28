package com.gsitm.mrs.reservation.dto;

/**
 * 
 * @Package : com.gsitm.mrs.reservation.dto
 * @date : 2019. 5. 28.
 * @author : 이종윤
 */
public class WaitingDTO {

	private int reservationNo;
	private String managerApproval;
	private String adminApproval;

	public WaitingDTO() {}

	public WaitingDTO(int reservationNo, String managerApproval, String adminApproval) {
		this.reservationNo = reservationNo;
		this.managerApproval = managerApproval;
		this.adminApproval = adminApproval;
	}

	public int getReservationNo() {
		return reservationNo;
	}

	public void setReservationNo(int reservationNo) {
		this.reservationNo = reservationNo;
	}

	public String getManagerApproval() {
		return managerApproval;
	}

	public void setManagerApproval(String managerApproval) {
		this.managerApproval = managerApproval;
	}

	public String getAdminApproval() {
		return adminApproval;
	}

	public void setAdminApproval(String adminApproval) {
		this.adminApproval = adminApproval;
	}

	@Override
	public String toString() {
		return "WaitingDTO [reservationNo=" + reservationNo + ", managerApproval=" + managerApproval + ", adminApproval=" + adminApproval + "]";
	}

}
