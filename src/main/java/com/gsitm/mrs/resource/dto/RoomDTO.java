package com.gsitm.mrs.resource.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 회의실 관련 객체 선언 및 getter(), setter() 메소드 정의
 * 
 * @Package : com.gsitm.mrs.resource.dto
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class RoomDTO {

	private int roomNo;
	private int workplaceNo;
	private String name;
	private String type;
	private int capacity;
	private String nwAvailable;
	private String image;
	private String adminId;

}
