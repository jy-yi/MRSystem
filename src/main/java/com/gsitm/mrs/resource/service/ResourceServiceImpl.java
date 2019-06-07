package com.gsitm.mrs.resource.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.gsitm.mrs.reservation.dto.BorrowedEquipmentDTO;
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
	
	/* ------------- 지사 ------------- */
	
	/** 지사 목록 조회 */
	@Override
	public List<WorkplaceDTO> getWorkplaceList() {
		return dao.getWorkplaceList();
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
	
	/* ------------- 회의실 ------------- */
	
	@Override
	public List<Map<String, Object>> getRoomList() {
		return dao.getRoomList();
	}
	
	
	/* ------------- 비품 ------------- */

	/** 비품 목록 조회 */
	@Override
	public List<Map<String, Object>> getEquipmentList() {
		return dao.getEquipmentList();
	}
	
	/** 대여 비품 목록 조회 */
	@Override
	public List<BorrowedEquipmentDTO> getBorrowedEquipmentList() {
		return dao.getBorrowedEquipmentList();
	}
	
	/** 비품 목록 이름 중복제거 조회 */
	@Override
	public List<String> getEquipmentListDistinct() {
		return dao.getEquipmentListDistinct();
	}

	/** 비품 추가*/
	@Override
	public void addEquipment(EquipmentDTO equipmentDTO) {
		dao.addEquipment(equipmentDTO);
	}
	
	/** 비품 삭제 */
	@Override
	public void deleteEquipment(int equipmentNo) {
		dao.deleteEquipment(equipmentNo);
	}

	/** 비품 수정 */
	@Override
	public void editEquipment(EquipmentDTO equipmentDTO) {
		dao.editEquipment(equipmentDTO);
	}

}
