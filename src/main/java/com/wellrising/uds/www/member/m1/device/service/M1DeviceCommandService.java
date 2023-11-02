package com.wellrising.uds.www.member.m1.device.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.wellrising.uds.core.service.AbstractService;

@Service
public class M1DeviceCommandService extends AbstractService {
	private static final Logger log = LoggerFactory.getLogger(M1DeviceCommandService.class);

	public List<Map> selectCommandDeviceList(Map<String, Object> params) throws Exception{
		// TODO Auto-generated method stub
		return dao.selectList("m1DeviceCommand.selectCommandDeviceList", params);
	}

	public void insertCommandDevice(Map<String, Object> params) {
		// TODO Auto-generated method stub
		params.put("no", "1");
		dao.insert("m1DeviceCommand.insertCommandDevice", params);
	}

}
