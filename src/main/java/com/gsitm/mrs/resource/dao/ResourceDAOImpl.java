package com.gsitm.mrs.resource.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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
}
