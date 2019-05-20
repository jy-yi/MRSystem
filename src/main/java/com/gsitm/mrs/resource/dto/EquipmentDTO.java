package com.gsitm.mrs.resource.dto;

import java.util.Date;

/**
 * 비품 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.resource.dto
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public class EquipmentDTO {

	private int equipmentNo;
	private int roomNo;
	private String name;
	private Date buyDate;

	public EquipmentDTO() {}

	public EquipmentDTO(int equipmentNo, int roomNo, String name, Date buyDate) {
		this.equipmentNo = equipmentNo;
		this.roomNo = roomNo;
		this.name = name;
		this.buyDate = buyDate;
	}

	public int getEquipmentNo() {
		return equipmentNo;
	}

	public void setEquipmentNo(int equipmentNo) {
		this.equipmentNo = equipmentNo;
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

	public Date getBuyDate() {
		return buyDate;
	}

	public void setBuyDate(Date buyDate) {
		this.buyDate = buyDate;
	}

	@Override
	public String toString() {
		return "EquipmentDTO [equipmentNo=" + equipmentNo + ", roomNo=" + roomNo + ", name=" + name + ", buyDate=" + buyDate + "]";
	}

}
