package com.wellrising.uds.www.member.m1.device.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class M1DeviceCommandRouterService extends AbstractService {
	private static final Logger log = LoggerFactory.getLogger(M1DeviceCommandRouterService.class);

	public List<Map> selectCommandRouterList(Map<String, Object> params) throws Exception{
		// TODO Auto-generated method stub
		//List<Map> resultList = new HashMap<Map>();
		return dao.selectList("m1DeviceCommandRouter.selectCommandRouterList", params);
	}

	public void insertCommandRouter(Map<String, Object> params) {
		// TODO Auto-generated method stub
		dao.insert("m1DeviceCommandRouter.insertCommandRouter", params);
	}

}
