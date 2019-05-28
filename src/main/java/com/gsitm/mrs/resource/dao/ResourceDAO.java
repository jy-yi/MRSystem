package com.gsitm.mrs.resource.dao;

import java.util.List;

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

}
