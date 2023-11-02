package com.wellrising.uds.www.admin.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class WRDeviceInfoService extends AbstractService {
	private static final Logger log = LoggerFactory.getLogger(WRDeviceInfoService.class);

	public List<Map> selectDeviceList(Map<String, Object> params) {
		// TODO Auto-generated method stub
		return dao.selectList("wRDeviceInfo.selectDeviceList", params);
	}

	public List<Map> selectRouterList(Map<String, Object> params) throws Exception{
		// TODO Auto-generated method stub
		return dao.selectList("wRDeviceInfo.selectRouterList", params);
	}


	public List<Map> selectClientList(Map<String, Object> params) throws Exception{
		// TODO Auto-generated method stub

		return dao.selectList("wRDeviceInfo.selectClientList", params);
	}

}
