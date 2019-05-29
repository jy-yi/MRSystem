package com.gsitm.mrs.reservation.dto;

import java.util.Date;

/**
 * 예약 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.reservation.dto
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public class ReservationDTO {

	private int reservationNo;
	private String employeeNo;
	private int roomNo;
	private String name;
	private String purpose;
	private String startDate;
	private String endDate;
	private String snackWant;
	private int status;

	public ReservationDTO() {}

	public ReservationDTO(int reservationNo, String employeeNo, int roomNo, String name, String purpose, String startDate, String endDate, String snackWant, int status) {
		this.reservationNo = reservationNo;
		this.employeeNo = employeeNo;
		this.roomNo = roomNo;
		this.name = name;
		this.purpose = purpose;
		this.startDate = startDate;
		this.endDate = endDate;
		this.snackWant = snackWant;
		this.status = status;
	}

	public int getReservationNo() {
		return reservationNo;
	}

	public void setReservationNo(int reservationNo) {
		this.reservationNo = reservationNo;
	}

	public String getEmployeeNo() {
		return employeeNo;
	}

	public void setEmployeeNo(String employeeNo) {
		this.employeeNo = employeeNo;
	}

	public int getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getSnackWant() {
		return snackWant;
	}

	public void setSnackWant(String snackWant) {
		this.snackWant = snackWant;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "ReservationDTO [reservationNo=" + reservationNo + ", employeeNo=" + employeeNo + ", roomNo=" + roomNo
				+ ", name=" + name + ", purpose=" + purpose + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", snackWant=" + snackWant + ", status=" + status + "]";
	}

}
