package com.gsitm.mrs.reservation.dto;

/**
 * 예약 참여 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.reservation.dto
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public class ParticipationDTO {

	private String employeeNo;
	private int reservationNo;
	private int money;

	public ParticipationDTO() {}

	public ParticipationDTO(String employeeNo, int reservationNo, int money) {
		this.employeeNo = employeeNo;
		this.reservationNo = reservationNo;
		this.money = money;
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
	
	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	@Override
	public String toString() {
		return "Participation [employeeNo=" + employeeNo + ", reservationNo=" + reservationNo + ", money=" + money + "]";
	}

}
