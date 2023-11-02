package com.wellrising.uds.www.member.m1.device.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class M1DeviceListService extends AbstractService {
	private static final Logger log = LoggerFactory.getLogger(M1DeviceListService.class);

	public List<Map> selectRouterList() throws Exception {
		List result = dao.selectList("m1DeviceList.selectRouterList");

		return result;
	}
	public List<Map> selectClientList(String filter) throws Exception {
		List result = dao.selectList("m1DeviceList.selectClientList", filter);

		return result;
	}
	public List<Map> selectRouterDataList(Map params) {
		// TODO Auto-generated method stub
		return dao.selectList("m1DeviceList.selectRouterDataList", params);
	}
	public List<Map> selectDeviceList() {
		// TODO Auto-generated method stub
		return dao.selectList("m1DeviceList.selectDeviceList");
	}



}
