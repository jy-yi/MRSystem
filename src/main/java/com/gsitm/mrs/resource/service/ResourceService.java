package com.gsitm.mrs.resource.service;

import java.util.List;
import java.util.Map;

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
	
	/** 지사 목록 조회 */
	public List<WorkplaceDTO> getWorkplaceList();
	
	/** 비품 목록 조회 */
	public List<Map<String, Object>> getEquipmentList();

	/** 지사 추가 */
	public void addWorkplace(WorkplaceDTO workplaceDTO);
	
	/** 지사 수정 */
	public void editWorkplace(WorkplaceDTO workplaceDTO);
	
	/** 비품 추가*/
	public void addEquipment(EquipmentDTO equipmentDTO);
	
	/** 비품 추가를 위한 지사 및 회의실 정보 조회 */
	public List<Map<String, Object>> getRoomListForEquipment();
}
