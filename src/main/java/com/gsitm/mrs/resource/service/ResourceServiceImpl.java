package com.gsitm.mrs.resource.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gsitm.mrs.resource.dao.ResourceDAO;
import com.gsitm.mrs.resource.dto.EquipmentDTO;
import com.gsitm.mrs.resource.dto.WorkplaceDTO;

/**
 * ResourceService 인터페이스 구현 클래스
 * 
 * @Package : com.gsitm.mrs.resource.service
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
@Service
public class ResourceServiceImpl implements ResourceService {

	@Inject
	private ResourceDAO dao;
	
	/** 지사 목록 조회 */
	@Override
	public List<WorkplaceDTO> getWorkplaceList() {
		return dao.getWorkplaceList();
	}

	/** 비품 목록 조회 */
	@Override
	public List<Map<String, Object>> getEquipmentList() {
		return dao.getEquipmentList();
	}

	/** 지사 추가 */
	@Override
	public void addWorkplace(WorkplaceDTO workplaceDTO) {
		dao.addWorkplace(workplaceDTO);
	}

	/** 지사 수정 */
	@Override
	public void editWorkplace(WorkplaceDTO workplaceDTO) {
		dao.editWorkplace(workplaceDTO);
	}

	/** 비품 추가*/
	@Override
	public void addEquipment(EquipmentDTO equipmentDTO) {
		dao.addEquipment(equipmentDTO);
	}
	
	/** 비품 추가를 위한 지사 및 회의실 정보 조회 */
	@Override
	public List<Map<String, Object>> getRoomListForEquipment() {
		return dao.getRoomListForEquipment();
	}

	/** 비품 삭제 */
	@Override
	public void deleteEquipment(int equipmentNo) {
		dao.deleteEquipment(equipmentNo);
	}


}
