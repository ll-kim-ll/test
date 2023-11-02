package com.wellrising.uds.www.admin.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class WREnvironmentBaseService extends AbstractService {
	private static final Logger log = LoggerFactory.getLogger(WREnvironmentBaseService.class);

	public List<Map> selectEnvironmentBaseList(Map<String, Object> params) throws Exception{
		// TODO Auto-generated method stub
		return dao.selectList("wREnvironmentBase.selectEnvironmentBaseList", params);
	}


	public void insertEnvironmentBase(Map<String, Object> params) throws Exception{
		// TODO Auto-generated method stub

		dao.insert("wREnvironmentBase.insertEnvironmentBase", params);
	}


	public void deleteEnvironmentBase(Map<String, Object> params) {
		// TODO Auto-generated method stub
		dao.insert("wREnvironmentBase.deleteEnvironmentBase", params);
	}


}
