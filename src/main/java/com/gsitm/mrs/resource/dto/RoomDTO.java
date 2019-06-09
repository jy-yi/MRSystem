package com.gsitm.mrs.resource.dto;

/**
 * 회의실 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.resource.dto
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public class RoomDTO {

	private int roomNo;
	private int workplaceNo;
	private String name;
	private int capacity;
	private String nwAvailable;
	private String image;
	private String adminId;

	public RoomDTO() {}

	public RoomDTO(int roomNo, int workplaceNo, String name, int capacity, String nwAvailable, String image, String adminId) {
		this.roomNo = roomNo;
		this.workplaceNo = workplaceNo;
		this.name = name;
		this.capacity = capacity;
		this.nwAvailable = nwAvailable;
		this.image = image;
		this.adminId = adminId;
	}

	public int getRoomNo() {
		return roomNo;
	}

	public void setRoomNo(int roomNo) {
		this.roomNo = roomNo;
	}

	public int getWorkplaceNo() {
		return workplaceNo;
	}

	public void setWorkplaceNo(int workplaceNo) {
		this.workplaceNo = workplaceNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

	public String getNwAvailable() {
		return nwAvailable;
	}

	public void setNwAvailable(String nwAvailable) {
		this.nwAvailable = nwAvailable;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}
	
	public String getAdminId() {
		return adminId;
	}

	public void setAdminId(String adminId) {
		this.adminId = adminId;
	}

	@Override
	public String toString() {
		return "RoomDTO [roomNo=" + roomNo + ", workplaceNo=" + workplaceNo + ", name=" + name + ", capacity="
				+ capacity + ", nwAvailable=" + nwAvailable + ", image=" + image + ", adminId=" + adminId + "]";
	}

}
