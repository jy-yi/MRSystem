package com.gsitm.mrs.resource.dao;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.gsitm.mrs.resource.dto.EquipmentDTO;
import com.gsitm.mrs.resource.dto.WorkplaceDTO;

/**
 * ResourceDAO 인터페이스를 구현하는 클래스
 * 
 * @Package : com.gsitm.mrs.resource.dao
 * @date : 2019. 5. 8.
 * @author : 이종윤
 */
@Repository
public class ResourceDAOImpl implements ResourceDAO {

	@Inject
	private SqlSession sqlSession;

	private static String namespace = "com.gsitm.mrs.mappers.ResourceMapper";

	/** 지사 목록 조회 */
	@Override
	public List<WorkplaceDTO> getWorkplaceList() {
		return sqlSession.selectList(namespace + ".getWorkplaceList");
	}

	/** 비품 목록 조회 */
	@Override
	public List<Map<String, Object>> getEquipmentList() {
		return sqlSession.selectList(namespace + ".getEquipmentList");
	}

	/** 지사 추가 */
	@Override
	public void addWorkplace(WorkplaceDTO workplaceDTO) {
		sqlSession.insert(namespace + ".addWorkplace", workplaceDTO);		
	}

	/** 지사 수정 */
	@Override
	public void editWorkplace(WorkplaceDTO workplaceDTO) {
		sqlSession.update(namespace + ".editWorkplace", workplaceDTO);
	}

	/** 비품 추가*/
	@Override
	public void addEquipment(EquipmentDTO equipmentDTO) {
		sqlSession.insert(namespace + ".addEquipment", equipmentDTO);		
	}

	/** 비품 추가를 위한 지사 및 회의실 정보 조회 */
	@Override
	public List<Map<String, Object>> getRoomListForEquipment() {
		return sqlSession.selectList(namespace + ".getRoomListForEquipment");
	}
}
