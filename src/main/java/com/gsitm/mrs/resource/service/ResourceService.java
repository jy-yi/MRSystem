package com.gsitm.mrs.resource.service;

import java.util.List;
import java.util.Map;

import com.gsitm.mrs.reservation.dto.BorrowedEquipmentDTO;
import com.gsitm.mrs.resource.dto.EquipmentDTO;
import com.gsitm.mrs.resource.dto.WorkplaceDTO;

/**
 * 자원 관련 인터페이스 정의
 * 
 * @Package : com.gsitm.mrs.resource.service
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public interface ResourceService {
	
	/* ------------- 지사 ------------- */
	
	/** 지사 목록 조회 */
	public List<WorkplaceDTO> getWorkplaceList();
	
	/** 지사 추가 */
	public void addWorkplace(WorkplaceDTO workplaceDTO);
	
	/** 지사 수정 */
	public void editWorkplace(WorkplaceDTO workplaceDTO);
	
	/* ------------- 회의실 ------------- */
	
	/** 회의실 목록 조회 */
	public List<Map<String, Object>> getRoomList();

	
	/* ------------- 비품 ------------- */
	
	/** 비품 목록 조회 */
	public List<Map<String, Object>> getEquipmentList();
	
	/** 대여 비품 목록 조회 */
	public List<BorrowedEquipmentDTO> getBorrowedEquipmentList();
	
	/** 비품 목록 이름 중복제거 조회 */
	public List<String> getEquipmentListDistinct();
	
	/** 비품 추가*/
	public void addEquipment(EquipmentDTO equipmentDTO);
	
	/** 비품 삭제 */
	public void deleteEquipment(int equipmentNo);
	
	/** 비품 수정 */
	public void editEquipment(EquipmentDTO equipmentDTO);
}
