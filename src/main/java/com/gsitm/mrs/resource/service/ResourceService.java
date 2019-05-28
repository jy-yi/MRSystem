package com.gsitm.mrs.resource.service;

import java.util.List;

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

}
