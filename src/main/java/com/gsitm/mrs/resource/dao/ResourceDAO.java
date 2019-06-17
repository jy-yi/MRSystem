package com.gsitm.mrs.resource.dao;

import java.util.List;
import java.util.Map;

import com.gsitm.mrs.reservation.dto.BorrowedEquipmentDTO;
import com.gsitm.mrs.resource.dto.EquipmentDTO;
import com.gsitm.mrs.resource.dto.RoomDTO;
import com.gsitm.mrs.resource.dto.WorkplaceDTO;

/**
 * 자원 관련 DB에서 데이터를 가져와 모델 생성
 * 
 * @Package : com.gsitm.mrs.resource.dao
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public interface ResourceDAO {
	
	/* ------------- 지사 ------------- */
	
	/** 지사 목록 조회 */
	public List<WorkplaceDTO> getWorkplaceList();
	
	/** 지사 추가 */
	public void addWorkplace(WorkplaceDTO workplaceDTO);
	
	/** 지사 수정 */
	public void editWorkplace(WorkplaceDTO workplaceDTO);
	
	/** 지사 삭제 */
	public void deleteWorkplace(int workplaceNo);
	
	
	/* ------------- 회의실 ------------- */
	
	/** 회의실 목록 조회 */
	public List<Map<String, Object>> getRoomList();
	
	/** 회의실 추가 */
	public int addRoom(RoomDTO roomDTO);
	
	/** 회의실 수정 */
	public void editRoom(RoomDTO roomDTO);
	
	/** 회의실 삭제 */
	public void deleteRoom(int roomNo);

	
	/* ------------- 비품 ------------- */
	
	/** 비품 목록 조회 */
	public List<Map<String, Object>> getEquipmentList();
	
	/** 대여 비품 목록 조회 */
	public List<BorrowedEquipmentDTO> getBorrowedEquipmentList();
	
	/** 비품 목록 이름 중복제거 조회 */
	public List<String> getEquipmentListDistinct();
	
	/** 비품 추가 */
	public void addEquipment(EquipmentDTO equipmentDTO);
	
	/** 비품 삭제 */
	public void deleteEquipment(int equipmentNo);
	
	/** 비품 수정 */
	public void editEquipment(EquipmentDTO equipmentDTO);
}
