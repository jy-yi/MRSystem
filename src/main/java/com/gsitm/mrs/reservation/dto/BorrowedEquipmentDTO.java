package com.gsitm.mrs.reservation.dto;

/**
 * 대여물품 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.reservation.dto
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public class BorrowedEquipmentDTO {

	private int equipmentNo;
	private int reservationNo;

	public BorrowedEquipmentDTO() {}

	public BorrowedEquipmentDTO(int equipmentNo, int reservationNo) {
		this.equipmentNo = equipmentNo;
		this.reservationNo = reservationNo;
	}

	public int getEquipmentNo() {
		return equipmentNo;
	}

	public void setEquipmentNo(int equipmentNo) {
		this.equipmentNo = equipmentNo;
	}

	public int getReservationNo() {
		return reservationNo;
	}

	public void setReservationNo(int reservationNo) {
		this.reservationNo = reservationNo;
	}

	@Override
	public String toString() {
		return "BorrowedEquipmentDTO [equipmentNo=" + equipmentNo + ", reservationNo=" + reservationNo + "]";
	}

}
