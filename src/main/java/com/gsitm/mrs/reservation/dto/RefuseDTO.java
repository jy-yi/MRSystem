package com.gsitm.mrs.reservation.dto;

/**
 * 예약 반려 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.reservation.dto
 * @date : 2019. 5. 28.
 * @author : 이종윤
 */
public class RefuseDTO {

	private int reservationNo;
	private String reason;

	public RefuseDTO() {}

	public RefuseDTO(int reservationNo, String reason) {
		this.reservationNo = reservationNo;
		this.reason = reason;
	}

	public int getReservationNo() {
		return reservationNo;
	}

	public void setReservationNo(int reservationNo) {
		this.reservationNo = reservationNo;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	@Override
	public String toString() {
		return "RefuseDTO [reservationNo=" + reservationNo + ", reason=" + reason + "]";
	}

}
