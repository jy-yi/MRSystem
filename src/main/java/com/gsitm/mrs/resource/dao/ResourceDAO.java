package com.gsitm.mrs.resource.dao;

import java.util.List;
import java.util.Map;

import com.gsitm.mrs.resource.dto.EquipmentDTO;
import com.gsitm.mrs.resource.dto.WorkplaceDTO;

/**
 * 자원 관련 DB에서 데이터를 가져와 모델 생성
 * 
 * @Package : com.gsitm.mrs.resource.dao
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
public interface ResourceDAO {
	
	/** 지사 목록 조회 */
	public List<WorkplaceDTO> getWorkplaceList();
	
	/** 비품 목록 조회 */
	public List<Map<String, Object>> getEquipmentList();
	
	/** 지사 추가 */
	public void addWorkplace(WorkplaceDTO workplaceDTO);
	
	/** 지사 수정 */
	public void editWorkplace(WorkplaceDTO workplaceDTO);

}
